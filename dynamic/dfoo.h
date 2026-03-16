// vim:set sw=4 ts=8 et fileencoding=utf8::Кодировка:UTF-8[АБЁЪЯабёъя]
// SPDX-License-Identifier: BSD-2-Clause
// SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

#ifndef DFOO_H_1422
#define DFOO_H_1422

#include "dfoo_export.h"

#define DFOO_DYNAMIC  (1945)

DFOO_EXPORT int boo(void);
DFOO_EXPORT int baz(void);

DFOO_NO_EXPORT int noe_boo(void);
DFOO_NO_EXPORT int noe_baz(void);

#endif  // DFOO_H_1422
