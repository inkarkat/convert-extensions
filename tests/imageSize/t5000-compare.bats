#!/usr/bin/env bats

load fixture

@test "compare smaller fails and prints failing dimensions" {
    run -1 imageSize --smaller 300x200 "${IMAGES[@]}"
    assert_output - <<'EOF'
300	200
200	200
640	480
480	640
320	200
700	700
650	751
900	10
25	800
EOF
}

@test "compare greater fails and prints failing dimensions" {
    run -1 imageSize --greater 300x200 "${IMAGES[@]}"
    assert_output - <<'EOF'
300	200
200	200
320	200
100	100
900	10
25	800
EOF
}

@test "compare lt fails and prints failing dimensions" {
    run -1 imageSize -lt 700 "${IMAGES[@]}"
    assert_output - <<'EOF'
700	700
650	751
900	10
25	800
EOF
}

@test "compare le fails and prints failing dimensions" {
    run -1 imageSize -le 700x700 "${IMAGES[@]}"
    assert_output - <<'EOF'
650	751
900	10
25	800
EOF
}

@test "compare eq fails and prints failing dimensions with filenames" {
    run -1 imageSize --with-filename -eq 300x200 "${IMAGES[@]}"
    assert_output - <<'EOF'
200	200	square
640	480	landscape
480	640	portrait
320	200	bar
100	100	tiny
700	700	largest
650	751	big
900	10	wide
25	800	tall
EOF
}

@test "compare ge succeeds and prints nothing" {
    run -0 imageSize -ge 25x10 "${IMAGES[@]}"
    assert_output ''
}

@test "compare gt succeeds and prints nothing" {
    run -0 imageSize -gt 24x9 "${IMAGES[@]}"
    assert_output ''
}
