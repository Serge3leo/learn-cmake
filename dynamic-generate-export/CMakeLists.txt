# vim:set sw=4 ts=8 et fileencoding=utf8::Кодировка:UTF-8[АБЁЪЯабёъя]
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

if (CMAKE_C_COMPILER_ID STREQUAL OrangeC AND
    "${CMAKE_C_COMPILER_VERSION}" VERSION_LESS_EQUAL 6.73.8)
    message("TODO dynamic-generate-export: OrangeC 6.73.8 - unsupported, skip")
    return ()
endif ()

# Немного усложнено, но как в примере:
# https://cmake.org/cmake/help/latest/module/GenerateExportHeader.html#example-generating-export-header

add_library(gfoo SHARED)

# У PellesC необходимо включить расширения для gfoo_export.h
# (generate_export_header(gfoo)) TODO set_property?
set_target_properties(gfoo PROPERTIES C_EXTENSIONS ON)

# Так же, LCC: ADD_LIBRARY called with SHARED option but the target
# platform does not support dynamic linking.  Building a STATIC library
# instead.

include(GenerateExportHeader)
generate_export_header(gfoo)

target_sources(
  gfoo
  PRIVATE baz.c boo.c noe.c
  PUBLIC
    FILE_SET HEADERS
      FILES gfoo.h
    FILE_SET generated_headers
      TYPE HEADERS
      BASE_DIRS ${CMAKE_CURRENT_BINARY_DIR}
      FILES ${CMAKE_CURRENT_BINARY_DIR}/gfoo_export.h
)

add_executable(case_gdynamic case_dynamic.c)
set_target_properties(case_gdynamic PROPERTIES C_EXTENSIONS ON)  # TODO set_property?
target_link_libraries(case_gdynamic gfoo)
if (CMAKE_C_COMPILER_ID STREQUAL TinyCC)  # TODO: libgfoo.so: cannot open...
    add_test(NAME case_gdynamic
        COMMAND env LD_LIBRARY_PATH=${CMAKE_CURRENT_BINARY_DIR} ./case_gdynamic)
else ()
    add_test(NAME case_gdynamic COMMAND case_gdynamic)
endif ()

enable_testing()
