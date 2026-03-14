// vim:set sw=4 ts=8 et fileencoding=utf8::Кодировка:UTF-8[АБЁЪЯабёъя]
// SPDX-License-Identifier: BSD-2-Clause
// SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

#if defined(__cplusplus)
    #include <cstdlib>
#else
    #include <stdlib.h>
#endif

#include "dfoo.h"

int main(void) {
    if (boo() == DFOO_DYNAMIC &&
        baz() == DFOO_DYNAMIC) {
        printf("Хорь, Бу и Баз из динамического Фу\n");
    } else {
        return EXIT_FAILURE;
    }
}
