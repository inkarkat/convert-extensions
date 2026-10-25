#!/usr/bin/env bats

load fixture

@test "show size of single image" {
    run -0 imageSize foo-640x480.jpg
    assert_output $'640\t480'
}

@test "show sizes of two images" {
    run -0 imageSize foo-640x480.jpg bar-320x200.jpg
    assert_output - <<'EOF'
640	480	foo
320	200	bar
EOF
}
