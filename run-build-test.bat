@echo on
rem vim:set sw=4 ts=8 et fileencoding=utf8:
rem SPDX-License-Identifier: BSD-2-Clause
rem SPDX-FileCopyrightText: 2025 Сергей Леонтьев (leo@sai.msu.ru)

if "x%build_type%" == "x" (
    set build_type=Release
)
if "%1" == "cl" (
    set build_output_dir=build\win_cl_%VisualStudioVersion%
    set cxx_flags=-DCMAKE_CXX_COMPILER=cl
    if "%VisualStudioVersion%" == "16.0" (
        set generator=Visual Studio 16 2019
    ) else if "%VisualStudioVersion%" == "17.0" (
        set generator=Visual Studio 17 2022
    ) else if "%VisualStudioVersion%" == "18.0" (
        set generator=Visual Studio 18 2026
    ) else (
        echo "VisualStudioVersion=%VisualStudioVersion%: uninplemented" 1>&2
        exit /b 3
    )
) else if "%1" == "occ" (
    set build_output_dir=build\win_occ
    set cxx_flags=-DCMAKE_CXX_COMPILER=occ
    set generator=MSYS Makefiles
) else if "%1" == "pocc" (
    set build_output_dir=build\win_pocc
    set cxx_flags=-DLEARN_CMAKE_CXX_ENABLE=OFF
    set generator=MSYS Makefiles
) else (
    echo .
    exit /b 4
)
if "%1" == "cl" (
    set build_hello_dir=%build_output_dir%\hello\%build_type%
) else (
    set build_hello_dir=%build_output_dir%\hello
)

cmake -B %build_output_dir% ^
        -DCMAKE_C_COMPILER=%1 ^
        %cxx_flags% ^
        -G "%generator%" ^
        -DCMAKE_BUILD_TYPE=%build_type% ^
        -S . %debug_trycompile%
if errorlevel 1 exit /b
cmake --build %build_output_dir% --config %build_type% %build_verbose%
if errorlevel 1 exit /b
ctest --output-on-failure --build-config %build_type% ^
      --test-dir %build_output_dir%
if errorlevel 1 exit /b
for /r "%build_hello_dir%" %%e in (hello*.exe) do (
    echo %%e
    %%e
    if errorlevel 1 exit /b
)
