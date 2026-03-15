# vim:set sw=4 ts=8 et fileencoding=utf8::Кодировка:UTF-8[АБЁЪЯабёъя]
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

cmake_minimum_required (VERSION 3.25)
project(learn_cmake
        VERSION 0.1.0
        DESCRIPTION
        "Изучаем CMake GitHub для многих (всех) платформ"
        HOMEPAGE_URL https://github.com/Serge3leo/learn-cmake
        LANGUAGES C
)
include(workarounds/OrangeC.cmake)  # WARNING: without CMAKE_C_COMPILE_FEATURES
set(CMAKE_C_STANDARD 23)

message("CMAKE_C_COMPILE_FEATURES=${CMAKE_C_COMPILE_FEATURES}")
message("CMAKE_C_EXTENSIONS_DEFAULT=${CMAKE_C_EXTENSIONS_DEFAULT}")
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
if(WIN32 AND (LEARN_CMAKE_FORCE_WIN32 OR
   NOT CMAKE_C_COMPILER_ID STREQUAL PellesC))
    # TODO: PellesC #error: <windows.h> requires the /Ze compiler option
    add_subdirectory(win32gui)
endif ()
add_subdirectory(static)
if (LEARN_CMAKE_FORCE_DYNAMIC OR
    NOT CMAKE_C_COMPILER_ID STREQUAL PellesC)  # TODO Unknown option: /shared
    # Так же, LCC: ADD_LIBRARY called with SHARED option but the target
    # platform does not support dynamic linking.  Building a STATIC library
    # instead.
    add_subdirectory(dynamic)
else ()
    foreach (lang IN ITEMS C CXX ASM)
        message("CMAKE_${lang}_CREATE_SHARED_LIBRARY='${CMAKE_${lang}_CREATE_SHARED_LIBRARY}'")
    endforeach ()
endif ()
if(LEARN_CMAKE_FORCE_ASM OR
   NOT CMAKE_C_COMPILER_ID STREQUAL PellesC)
    add_subdirectory(asm)
endif ()

enable_testing()
