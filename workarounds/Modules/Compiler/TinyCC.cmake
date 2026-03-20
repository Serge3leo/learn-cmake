# vim:set sw=2 ts=8 et fileencoding=utf8:
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

include_guard()

# На настоящий момент, мне известен только один способ выяснить, что `tcc`
# имеет версию `0.9.28rc`, или типа того: `tcc -h | egrep 'std[ =](c|gnu)11'`.

if (CMAKE_C_COMPILER_VERSION STREQUAL 0.9.27)
  # TODO Сохраняется базовое отсутствие осознания процесса.  Для 3.31.6 мы сюда
  # попадаем трижды с 0.9.27 и, на этапах `Performing Test COMPILER_HAS_*`, ещё
  # несколько раз с 0.9.27.2020.

  # Не знаю, надо бы `bash -c "exec ps -p ${1:-$$} -o ppid="` или типа того

  # Использование `ENV{_TinyCC_version_checked_}`, вроде как, решает проблему
  # многократного запуска `${CMAKE_C_COMPILER}`, но как-то уж больно вычурно...

  if ("$ENV{_TinyCC_version_checked_}" STREQUAL "")
    execute_process(COMMAND "${CMAKE_C_COMPILER}" -h
                    OUTPUT_VARIABLE _TinyCC_output_)
    if ("${_TinyCC_output_}" MATCHES "std[ =](gnu|c)11")
      set(ENV{_TinyCC_rc_git_} "true")
    else ()
      set(ENV{_TinyCC_rc_git_} "false")
    endif ()
    unset(_TinyCC_output_)
    message(VERBOSE "execute_process(${CMAKE_C_COMPILER}),"
                    " ENV{_TinyCC_rc_git_}=$ENV{_TinyCC_rc_git_}")
    set(ENV{_TinyCC_version_checked_} "true")
  endif ()
  if ("$ENV{_TinyCC_rc_git_}" STREQUAL "true")
    # TODO Debian/Ubuntu: 0.9.27+git20200814.62c30a4a-2
    set(CMAKE_C_COMPILER_VERSION 0.9.27.2020)
  endif ()
endif ()
