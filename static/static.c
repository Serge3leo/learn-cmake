// vim:set sw=4 ts=8 et fileencoding=utf8::Кодировка:UTF-8[АБЁЪЯабёъя]
// SPDX-License-Identifier: BSD-2-Clause
// SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

#if defined(__cplusplus)
    #include <cassert>
#else
    #include <assert.h>
#endif

#include "foo.h"

int main(void) {
    assert(boo() == FOO_STATIC);
    assert(baz() == FOO_STATIC);
    printf("Хорь, Бу и Баз из статического Фу\n");
}
