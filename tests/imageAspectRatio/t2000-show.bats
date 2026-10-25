#!/usr/bin/env bats

load fixture

@test "show aspect ratio of single image" {
    run -0 imageAspectRatio foo-640x480.jpg
    assert_output 133
}

@test "show aspect ratio of single image with filename" {
    run -0 imageAspectRatio --with-filename foo-640x480.jpg
    assert_output $'133\tfoo'
}

@test "show aspect ratios of two images" {
    run -0 imageAspectRatio foo-640x480.jpg bar-320x200.jpg
    assert_output - <<'EOF'
133	foo
160	bar
EOF
}
