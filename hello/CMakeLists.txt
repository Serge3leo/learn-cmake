# vim:set sw=4 ts=8 et fileencoding=utf8::Кодировка:UTF-8[АБЁЪЯабёъя]
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2025 Сергей Леонтьев (leo@sai.msu.ru)

add_executable(hello hello.c)
target_compile_definitions(hello PRIVATE TEST_DEFINITIONS)
if (NOT CMAKE_C_COMPILER_ID STREQUAL PellesC)
    target_compile_definitions(hello PRIVATE TEST_DEFINITIONS_VAL="inc.h")
endif ()
add_test(NAME hello COMMAND hello)
set_tests_properties(hello PROPERTIES PASS_REGULAR_EXPRESSION "Привет мир")

if (LEARN_CMAKE_CXX_ENABLE)
    add_executable(hello++ hello++.cpp)
    add_test(NAME hello++ COMMAND hello++)
    set_tests_properties(hello++ PROPERTIES
                         PASS_REGULAR_EXPRESSION "Привет мир[+]")
endif ()

add_executable(simple_false simple_false.c)
add_test(NAME simple_false COMMAND simple_false)
set_tests_properties(simple_false PROPERTIES WILL_FAIL true)

add_executable(bsd_echo bsd_echo.c)
add_test(NAME bsd_echo COMMAND bsd_echo -n a b c)
set_tests_properties(bsd_echo PROPERTIES PASS_REGULAR_EXPRESSION "a b c")

enable_testing()
