#!/usr/bin/env bats

load fixture

@test "compare smaller fails and prints failing aspect ratios" {
    run -1 imageAspectRatio --smaller 100 "${IMAGES[@]}"
    assert_output - <<'EOF'
150
100
133
160
150
100
100
9000
EOF
}

@test "compare greater fails and prints failing aspect ratios" {
    run -1 imageAspectRatio --greater 100 "${IMAGES[@]}"
    assert_output - <<'EOF'
100
75
100
100
86
3
EOF
}

@test "compare lt fails and prints failing aspect ratios" {
    run -1 imageAspectRatio -lt 150 "${IMAGES[@]}"
    assert_output - <<'EOF'
150
160
150
9000
EOF
}

@test "compare le fails and prints failing aspect ratios" {
    run -1 imageAspectRatio -le 150 "${IMAGES[@]}"
    assert_output - <<'EOF'
160
9000
EOF
}

@test "compare eq fails and prints failing aspect ratios with filenames" {
    run -1 imageAspectRatio --with-filename -eq 100 "${IMAGES[@]}"
    assert_output - <<'EOF'
150	base
133	landscape
75	portrait
160	bar
150	same
86	big
9000	wide
3	tall
EOF
}

@test "compare ne fails and prints failing aspect ratios with filenames" {
    run -1 imageAspectRatio -ne 150 "${IMAGES[@]}"
    assert_output - <<'EOF'
150
150
EOF
}

@test "compare ge succeeds and prints nothing" {
    run -0 imageAspectRatio -ge 3 "${IMAGES[@]}"
    assert_output ''
}

@test "compare gt succeeds and prints nothing" {
    run -0 imageAspectRatio -gt 2 "${IMAGES[@]}"
    assert_output ''
}
