# vim:set sw=4 ts=8 et fileencoding=utf8::Кодировка:UTF-8[АБЁЪЯабёъя]
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

# Немного усложнено, но как в примере:
# https://cmake.org/cmake/help/latest/module/GenerateExportHeader.html#example-generating-export-header

add_library(dfoo SHARED)

# У PellesC необходимо включить расширения для dfoo_export.h
# (generate_export_header(dfoo)) TODO set_property?
set_target_properties(dfoo PROPERTIES C_EXTENSIONS ON)

# Так же, LCC: ADD_LIBRARY called with SHARED option but the target
# platform does not support dynamic linking.  Building a STATIC library
# instead.

include(GenerateExportHeader)
generate_export_header(dfoo)

target_sources(
  dfoo
  PRIVATE baz.c boo.c noe.c
  PUBLIC
    FILE_SET HEADERS
      FILES dfoo.h
    FILE_SET generated_headers
      TYPE HEADERS
      BASE_DIRS ${CMAKE_CURRENT_BINARY_DIR}
      FILES ${CMAKE_CURRENT_BINARY_DIR}/dfoo_export.h
)

add_executable(case_dynamic case_dynamic.c)
set_target_properties(case_dynamic PROPERTIES C_EXTENSIONS ON)  # TODO set_property?
target_link_libraries(case_dynamic dfoo)
if (CMAKE_C_COMPILER_ID STREQUAL TinyCC)  # TODO: libdfoo.so: cannot open...
    add_test(NAME case_dynamic
        COMMAND env LD_LIBRARY_PATH=${CMAKE_CURRENT_BINARY_DIR} ./case_dynamic)
else ()
    add_test(NAME case_dynamic COMMAND case_dynamic)
endif ()

enable_testing()
