#!/bin/bash

bats_require_minimum_version 1.5.0
bats_load_library bats-support
bats_load_library bats-assert

typeset -gra IMAGES=(
    base-300x200.jpg
    square-200x200.jpg
    landscape-640x480.jpg
    portrait-480x640.jpg
    bar-320x200.jpg
    same-300x200.jpg
    tiny-100x100.jpg
    largest-700x700.jpg
    big-650x751.jpg
    wide-900x10.jpg
    tall-25x800.jpg
)

fakeidentify() {
    local format=
    while [ $# -ne 0 ]
    do
	case "$1" in
	    --)		shift; break;;
	    -ping)	shift;;
	    -format)	shift; format="$1"; shift;;
	    *)		break;;
	esac
    done
    for arg
    do
	if [[ "$arg" =~ ^(.*)-([0-9]+)x([0-9]+).jpg$ ]]; then
	    local filespec="${BASH_REMATCH[1]}"
	    local width="${BASH_REMATCH[2]}"
	    local height="${BASH_REMATCH[3]}"
	    local output="$format"
	    output="${output//%f/$filespec}"
	    output="${output//%w/$width}"
	    output="${output//%h/$height}"
	    printf '%s' "$output"
	else
	    echo >&2 "ERROR: Filespec does not match expected NAME-WIDTHxHEIGHT.jpg scheme: $arg"
	    exit 3
	fi
    done
}
export -f fakeidentify
export TEST=identify^=fake
