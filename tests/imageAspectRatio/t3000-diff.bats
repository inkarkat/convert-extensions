#!/usr/bin/env bats

load fixture

@test "show diff aspect ratio of single image" {
    run -0 imageAspectRatio --diff base-300x200.jpg foo-640x480.jpg
    assert_output -17
}

@test "show diff aspect ratio of multiple images" {
    run -0 imageAspectRatio --diff base-300x200.jpg foo-640x480.jpg bar-320x200.jpg same-3000x2000.jpg double-500x200.jpg tiny-100x100.jpg tall-25x800.jpg
    assert_output - <<'EOF'
-17
10
0
100
-50
-147
EOF
}
