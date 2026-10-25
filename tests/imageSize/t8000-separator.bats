#!/usr/bin/env bats

load fixture

@test "show sizes of two images with x separator" {
    IMAGESIZE_SEPARATOR=x run -0 imageSize foo-640x480.jpg bar-320x200.jpg
    assert_output - <<'EOF'
640x480	foo
320x200	bar
EOF
}

@test "show sizes of two images with space separator" {
    IMAGESIZE_SEPARATOR=' ' run -0 imageSize foo-640x480.jpg bar-320x200.jpg
    assert_output - <<'EOF'
640 480	foo
320 200	bar
EOF
}

@test "show sizes of two images with double-tab separator" {
    IMAGESIZE_SEPARATOR=$'\t\t' run -0 imageSize foo-640x480.jpg bar-320x200.jpg
    assert_output - <<'EOF'
640		480	foo
320		200	bar
EOF
}

@test "choose smallest dimensions with x separator" {
    IMAGESIZE_SEPARATOR=x run -0 imageSize --smallest foo-640x480.jpg bar-320x200.jpg
    assert_output '320x200'

    IMAGESIZE_SEPARATOR=x run -0 imageSize --with-filename --smallest foo-640x480.jpg bar-320x200.jpg
    assert_output $'320x200\tbar'
}

@test "compare le fails and prints failing dimensions with x separator" {
    IMAGESIZE_SEPARATOR=x run -1 imageSize -le 700x700 "${IMAGES[@]}"
    assert_output - <<'EOF'
650x751
900x10
25x800
EOF
}
