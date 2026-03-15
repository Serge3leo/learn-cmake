# vim:set sw=4 ts=8 et fileencoding=utf8::Кодировка:UTF-8[АБЁЪЯабёъя]
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

if (CMAKE_C_COMPILER_ID STREQUAL OrangeC)
    if (CMAKE_C_COMPILER_VERSION VERSION_GREATER_EQUAL "7.0")
        foreach (lang IN ITEMS C CXX ASM)
            if (${CMAKE_${lang}_CREATE_SHARED_LIBRARY} MATCHES " <FLAGS> ")
                string(REPLACE " <FLAGS> " " --export-all-symbols "
                       CMAKE_${lang}_CREATE_SHARED_LIBRARY
                       ${CMAKE_${lang}_CREATE_SHARED_LIBRARY})
                message("CMAKE_${lang}_CREATE_SHARED_LIBRARY="
                        "'${CMAKE_${lang}_CREATE_SHARED_LIBRARY}'")
            endif ()
        endforeach ()
    else ()
        foreach (lang IN ITEMS C CXX ASM)
            if (${CMAKE_${lang}_CREATE_SHARED_LIBRARY} MATCHES " <FLAGS> ")
                message("WARNING: <FLAGS> in "
                        "CMAKE_${lang}_CREATE_SHARED_LIBRARY="
                        "'${CMAKE_${lang}_CREATE_SHARED_LIBRARY}'")
            endif ()
        endforeach ()
    endif ()
    if (CMAKE_C_COMPILER_VERSION VERSION_GREATER_EQUAL "6.0.71")
        set(CMAKE_C23_STANDARD_COMPILE_OPTION -2)
        set(CMAKE_C23_EXTENSION_COMPILE_OPTION -2)

        set(CMAKE_C_STANDARD_LATEST 23)
    endif ()
    if (CMAKE_C_COMPILER_VERSION VERSION_GREATER_EQUAL "7.0")
        set(CMAKE_CXX17_STANDARD_COMPILE_OPTION "-std=c++17")
        set(CMAKE_CXX17_EXTENSION_COMPILE_OPTION "-std=c++17")
        set(CMAKE_CXX17_STANDARD__HAS_FULL_SUPPORT ON)

        set(CMAKE_CXX_STANDARD_LATEST 17)
    endif ()
else ()
    # Separately, check that the CMAKE_${lang}_CREATE_SHARED_LIBRARY settings
    # for other compilers don't use <FLAGS>

    foreach (lang IN ITEMS C CXX ASM)
        if (${CMAKE_${lang}_CREATE_SHARED_LIBRARY} MATCHES "<FLAGS>")
            message(FATAL_ERROR "${CMAKE_C_COMPILER_ID}: "
                "CMAKE_${lang}_CREATE_SHARED_LIBRARY="
                "'${CMAKE_${lang}_CREATE_SHARED_LIBRARY}'")
        endif ()
    endforeach ()
endif ()
