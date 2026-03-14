# vim:set sw=4 ts=8 et fileencoding=utf8::Кодировка:UTF-8[АБЁЪЯабёъя]
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)

set(HDRS dfoo.h)

add_library(dfoo SHARED ${HDRS} boo.c baz.c)
target_compile_definitions(dfoo PRIVATE RESPONSE=DFOO_DYNAMIC)

add_executable(dynamic ${HDRS} dynamic.c)
target_link_libraries(dynamic dfoo)
add_test(NAME dynamic COMMAND dynamic)

enable_testing()
