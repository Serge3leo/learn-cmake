// vim:set sw=4 ts=8 et fileencoding=utf8::Кодировка:UTF-8[АБЁЪЯабёъя]
// SPDX-License-Identifier: BSD-2-Clause
// SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

#include <stdio.h>
#include <stdlib.h>

#include "afoo.h"

int main(void) {
    if (boo() == AFOO_DYNAMIC && baz() == AFOO_DYNAMIC) {
        printf("Хорь, Бу и Баз из динамического Фу\n");
    } else {
        printf("FAIL: неизвестный Бу (%d) или Баз (%d)\n", boo(), baz());
        exit(EXIT_FAILURE);
    }
}
