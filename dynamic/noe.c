// vim:set sw=4 ts=8 et fileencoding=utf8::Кодировка:UTF-8[АБЁЪЯабёъя]
// SPDX-License-Identifier: BSD-2-Clause
// SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

#include <stdio.h>

#include "dfoo.h"

int noe_baz(void) {
    printf("%s: Я Баз из динамической Фу\n", __func__);
    return DFOO_DYNAMIC;
}
int noe_boo(void) {
    printf("%s: Я Бу из динамической Фу\n", __func__);
    return DFOO_DYNAMIC;
}
