// vim:set sw=4 ts=8 et fileencoding=utf8::Кодировка:UTF-8[АБЁЪЯабёъя]
// SPDX-License-Identifier: BSD-2-Clause
// SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

#ifndef GFOO_H_1422
#define GFOO_H_1422

#include "gfoo_export.h"

#define GFOO_DYNAMIC  (1945)

GFOO_EXPORT int boo(void);
GFOO_EXPORT int baz(void);

GFOO_NO_EXPORT int noe_boo_(void);
GFOO_NO_EXPORT int noe_baz_(void);

#endif  // GFOO_H_1422
