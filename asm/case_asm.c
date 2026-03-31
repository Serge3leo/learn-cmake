// vim:set sw=4 ts=8 et fileencoding=utf8::Кодировка:UTF-8[АБЁЪЯабёъя]
// SPDX-License-Identifier: BSD-2-Clause
// SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "foo.h"

int main(void) {
    int in = 1917;
    int out;
    if (&out != memcpy(&out, &in, sizeof(out)) || 1917 != out) {
        #ifdef __ORANGEC__
            printf("WARNING: memcpy: странное %d %td\n", out,
                (char *)memcpy(&out, &in, sizeof(out)) - (char *)&out);
        #else
            printf("FAIL: memcpy: странное %d\n", out);
            exit(EXIT_FAILURE);
        #endif
    }
    if (foo() == FOO_ASM) {
        printf("Хорь, ассемблерный Фу.\n");
    } else {
        printf("FAIL: неизвестный Фу %zu\n", foo());
        exit(EXIT_FAILURE);
    }
}
