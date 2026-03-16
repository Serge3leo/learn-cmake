# vim:set sw=4 ts=8 et fileencoding=utf8::Кодировка:UTF-8[АБЁЪЯабёъя]
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

add_executable(main "main.c")
set_target_properties(main PROPERTIES WIN32_EXECUTABLE TRUE
                                      C_EXTENSIONS ON)  # Для PellesC
enable_testing()
