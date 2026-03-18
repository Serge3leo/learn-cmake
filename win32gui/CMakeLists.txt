# vim:set sw=4 ts=8 et fileencoding=utf8::Кодировка:UTF-8[АБЁЪЯабёъя]
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

if (NOT WIN32)
    return ()
endif ()

if (CMAKE_C_COMPILER_ID STREQUAL OrangeC)
    set(occ_workaround occ_workarond.c)
endif ()

# https://learn.microsoft.com/en-us/cpp/text/unicode-programming-summary
# > Define the symbol `_UNICODE` before you build your program
#
# Однако, при использовании MSVC с генератором `NMake Makefiles`, как и при
# использовании `Orange C` и `Pelles C` этого недостаточно. Требуется
# определить ещё и `UNICODE`.
#
# При использовании проектов MSVC с генератором `Visual Studio NN YYYY` в
# полученных проектах уже есть определение обеих символов.

add_executable(main main.c main.rc ${occ_workaround})
target_link_libraries(main Comctl32)
set_target_properties(main PROPERTIES
                      COMPILE_DEFINITIONS "_UNICODE=1;UNICODE=1"
                      WIN32_EXECUTABLE TRUE
                      C_EXTENSIONS ON)  # For Pelles C
if ("${CMAKE_GENERATOR}" MATCHES "Makefiles")
    set(DIR "${CMAKE_CURRENT_BINARY_DIR}")
else ()
    set(DIR "${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_BUILD_TYPE}")
endif ()
add_test(NAME main
         COMMAND "${CMAKE_COMMAND}" -E chdir "${DIR}" cmd /c start /wait main)
add_test(NAME UNICODE
         COMMAND "${CMAKE_COMMAND}" -E cat "${DIR}/unicode.txt")
set_tests_properties(UNICODE PROPERTIES
                     PASS_REGULAR_EXPRESSION " UNICODE .* 1[ \r\n]")
add_test(NAME _UNICODE
         COMMAND "${CMAKE_COMMAND}" -E cat "${DIR}/unicode.txt")
set_tests_properties(_UNICODE PROPERTIES
                     PASS_REGULAR_EXPRESSION " _UNICODE .* 1[ \r\n]")

enable_testing()
