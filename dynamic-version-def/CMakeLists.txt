# vim:set sw=4 ts=8 et fileencoding=utf8::Кодировка:UTF-8[АБЁЪЯабёъя]
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

if (CMAKE_C_COMPILER_ID STREQUAL OrangeC)
    message("WARNING: OrangeC need workaround for .def files")
    return ()
endif ()

# LCC: ADD_LIBRARY called with SHARED option but the target platform does not
# support dynamic linking.  Building a STATIC library instead.

set(HDRS dfoo.h)

if (WIN32)
    set(DEF dfoo.def)
    set(PROPS )
elseif (APPLE)
    set(DEF )
    set(PROPS
        LINK_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/dfoo.exports"
        LINK_FLAGS "-Wl,-exported_symbols_list \
                    -Wl,${CMAKE_CURRENT_SOURCE_DIR}/dfoo.exports")
else ()
    set(DEF )
    set(PROPS
        LINK_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/dfoo.vers"
        LINK_FLAGS "-Wl,--version-script=${CMAKE_CURRENT_SOURCE_DIR}/dfoo.vers")
endif ()

add_library(dfoo SHARED ${HDRS} boo.c baz.c noe.c ${DEF})
if (PROPS)
    set_target_properties(dfoo PROPERTIES ${PROPS})
endif ()

add_executable(case_ddynamic ${HDRS} case_dynamic.c)
target_link_libraries(case_ddynamic dfoo)
if (CMAKE_C_COMPILER_ID STREQUAL TinyCC)  # TODO: libdfoo.so: cannot open...
    message("${CMAKE_C_COMPILER_ID}: WARNING: need set LD_LIBRARY_PATH")
    add_test(NAME case_ddynamic
        COMMAND env LD_LIBRARY_PATH=${CMAKE_CURRENT_BINARY_DIR} ./case_ddynamic)
else ()
    add_test(NAME case_ddynamic COMMAND case_ddynamic)
endif ()

enable_testing()
