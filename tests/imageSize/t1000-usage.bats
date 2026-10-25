#!/usr/bin/env bats

load fixture

@test "no arguments prints message and usage instructions" {
    run -2 imageSize
    assert_output -e $'\nUsage:'
}

@test "invalid option prints message and usage instructions" {
    run -2 imageSize --invalid-option
    assert_line -n 0 'ERROR: Unknown option "--invalid-option"!'
    assert_output -e $'\nUsage:'
}

@test "-h prints long usage help" {
    run -0 imageSize -h
    refute_line -n 0 -e '^Usage:'
}
