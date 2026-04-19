# vim:set sw=4 ts=8 et fileencoding=utf8::Кодировка:UTF-8[АБЁЪЯабёъя]
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2025 Сергей Леонтьев (leo@sai.msu.ru)

include(CheckFunctionExists)
check_function_exists(memcpy INACCURATE_MEMCPY)
check_function_exists(printf INACCURATE_PRINTF)
message("INACCURATE_MEMCPY=${INACCURATE_MEMCPY}")
message("INACCURATE_PRINTF=${INACCURATE_PRINTF}")
message("MSVC=${MSVC}")
message("CMAKE_C_COMPILER_ID=${CMAKE_C_COMPILER_ID}")
if ((NOT INACCURATE_MEMCPY AND NOT CMAKE_C_COMPILER_ID STREQUAL PellesC) OR
    (NOT INACCURATE_PRINTF AND NOT MSVC))
    message(FATAL_ERROR "CMAKE_C_COMPILER_ID=${CMAKE_C_COMPILER_ID}"
            " HAVE_PRINTF=${HAVE_PRINTF}"
            " INACCURATE_MEMCPY=${INACCURATE_MEMCPY}")
endif ()

include(CheckSymbolExists)
check_symbol_exists(memcpy "string.h" HAVE_MEMCPY)
check_symbol_exists(printf "stdio.h" HAVE_PRINTF)
message("HAVE_MEMCPY=${HAVE_MEMCPY}")
message("HAVE_PRINTF=${HAVE_PRINTF}")
if (NOT HAVE_PRINTF OR NOT HAVE_MEMCPY)
    message(FATAL_ERROR "HAVE_MEMCPY=${HAVE_MEMCPY}"
            " HAVE_PRINTF=${HAVE_PRINTF}")
endif ()

if (LEARN_CMAKE_CXX_ENABLE)
    include(CheckCXXSymbolExists)
    check_cxx_symbol_exists(std::memcpy "cstring" HAVE_STD_MEMCPY)
    message("HAVE_STD_MEMCPY=${HAVE_STD_MEMCPY}")
    if (NOT HAVE_STD_MEMCPY)
        message(FATAL_ERROR "HAVE_STD_MEMCPY=${HAVE_STD_MEMCPY}")
    endif ()
endif ()

include(CheckTypeSize)
check_type_size("double" SIZEOF_DOUBLE)
check_type_size("long double" SIZEOF_LONG_DOUBLE)
message("SIZEOF_DOUBLE=${SIZEOF_DOUBLE}")
message("SIZEOF_LONG_DOUBLE=${SIZEOF_LONG_DOUBLE}")
if (NOT SIZEOF_DOUBLE OR NOT SIZEOF_LONG_DOUBLE OR
    (NOT SIZEOF_DOUBLE LESS SIZEOF_LONG_DOUBLE AND
     NOT CMAKE_C_COMPILER_ID MATCHES "(MSVC|OrangeC|PellesC)" AND
     NOT CMAKE_SYSTEM_PROCESSOR MATCHES "arm"))
    message(FATAL_ERROR "CMAKE_C_COMPILER_ID=${CMAKE_C_COMPILER_ID}"
            " CMAKE_SYSTEM_PROCESSOR=${CMAKE_SYSTEM_PROCESSOR}"
            " SIZEOF_DOUBLE=${SIZEOF_DOUBLE}"
            " SIZEOF_LONG_DOUBLE=${SIZEOF_LONG_DOUBLE}")
endif ()

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
