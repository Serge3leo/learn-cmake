// vim:set sw=4 ts=8 et fileencoding=utf8::Кодировка:UTF-8[АБЁЪЯабёъя]
// SPDX-License-Identifier: BSD-2-Clause
// SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

#include "foo.h"

int boo(void) {
    printf("%s: Я Бу из статического Фу\n", __func__);
    return RESPONSE;
}
