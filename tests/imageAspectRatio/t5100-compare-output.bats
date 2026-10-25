#!/usr/bin/env bats

load fixture

@test "compare smaller fails and prints succeeding aspect ratios and filename with --success-output" {
    run -1 imageAspectRatio --success-output --with-filename --smaller 100 "${IMAGES[@]}"
    assert_output - <<'EOF'
75	portrait
86	big
3	tall
EOF
}

@test "compare greater fails and prints succeeding aspect ratios with --success-output" {
    run -1 imageAspectRatio --success-output --greater 100 "${IMAGES[@]}"
    assert_output - <<'EOF'
150
133
160
150
9000
EOF
}

@test "compare ge succeeds and prints succeeding aspect ratios with --success-output" {
    run -0 imageAspectRatio --success-output -ge 3 "${IMAGES[@]}"
    assert_output - <<'EOF'
150
100
133
75
160
150
100
100
86
9000
3
EOF
}

@test "compare smaller fails and prints all aspect ratios and filename with --always-output" {
    run -1 imageAspectRatio --always-output --with-filename --smaller 100 "${IMAGES[@]}"
    assert_output - <<'EOF'
150	base
100	square
133	landscape
75	portrait
160	bar
150	same
100	tiny
100	largest
86	big
9000	wide
3	tall
EOF
}

@test "compare greater fails and prints all aspect ratios with --always-output" {
    run -1 imageAspectRatio --always-output --greater 100 "${IMAGES[@]}"
    assert_output - <<'EOF'
150
100
133
75
160
150
100
100
86
9000
3
EOF
}

@test "compare ge succeeds and prints all aspect ratios with --always-output" {
    run -0 imageAspectRatio --always-output -ge 3 "${IMAGES[@]}"
    assert_output - <<'EOF'
150
100
133
75
160
150
100
100
86
9000
3
EOF
}
