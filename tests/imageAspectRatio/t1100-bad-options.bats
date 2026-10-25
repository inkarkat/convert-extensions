#!/usr/bin/env bats

load fixture

@test "invalid dimensions prints error message" {
    run -2 imageAspectRatio --greater 100x foo-640x480.jpg
    assert_line -n 0 'ERROR: Invalid PERCENTAGE: 100x'
    assert_line -n 1 -e '^Usage:'
}

@test "invalid combination of output options prints error message" {
    run -2 imageAspectRatio --always-output --success-output foo-640x480.jpg
    assert_line -n 0 'ERROR: Cannot combine -A|--always-output with -S|--success-output.'
    assert_line -n 1 -e '^Usage:'
}
