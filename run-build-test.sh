#!
# vim:set sw=4 ts=8 et fileencoding=utf8::Кодировка:UTF-8[АБЁЪЯабёъя]
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2025 Сергей Леонтьев (leo@sai.msu.ru)

set -e

cd "`dirname \"$0\"`"

if [ -n "$VERBOSE" ] ; then
    config_verbose="--log-level=VERBOSE --debug-trycompile"
    build_verbose="--verbose"
fi
build_type=${build_type:-Release}
build_output_dir="build/`uname -s`_$1_$2"
if [ -z "$1" ] ; then
    echo "Использование: $0 <C-компилятор> [<C++-компилятор>]" 1>&2
    exit 3
fi
c_compiler="$1"
dcm="-DCMAKE_CXX_COMPILER="
if [ -n "$2" ] ; then
    cxx_flags="${dcm}$2"
else
    bcc="`basename \"$c_compiler\"`"
    dcc="`dirname \"$c_compiler\"`"
    if [ "." == "$dcc" ] ; then
        dcc=""
    fi
    cxx_disable=false
    case "$bcc" in
    *clang*)
        try="`echo \"$bcc\" | sed 's/clang/clang++/'`"
        ;;
    icc)
        try=icpc
        ;;
    icx)
        try=icpx
        ;;
    lcc|lcc-*)
        try="`echo \"$bcc\" | sed 's/lcc/l++/'`"
        ;;
    nvc)
        try=nvc++
        ;;
    pgcc)
        try=pgc++
        ;;
    suncc)
        try=sunCC
        ;;
    tcc)
        cxx_disable=true
        ;;
    xlc)
        try=xlc++
        ;;
    *gcc*)
        try="`echo \"$bcc\" | sed 's/gcc/g++/'`"
        ;;
    cc)
        try="CC c++"
        ;;
    *)
        echo "Нет правил для определения C++-компилятора" 1>&2
        exit 4
    esac
    if "$cxx_disable" ; then
        cxx_flags="-DLEARN_CMAKE_CXX_ENABLE=OFF"
    else
        for t in $try ; do
            if type "${dcc}$t" > /dev/null ; then
                cxx_compiler=$t
                cxx="${dcc}$t"
                break
            fi
        done
        if [ -z "$cxx" ] ; then
            echo "Неудача определения C++-компилятора" 1>&2
            exit 5
        fi
        cxx_flags="-DCMAKE_CXX_COMPILER=$cxx"
    fi
fi
case "$c_compiler" in
lcc|lcc-*)
    cross_emul="${CROSS_EMUL:-e2k}"
    cmake_add="-DCMAKE_CROSSCOMPILING=ON -DCMAKE_SYSTEM_NAME=Generic-ELF \
               -DCMAKE_CROSSCOMPILING_EMULATOR=$cross_emul"
    ;;
esac
mkdir -p "$build_output_dir"
# TODO: cxx_flags - могут быть пробелы, но "$cxx_flags" тоже нехорошо
cmake -B "$build_output_dir" \
      -DCMAKE_C_COMPILER="$c_compiler" \
      $cxx_flags \
      -DCMAKE_BUILD_TYPE=$build_type \
      $cmake_add \
      -S . $config_verbose
cmake --build "$build_output_dir" --config $build_type $build_verbose
ctest --output-on-failure --build-config $build_type --test-dir "$build_output_dir"
for h in "$build_output_dir"/hello/hello* ; do
    $cross_emul $h
done
