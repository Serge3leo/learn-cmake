# vim:set sw=2 ts=8 et fileencoding=utf8:
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

include(_support_)

set(LCC_C_module "Compiler/LCC-C.cmake")
set(LCC_C_match "([ \t]+set\\(CMAKE_C_STANDARD_LATEST 17\\)[ \t]*\n)([ \t]*endif\\(\\)[ \t]*\n)")
set(LCC_C_replace [=[\1endif()

# LCC patch
if (CMAKE_C_COMPILER_VERSION VERSION_GREATER_EQUAL "1.29")
  set(CMAKE_C23_STANDARD_COMPILE_OPTION "-std=c23")
  set(CMAKE_C23_EXTENSION_COMPILE_OPTION "-std=gnu23")

  set(CMAKE_C_STANDARD_LATEST 23)
\2]=])
set(LCC_C_rev_match "([ \t]+set\\(CMAKE_C_STANDARD_LATEST 17\\)[ \t]*\n).*#[^\n]*patch.*\n([ \t]*endif\\(\\)[ \t]*\n)")
set(LCC_C_rev_replace "\\1\\2")
set(LCC_C_detect "CMAKE_C23_STANDARD_COMPILE_OPTION")

set(LCC_CXX_1_module "Compiler/LCC-CXX.cmake")
set(LCC_CXX_1_match "([ \t]+set\\(CMAKE_CXX_STANDARD_LATEST 20\\)[ \t]*\n)([ \t]*endif\\(\\)[ \t]*\n)")
set(LCC_CXX_1_replace [=[\1endif()

# LCC patch
if (CMAKE_CXX_COMPILER_VERSION VERSION_GREATER_EQUAL "1.29")
  set(CMAKE_CXX23_STANDARD_COMPILE_OPTION "-std=c++23")
  set(CMAKE_CXX23_EXTENSION_COMPILE_OPTION "-std=gnu++23")
  set(CMAKE_CXX23_STANDARD__HAS_FULL_SUPPORT ON)  # TODO XXX

  set(CMAKE_CXX_STANDARD_LATEST 23)
\2]=])
set(LCC_CXX_1_rev_match "([ \t]+set\\(CMAKE_CXX_STANDARD_LATEST 20\\)[ \t]*\n).*#[^\n]*patch.*\n([ \t]*endif\\(\\)[ \t]*\n)")
set(LCC_CXX_1_rev_replace "\\1\\2")
set(LCC_CXX_1_detect "CMAKE_CXX23_STANDARD_COMPILE_OPTION")

set(LCC_CXX_2_module "${LCC_CXX_1_module}:2")
set(LCC_CXX_2_match "(__compiler_check_default_language_standard\\(CXX [^\n]*\\))")
set(LCC_CXX_2_replace [=[# LCC patch \1
__compiler_check_default_language_standard(CXX 1.19 98 1.20 11 1.21 14 1.29 17)]=])
set(LCC_CXX_2_rev_match "# LCC patch (__compiler_check_default_language_standard\\(CXX [^\n]*\\))\n__compiler_check_default_language_standard\\(CXX [^\n]*\\)")
set(LCC_CXX_2_rev_replace "\\1")
set(LCC_CXX_2_detect "__compiler_check_default_language_standard\\([^\n]*1\\.2[79][^\n]*\\)")

set(TinyCC_C_Det_module "Compiler/TinyCC-C-DetermineCompiler.cmake")
set(TinyCC_C_Det_match "\n$")
set(TinyCC_C_Det_replace [=[\n
# TinyCC patch
set(_compiler_id_version_compute "
# define @PREFIX@COMPILER_VERSION_MAJOR @MACRO_DEC@(__TINYC__ / 10000)
# define @PREFIX@COMPILER_VERSION_MINOR @MACRO_DEC@(__TINYC__ / 100 % 100)
# define @PREFIX@COMPILER_VERSION_PATCH @MACRO_DEC@(__TINYC__ % 100)")
]=])
set(TinyCC_C_Det_rev_match "\n\n# TinyCC patch.*$")
set(TinyCC_C_Det_rev_replace "\n")
set(TinyCC_C_Det_detect "COMPILER_VERSION_MAJOR")

set(TinyCC_C_module "Compiler/TinyCC-C.cmake")
set(TinyCC_C_match "\n$")
set(TinyCC_C_replace [=[\n
# TinyCC patch
include(Compiler/CMakeCommonCompilerMacros)
include(Compiler/TinyCC)

set(CMAKE_C_COMPILE_OPTIONS_WARNING_AS_ERROR "-Werror")
set(CMAKE_C_EXTENSIONS_DEFAULT ON)

set(CMAKE_C99_STANDARD_COMPILE_OPTION "-std=c99")
set(CMAKE_C99_EXTENSION_COMPILE_OPTION "-std=c99")
set(CMAKE_C99_STANDARD__HAS_FULL_SUPPORT ON)  # TODO

set(CMAKE_C_STANDARD_LATEST 99)

if (CMAKE_C_COMPILER_VERSION VERSION_GREATER 0.9.27)
  set(CMAKE_C11_STANDARD_COMPILE_OPTION "-std=c11")
  set(CMAKE_C11_EXTENSION_COMPILE_OPTION "-std=c11")
  # TODO set(CMAKE_C11_STANDARD__HAS_FULL_SUPPORT ON)

  set(CMAKE_C_STANDARD_LATEST 11)
endif ()

__compiler_check_default_language_standard(C 0.9.24 99)
]=])
set(TinyCC_C_rev_match "\n\n# TinyCC patch.*$")
set(TinyCC_C_rev_replace "\n")
set(TinyCC_C_detect "CMAKE_C[0-9]+_STANDARD_COMPILE_OPTION")
