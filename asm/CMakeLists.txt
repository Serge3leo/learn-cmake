# vim:set sw=4 ts=8 et fileencoding=utf8::Кодировка:UTF-8[АБЁЪЯабёъя]
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

# Конечно, для переносимого кода есть гораздо более предпочтительные варианты:
# 1. NASM (yasm, nasm);
# 2. MASM (ml).

# Но конкретно здесь, смотрим на обращение CMake к поддержке ассемблера со
# стороны компилятора C/C++.

set(HDRS foo.h)

if (CMAKE_C_COMPILER_ID STREQUAL "MSVC")
    enable_language(ASM_MASM)  # CMP0194 рекомендует использовать `ml` из VS
else ()
    enable_language(ASM)
endif ()

if (CMAKE_C_COMPILER_ID STREQUAL "LCC")
    set(ASMS foo-elbrus.s)
elseif (CMAKE_C_COMPILER_ID STREQUAL "MSVC")
    set(ASMS foo-masm64.asm)
elseif (CMAKE_C_COMPILER_ID STREQUAL "OrangeC")
    set(ASMS foo-nasm32.asm)  # OAsm ... NASM are not 100% compatible with it
elseif (CMAKE_C_COMPILER_ID STREQUAL "PellesC")
    set(ASMS foo-masm64.asm)  # similar to MASM, but there are deliberate differences
elseif (APPLE)
    if (CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64")
        set(ASMS foo-_att-x64.s)
    else ()
        return ()
    endif ()
else ()
    set(ASMS foo-att-x64.s)
endif ()

add_executable(case_asm case_asm.c ${ASMS} ${HDRS})
add_test(NAME case_asm COMMAND case_asm)

enable_testing()
