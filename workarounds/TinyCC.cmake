# vim:set sw=4 ts=8 et fileencoding=utf8::Кодировка:UTF-8[АБЁЪЯабёъя]
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

if (CMAKE_C_COMPILER_ID STREQUAL "TinyCC")
    execute_process(COMMAND "${CMAKE_C_COMPILER}" --version
                    RESULT_VARIABLE _wTinyCC_res
                    OUTPUT_VARIABLE _wTinyCC_out)
    if (NOT "${_wTinyCC_res}" EQUAL 0)
        message("TinyCC: skip ${_wTinyCC_res}:"
                " '${CMAKE_C_COMPILER}' --version")
        return ()
    endif ()
    if (NOT "${_wTinyCC_out}" MATCHES "version +([0-9]+(\\.[0-9]+)+) +")
        message("TinyCC: skip '${_wTinyCC_out}':"
                " '${CMAKE_C_COMPILER}' --version")
        return ()
    endif ()
    set(CMAKE_C_COMPILER_VERSION "${CMAKE_MATCH_1}")

    include(Compiler/CMakeCommonCompilerMacros)

    set(CMAKE_C99_STANDARD_COMPILE_OPTION -std=c99)
    set(CMAKE_C99_EXTENSION_COMPILE_OPTION -std=c99)
    set(CMAKE_C99_STANDARD__HAS_FULL_SUPPORT ON)  # TODO
    if (CMAKE_C_COMPILER_VERSION VERSION_GREATER_EQUAL "0.9.27")
        set(CMAKE_C11_STANDARD_COMPILE_OPTION "-std=c11")
        set(CMAKE_C11_EXTENSION_COMPILE_OPTION "-std=c11")
        set(CMAKE_C11_STANDARD__HAS_FULL_SUPPORT ON)  # TODO XXX
    endif ()

    set(CMAKE_C_STANDARD_DEFAULT 99)
    set(CMAKE_C_EXTENSIONS_DEFAULT ON)
endif ()
