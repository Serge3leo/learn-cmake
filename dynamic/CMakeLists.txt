# vim:set sw=4 ts=8 et fileencoding=utf8::Кодировка:UTF-8[АБЁЪЯабёъя]
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)

set(HDRS dfoo.h)

add_library(dfoo SHARED ${HDRS} boo.c baz.c)
target_compile_definitions(dfoo PRIVATE RESPONSE=DFOO_DYNAMIC)

add_executable(case_dynamic ${HDRS} case_dynamic.c)
target_link_libraries(case_dynamic dfoo)
if (CMAKE_C_COMPILER_ID STREQUAL TinyCC)  # TODO: libdfoo.so: cannot open...
    add_test(NAME case_dynamic
        COMMAND env LD_LIBRARY_PATH=${CMAKE_CURRENT_BINARY_DIR} ./case_dynamic)
else ()
    add_test(NAME case_dynamic COMMAND case_dynamic)
endif ()

enable_testing()
