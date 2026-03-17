# vim:set sw=4 ts=8 et fileencoding=utf8::Кодировка:UTF-8[АБЁЪЯабёъя]
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

include(workarounds/LCC.cmake OPTIONAL)
include(workarounds/OrangeC.cmake OPTIONAL)  # Обход CMAKE_C_COMPILE_FEATURES
include(workarounds/TinyCC.cmake OPTIONAL)

cmake_minimum_required (VERSION 3.25)
project(learn_cmake
        VERSION 0.1.0
        DESCRIPTION
        "Изучаем CMake GitHub для многих (всех) платформ"
        HOMEPAGE_URL https://github.com/Serge3leo/learn-cmake
        LANGUAGES C
)

if ("$ENV{VERBOSE}")
    get_cmake_property(_variableNames VARIABLES)
    list (SORT _variableNames)
    foreach (_variableName ${_variableNames})
        message(STATUS "${_variableName}=${${_variableName}}")
    endforeach()
endif ()

include(workarounds/OrangeC.cmake OPTIONAL)  # Обход DLL

set(CMAKE_C_STANDARD 23)

message("CMAKE_C_COMPILE_FEATURES=${CMAKE_C_COMPILE_FEATURES}")
message("CMAKE_C_EXTENSIONS_DEFAULT=${CMAKE_C_EXTENSIONS_DEFAULT}")
if ("$ENV{VERBOSE}")
    message("CMAKE_C_COMPILER_VERSION=${CMAKE_C_COMPILER_VERSION}")
    message("CMAKE_C_STANDARD_LATEST=${CMAKE_C_STANDARD_LATEST}")
    message("CMAKE_C_STANDARD_DEFAULT=${CMAKE_C_STANDARD_DEFAULT}")
    # cmake version 3.31.6
    # cl: c_std_90;c_function_prototypes;c_std_99;c_restrict;c_variadic_macros;c_std_11;c_static_assert;c_std_17
    #        CMAKE_C_EXTENSIONS_DEFAULT=OFF
    # icx: c_std_90;c_function_prototypes;c_std_99;c_restrict;c_variadic_macros;c_std_11;c_static_assert;c_std_17;c_std_23
    #        CMAKE_C_EXTENSIONS_DEFAULT=ON
    # lcc: c_std_90;c_function_prototypes;c_std_99;c_restrict;c_variadic_macros;c_std_11;c_static_assert;c_std_17
    #        CMAKE_C_EXTENSIONS_DEFAULT=ON
    # occ: c_std_90;c_function_prototypes;c_std_99;c_restrict;c_variadic_macros;c_std_11;c_static_assert
    # CMAKE_C_EXTENSIONS_DEFAULT=OFF
    # pocc: c_std_99;c_restrict;c_variadic_macros;c_std_11;c_static_assert;c_std_17;c_std_23
    # CMAKE_C_EXTENSIONS_DEFAULT=OFF
    # pgcc/nvc: c_std_90;c_function_prototypes;c_std_99;c_restrict;c_variadic_macros;c_std_11;c_static_assert;c_std_17
    #        CMAKE_C_EXTENSIONS_DEFAULT=ON
    # suncc: c_std_90;c_function_prototypes;c_std_99;c_restrict;c_variadic_macros;c_std_11;c_static_assert
    #        CMAKE_C_EXTENSIONS_DEFAULT=OFF
    # tcc: пусто/пусто
endif ()

option(LEARN_CMAKE_CXX_ENABLE "Разрешаем C++ (не для всех)" ON)
if (CMAKE_C_COMPILER_ID STREQUAL PellesC OR
    CMAKE_C_COMPILER_ID STREQUAL TinyCC)
    set(LEARN_CMAKE_CXX_ENABLE OFF)
endif ()
if (LEARN_CMAKE_CXX_ENABLE)
    enable_language(CXX)
    set(CMAKE_CXX_STANDARD 23)
    message("CMAKE_CXX_COMPILE_FEATURES=${CMAKE_CXX_COMPILE_FEATURES}")
    message("CMAKE_CXX_EXTENSIONS_DEFAULT=${CMAKE_CXX_EXTENSIONS_DEFAULT}")
endif ()

add_subdirectory(hello)
add_subdirectory(win32gui)
add_subdirectory(static)
add_subdirectory(dynamic)
add_subdirectory(asm)

enable_testing()
