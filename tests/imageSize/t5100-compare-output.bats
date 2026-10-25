#!/usr/bin/env bats

load fixture

@test "compare smaller fails and prints succeeding dimensions and filename with --success-output" {
    run -1 imageSize --success-output --with-filename --smaller 300x200 "${IMAGES[@]}"
    assert_output $'100\t100\ttiny'
}

@test "compare greater fails and prints succeeding dimensions with --success-output" {
    run -1 imageSize --success-output --greater 300x200 "${IMAGES[@]}"
    assert_output - <<'EOF'
640	480
480	640
700	700
650	751
EOF
}

@test "compare ge succeeds and prints succeeding dimensions with --success-output" {
    run -0 imageSize --success-output -ge 25x10 "${IMAGES[@]}"
    assert_output - <<'EOF'
300	200
200	200
640	480
480	640
320	200
100	100
700	700
650	751
900	10
25	800
EOF
}

@test "compare smaller fails and prints all dimensions and filename with --always-output" {
    run -1 imageSize --always-output --with-filename --smaller 300x200 "${IMAGES[@]}"
    echo "$output" > ~/tmp/output
    assert_output - <<'EOF'
300	200	base
200	200	square
640	480	landscape
480	640	portrait
320	200	bar
300	200	same
100	100	tiny
700	700	largest
650	751	big
900	10	wide
25	800	tall
EOF
}

@test "compare greater fails and prints all dimensions with --always-output" {
    run -1 imageSize --always-output --greater 300x200 "${IMAGES[@]}"
    assert_output - <<'EOF'
300	200
200	200
640	480
480	640
320	200
100	100
700	700
650	751
900	10
25	800
EOF
}

@test "compare ge succeeds and prints all dimensions with --always-output" {
    run -0 imageSize --always-output -ge 25x10 "${IMAGES[@]}"
    assert_output - <<'EOF'
300	200
200	200
640	480
480	640
320	200
100	100
700	700
650	751
900	10
25	800
EOF
}
