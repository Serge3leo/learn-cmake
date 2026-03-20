# vim:set sw=4 ts=8 et fileencoding=utf8:
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}")
include(_patches_)

message("detect: CMAKE_ROOT=${CMAKE_ROOT}")
set(fail 0)
detect(LCC_C "${LCC_C_detect}" fail)
detect(LCC_CXX_1 "${LCC_CXX_1_detect}" fail)
detect(LCC_CXX_1 "${LCC_CXX_2_detect}" fail)
detect(TinyCC_C_Det "${TinyCC_C_Det_detect}" fail)
detect(TinyCC_C "${TinyCC_C_detect}" fail)
if (fail)
    cmake_language(EXIT 1)
endif ()
message("Ok, detect LCC_C, LCC_CXX_1, TinyCC_C_Det, TinyCC_C")
cmake_language(EXIT 0)
