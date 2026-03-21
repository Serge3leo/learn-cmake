@if "x%VERBOSE%"=="x" echo off
rem vim:set sw=4 ts=8 et fileencoding=utf8:
rem SPDX-License-Identifier: BSD-2-Clause
rem SPDX-FileCopyrightText: 2025 Сергей Леонтьев (leo@sai.msu.ru)

for /d %%d in ( build\win_%1* ) do del %%d /s/q
for /d %%d in ( build\win_%1* ) do rmdir %%d /s/q
