@if "x%VERBOSE%"=="x" echo off
rem vim:set sw=4 ts=8 et fileencoding=utf8:
rem SPDX-License-Identifier: BSD-2-Clause
rem SPDX-FileCopyrightText: 2025 Сергей Леонтьев (leo@sai.msu.ru)

setlocal enabledelayedexpansion
if NOT "x%VERBOSE%" == "x" (
    set config_verbose=--log-level=VERBOSE --debug-trycompile
    set build_verbose=--verbose %
)
if "x%build_type%" == "x" (
    set build_type=Release
)
if "x%2" == "x" (
    if "%1" == "cl" (
        set build_output_dir=build\win_%1_%VisualStudioVersion%
        set cxx_flags=-DCMAKE_CXX_COMPILER=cl
        if "%VisualStudioVersion%" == "16.0" (
            set generator=Visual Studio 16 2019
        ) else if "%VisualStudioVersion%" == "17.0" (
            set generator=Visual Studio 17 2022
        ) else if "%VisualStudioVersion%" == "18.0" (
            set generator=Visual Studio 18 2026
        ) else (
            echo "VisualStudioVersion=%VisualStudioVersion%: unimplemented" 1>&2
            exit /b 3
        )
    ) else if "%1" == "clang" (
        set build_output_dir=build\win_%1
        set cxx_flags=-DCMAKE_CXX_COMPILER=clang++
        set generator=MSYS Makefiles
    ) else if "%1" == "gcc" (
        set build_output_dir=build\win_%1
        set cxx_flags=-DCMAKE_CXX_COMPILER=g++
        set generator=MSYS Makefiles
    ) else if "%1" == "occ" (
        set build_output_dir=build\win_%1
        set cxx_flags=-DCMAKE_CXX_COMPILER=occ
        set generator=MSYS Makefiles
    ) else if "%1" == "pocc" (
        set build_output_dir=build\win_%1
        set cxx_flags=-DLEARN_CMAKE_CXX_ENABLE=OFF
        set generator=MSYS Makefiles
    ) else if "%1" == "cc" (
        set build_output_dir=build\win_%1
        set cxx_flags=-DLEARN_CMAKE_CXX_ENABLE=OFF
        set generator=MSYS Makefiles
    ) else (
        echo "Usage: %0 <cc|cl|clang|gcc|occ|pocc> [ninja]" 1>&2
        exit /b 4
    )
    if "%1" == "cl" (
        set build_hello_dir=!build_output_dir!\hello\!build_type!
    ) else (
        set build_hello_dir=!build_output_dir!\hello
    )
) else (
    if /i "%2" neq "Ninja" (
        echo "Usage: %0 <cc|cl|clang|gcc|occ|pocc> [ninja]" 1>&2
        exit /b 4
    )
    set generator=Ninja
    if "%1" == "cl" (
        set build_output_dir=build\wninja_%1_%VisualStudioVersion%
        set cxx_flags=-DCMAKE_CXX_COMPILER=cl
    ) else if "%1" == "clang" (
        set build_output_dir=build\wninja_%1
        set cxx_flags=-DCMAKE_CXX_COMPILER=clang++
    ) else if "%1" == "gcc" (
        set build_output_dir=build\wninja_%1
        set cxx_flags=-DCMAKE_CXX_COMPILER=g++
    ) else if "%1" == "occ" (
        set build_output_dir=build\wninja_%1
        set cxx_flags=-DCMAKE_CXX_COMPILER=occ
    ) else if "%1" == "pocc" (
        set build_output_dir=build\wninja_%1
        set cxx_flags=-DLEARN_CMAKE_CXX_ENABLE=OFF
    ) else if "%1" == "cc" (
        set build_output_dir=build\wninja_%1
        set cxx_flags=-DLEARN_CMAKE_CXX_ENABLE=OFF
    ) else (
        echo "Usage: %0 <cc|cl|clang|gcc|occ|pocc> [ninja]" 1>&2
        exit /b 4
    )
    set build_hello_dir=!build_output_dir!\hello
)
cmake -B %build_output_dir% ^
        -DCMAKE_C_COMPILER=%1 ^
        %cxx_flags% ^
        -G "%generator%" ^
        -DCMAKE_BUILD_TYPE=%build_type% ^
        -S . %config_verbose% %CMAKE_ARGS%
if errorlevel 1 (
    echo "cmake: errorlevel=%errorlevel%"
    exit /b
)
cmake --build %build_output_dir% --config %build_type% %build_verbose% %BUILD_ARGS%
if errorlevel 1 (
    echo "cmake --build: errorlevel=%errorlevel%"
    exit /b
)
ctest --output-on-failure --build-config %build_type% ^
      --test-dir %build_output_dir% %CTEST_ARGS%
if errorlevel 1 (
    echo "ctest: errorlevel=%errorlevel%"
    exit /b
)
echo "Find hello*.exe in %build_hello_dir%"
for /r "%build_hello_dir%" %%e in (hello*.exe) do (
    echo %%e
    %%e
    if errorlevel 1 (
        echo "%%e: errorlevel=%errorlevel%"
        exit /b
    )
)
