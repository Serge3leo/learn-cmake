# vim:set sw=4 ts=8 et fileencoding=utf8::Кодировка:UTF-8[АБЁЪЯабёъя]
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

# ПРЕДУПРЕЖДЕНИЕ: 1. Этот обход надо применять дважды, до `enable_language()`,
#                    и после;
#                 2. Этот обход, в части динамических библиотек, не полон.
#                    Создание DLL, пока, исправлено только для 7.0.

if (CMAKE_C_COMPILER MATCHES "(^|[/\\])[oO][cC][cC]")
    execute_process(COMMAND "${CMAKE_C_COMPILER}" -V
                    RESULT_VARIABLE _wOrangeC_res
                    OUTPUT_VARIABLE _wOrangeC_out)
    if (NOT "${_wOrangeC_res}" EQUAL 0)
        message("OrangeC: skip ${_wOrangeC_res}:"
                " '${CMAKE_C_COMPILER}' -V")
        return ()
    endif ()
    if (NOT "${_wOrangeC_out}" MATCHES
            "Version +([0-9]+(\\.[0-9]+)+)[ \r\n]+")
        message("OrangeC: skip '${_wOrangeC_out}':"
                " '${CMAKE_C_COMPILER}' -V")
        return ()
    endif ()
    set(CMAKE_C_COMPILER_ID "OrangeC")
    set(CMAKE_C_COMPILER_VERSION "${CMAKE_MATCH_1}")

    # TODO: `--export-all-symbols` если CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS
    #set(CMAKE_SUPPORT_WINDOWS_EXPORT_ALL_SYMBOLS TRUE)
    foreach (lang IN ITEMS C CXX ASM)
        if (${CMAKE_${lang}_CREATE_SHARED_LIBRARY} MATCHES " <FLAGS> ")
            string(REPLACE " <FLAGS> "
                   # " $<IF:$<BOOL:$<TARGET_PROPERTY:WINDOWS_EXPORT_ALL_SYMBOLS>>,--export-all-symbols,> "
                   " "
                   CMAKE_${lang}_CREATE_SHARED_LIBRARY
                   ${CMAKE_${lang}_CREATE_SHARED_LIBRARY})
            # message("CMAKE_${lang}_CREATE_SHARED_LIBRARY="
            #         "'${CMAKE_${lang}_CREATE_SHARED_LIBRARY}'")
        endif ()
    endforeach ()
    # string(APPEND CMAKE_SHARED_LINKER_FLAGS
    #        "$<IF:$<BOOL:$<TARGET_PROPERTY:WINDOWS_EXPORT_ALL_SYMBOLS>>,--export-all-symbols,>")

    if(NOT CMAKE_RC_COMPILER_INIT)
        set(CMAKE_RC_COMPILER_INIT orc)
    endif()
    if(NOT CMAKE_RC_COMPILE_OBJECT)
        set(CMAKE_RC_COMPILE_OBJECT
            "<CMAKE_RC_COMPILER> -! <DEFINES> <INCLUDES> <FLAGS> -o<OBJECT> <SOURCE>")
    endif()
    if (CMAKE_PROJECT_NAME)
        enable_language(RC)
    endif ()
    if ("${CMAKE_RC_COMPILER}" MATCHES "(^|[/\\])[oO][rR][cC]")
        set(CMAKE_INCLUDE_FLAG_RC -i)
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
    # Отдельно проверим, что переменные CMAKE_${lang}_CREATE_SHARED_LIBRARY
    # для других компиляторов не содержат <FLAGS>

    foreach (lang IN ITEMS C CXX ASM)
        if (${CMAKE_${lang}_CREATE_SHARED_LIBRARY} MATCHES "<FLAGS>")
            message(FATAL_ERROR "${CMAKE_C_COMPILER_ID}: "
                "CMAKE_${lang}_CREATE_SHARED_LIBRARY="
                "'${CMAKE_${lang}_CREATE_SHARED_LIBRARY}'")
        endif ()
    endforeach ()
endif ()
