#!/usr/bin/env bats

load fixture

@test "invalid dimensions prints error message" {
    run -2 imageSize --greater 100x200x300 foo-640x480.jpg
    assert_line -n 0 'ERROR: Invalid SIZE|WxH: 100x200x300'
    assert_output -e $'\nUsage:'
}

@test "invalid combination of output options prints error message" {
    run -2 imageSize --always-output --success-output foo-640x480.jpg
    assert_line -n 0 'ERROR: Cannot combine -A|--always-output with -S|--success-output.'
    assert_output -e $'\nUsage:'
}
