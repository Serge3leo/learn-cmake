# vim:set sw=4 ts=8 et fileencoding=utf8::Кодировка:UTF-8[АБЁЪЯабёъя]
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2025 Сергей Леонтьев (leo@sai.msu.ru)

# Конечно, для переносимого кода есть гораздо более предпочтительные варианты:
# 1. NASM (nasm);
# 2. MASM (ml).

# Но конкретно здесь, смотрим на обращение CMake к поддержке ассемблера со
# стороны компилятора C/C++.

set(HDRS foo.h)

if (CMAKE_C_COMPILER_ID STREQUAL "MSVC")
    # TODO??? cmake_policy(SET CMP0194 OLD)
    # enable_language(ASM)
    enable_language(ASM_MASM)
    set(ASMS foo-masm64.asm)
elseif (CMAKE_C_COMPILER_ID STREQUAL OrangeC)
    enable_language(ASM)
    set(ASMS foo-nasm32.asm)  # OAsm ... NASM are not 100% compatible with it
elseif (CMAKE_C_COMPILER_ID STREQUAL LCC)
    enable_language(ASM)
    set(ASMS foo-elbrus.s)
elseif (CMAKE_SYSTEM_NAME STREQUAL Darwin)
    enable_language(ASM)
    set(ASMS foo-_att-x64.s)
else ()
    enable_language(ASM)
    set(ASMS foo-att-x64.s)
endif ()

add_executable(case_asm case_asm.c ${ASMS} ${HDRS})
add_test(NAME case_asm COMMAND case_asm)

enable_testing()
