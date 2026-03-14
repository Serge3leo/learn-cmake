// vim:set sw=4 ts=8 et fileencoding=utf8::Кодировка:UTF-8[АБЁЪЯабёъя]
// SPDX-License-Identifier: BSD-2-Clause
// SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

#if defined(__cplusplus)
    #include <cstdlib>
#else
    #include <stdlib.h>
#endif

#include "foo.h"

int main(void) {
    if (boo() == FOO_STATIC &&
        baz() == FOO_STATIC) {
        printf("Хорь, Бу и Баз из статического Фу\n");
    } else {
        return EXIT_FAILURE;
    }
}
