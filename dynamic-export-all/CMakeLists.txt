# vim:set sw=4 ts=8 et fileencoding=utf8::Кодировка:UTF-8[АБЁЪЯабёъя]
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

# LCC: ADD_LIBRARY called with SHARED option but the target platform does not
# support dynamic linking.  Building a STATIC library instead.

if (WIN32 AND NOT CMAKE_SUPPORT_WINDOWS_EXPORT_ALL_SYMBOLS)
    message("WARNING: ${CMAKE_C_COMPILER_ID}: don't support"
            " CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS, skipped")
    return ()
endif ()

set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)

set(HDRS afoo.h)

add_library(afoo SHARED ${HDRS} boo.c baz.c noe.c)

add_executable(case_adynamic ${HDRS} case_dynamic.c)
target_link_libraries(case_adynamic afoo)
if (CMAKE_C_COMPILER_ID STREQUAL TinyCC)  # TODO: libafoo.so: cannot open...
    message("${CMAKE_C_COMPILER_ID}: WARNING: need set LD_LIBRARY_PATH")
    add_test(NAME case_adynamic
        COMMAND env LD_LIBRARY_PATH=${CMAKE_CURRENT_BINARY_DIR} ./case_adynamic)
else ()
    add_test(NAME case_adynamic COMMAND case_adynamic)
endif ()

enable_testing()
