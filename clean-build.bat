@if "x%VERBOSE%"=="x" echo off
rem vim:set sw=4 ts=8 et fileencoding=utf8:
rem SPDX-License-Identifier: BSD-2-Clause
rem SPDX-FileCopyrightText: 2025 Сергей Леонтьев (leo@sai.msu.ru)

set config_verbose=
set build_verbose=
set build_type=

if not "x%1" == "x" (
    if /i "%2" neq "Ninja" (
        set build_output_dir=build\win_%1
    ) else (
        set build_output_dir=build\wninja_%1
    )
) else (
    set build_output_dir=build\w
)
for /d %%d in ( %build_output_dir%* ) do del %%d /s/q
for /d %%d in ( %build_output_dir%* ) do rmdir %%d /s/q
