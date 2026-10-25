#!/usr/bin/env bats

load fixture

@test "no arguments prints message and usage instructions" {
    run -2 imageAspectRatio
    assert_output -e $'\nUsage:'
}

@test "invalid option prints message and usage instructions" {
    run -2 imageAspectRatio --invalid-option
    assert_line -n 0 'ERROR: Unknown option "--invalid-option"!'
    assert_output -e $'\nUsage:'
}

@test "-h prints long usage help" {
    run -0 imageAspectRatio -h
    refute_line -n 0 -e '^Usage:'
}
