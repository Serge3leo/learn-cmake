# vim:set sw=4 ts=8 et fileencoding=utf8::Кодировка:UTF-8[АБЁЪЯабёъя]
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

if (CMAKE_C_COMPILER MATCHES "lcc")
    execute_process(COMMAND "${CMAKE_C_COMPILER}" --version
                    RESULT_VARIABLE _wLCC_res
                    OUTPUT_VARIABLE _wLCC_out)
    if (NOT "${_wLCC_res}" EQUAL 0)
        message("LCC: skip ${_wLCC_res}:"
                " '${CMAKE_C_COMPILER}' --version")
        return ()
    endif ()
    if (NOT "${_wLCC_out}" MATCHES "lcc:([0-9]+(\\.[0-9]+)+):")
        message("LCC: skip '${_wLCC_out}':"
                " '${CMAKE_C_COMPILER}' --version")
        return ()
    endif ()
    set(CMAKE_C_COMPILER_ID "LCC")
    set(CMAKE_C_COMPILER_VERSION "${CMAKE_MATCH_1}")

    if (CMAKE_C_COMPILER_VERSION VERSION_GREATER_EQUAL "1.29")
        set(CMAKE_C23_STANDARD_COMPILE_OPTION "-std=c23")
        set(CMAKE_C23_EXTENSION_COMPILE_OPTION "-std=gnu23")

        set(CMAKE_C_STANDARD_LATEST 23)

        set(CMAKE_CXX23_STANDARD_COMPILE_OPTION "-std=c++23")
        set(CMAKE_CXX23_EXTENSION_COMPILE_OPTION "-std=gnu++23")
        set(CMAKE_CXX23_STANDARD__HAS_FULL_SUPPORT ON)  # TODO XXX

        set(CMAKE_CXX_STANDARD_LATEST 23)
    endif ()
endif ()
