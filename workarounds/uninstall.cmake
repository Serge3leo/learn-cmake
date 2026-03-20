# vim:set sw=4 ts=8 et fileencoding=utf8:
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}")
include(_patches_)

message("uninstall: CMAKE_ROOT=${CMAKE_ROOT}")
file(READ "${CMAKE_ROOT}/Modules/${LCC_C_module}" lcc_c)
file(READ "${CMAKE_ROOT}/Modules/${LCC_CXX_1_module}" lcc_cxx)
file(READ "${CMAKE_ROOT}/Modules/${TinyCC_C_module}" tinycc_c)
file(READ "${CMAKE_ROOT}/Modules/${TinyCC_C_Det_module}" tinycc_c_det)
set(fail 0)
rev_apply_patch("${tinycc_c_det}" TinyCC_C_Det tinycc_c_det_n fail)
rev_apply_patch("${tinycc_c}" TinyCC_C tinycc_c_n fail)
rev_apply_patch("${lcc_cxx}" LCC_CXX_2 lcc_cxx_n fail)
rev_apply_patch("${lcc_cxx_n}" LCC_CXX_1 lcc_cxx_n fail)
rev_apply_patch("${lcc_c}" LCC_C lcc_c_n fail)
if (fail)
    message(FATAL_ERROR "Can't uninstall all patches")
endif ()
save("${CMAKE_ROOT}/Modules/${LCC_C_module}" "pre-uninstall" "${lcc_c_n}")
save("${CMAKE_ROOT}/Modules/${LCC_CXX_1_module}" "pre-uninstall" "${lcc_cxx_n}")
save("${CMAKE_ROOT}/Modules/${TinyCC_C_module}" "pre-uninstall" "${tinycc_c_n}")
save("${CMAKE_ROOT}/Modules/${TinyCC_C_Det_module}" "pre-uninstall"
     "${tinycc_c_det_n}")
