# vim:set sw=4 ts=8 et fileencoding=utf8::Кодировка:UTF-8[АБЁЪЯабёъя]
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

set(HDRS foo.h)

add_library(foo STATIC ${HDRS} boo.c baz.c)
target_compile_definitions(foo PRIVATE RESPONSE=FOO_STATIC)

add_executable(static ${HDRS} static.c)
target_link_libraries(static foo)
add_test(NAME static COMMAND static)

enable_testing()
