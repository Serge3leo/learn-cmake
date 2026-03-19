// vim:set sw=4 ts=8 et fileencoding=utf8::Кодировка:UTF-8[АБЁЪЯабёъя]
// SPDX-License-Identifier: BSD-2-Clause
// SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

#include <stdio.h>
#include <stdlib.h>

#include "foo.h"

int main(void) {
    if (foo() == FOO_ASM) {
        printf("Хорь, ассемблерный Фу.\n");
    } else {
        printf("FAIL: неизвестный Фу %zu\n", foo());
        exit(EXIT_FAILURE);
    }
}
