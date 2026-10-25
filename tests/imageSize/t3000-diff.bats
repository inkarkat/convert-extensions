#!/usr/bin/env bats

load fixture

@test "show diff size of single image" {
    run -0 imageSize --diff base-300x200.jpg foo-640x480.jpg
    assert_output $'340\t280'
}

@test "show diff size of multiple images" {
    run -0 imageSize --diff base-300x200.jpg foo-640x480.jpg bar-320x200.jpg same-300x200.jpg tiny-100x100.jpg tall-25x800.jpg
    assert_output - <<'EOF'
340	280	foo
20	0	bar
0	0	same
-200	-100	tiny
-275	600	tall
EOF
}
