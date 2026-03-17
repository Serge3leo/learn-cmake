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

add_library(dfoo SHARED ${HDRS} boo.c baz.c noe.c dfoo.def)

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
