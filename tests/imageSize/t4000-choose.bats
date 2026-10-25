#!/usr/bin/env bats

load fixture

@test "choosing any dimension of a single image prints that image's dimensions" {
    for chooseArg in --smallest --largest --min --max --min-width --max-width --min-height --max-height --min-both --max-both
    do
	run -0 imageSize $chooseArg foo-640x480.jpg \
	    && assert_output $'640\t480' \
	    || fail "$chooseArg"
    done
}

@test "choosing a dimension of multiple images" {
    typeset -A data=(
	[--smallest]=$'900\t10'
	[--largest]=$'700\t700'
	[--min]=$'100\t100'
	[--max]=$'650\t751'
	[--min-width]=$'25\t800'
	[--max-width]=$'900\t10'
	[--min-height]=$'900\t10'
	[--max-height]=$'25\t800'
	[--min-both]=$'25\t10'
	[--max-both]=$'900\t800'
    )

    for chooseArg in "${!data[@]}"
    do
	run -0 imageSize $chooseArg "${IMAGES[@]}" \
	    && assert_output "${data["$chooseArg"]}" \
	    || fail "$chooseArg should yield ${data["$chooseArg"]}"
    done
}

@test "choosing a dimension of multiple images with filename" {
    typeset -A data=(
	[--smallest]=$'900\t10\twide'
	[--largest]=$'700\t700\tlargest'
	[--min]=$'100\t100\ttiny'
	[--max]=$'650\t751\tbig'
	[--min-width]=$'25\t800\ttall'
	[--max-width]=$'900\t10\twide'
	[--min-height]=$'900\t10\twide'
	[--max-height]=$'25\t800\ttall'
	[--min-both]=$'25\t800\ttall\n900\t10\twide'
	[--max-both]=$'900\t10\twide\n25\t800\ttall'
    )

    for chooseArg in "${!data[@]}"
    do
	run -0 imageSize $chooseArg --with-filename "${IMAGES[@]}" \
	    && assert_output "${data["$chooseArg"]}" \
	    || fail "$chooseArg should yield ${data["$chooseArg"]}"
    done
}

@test "on a tie, the unique dimensions are shown, or all images with filename" {
    run -0 imageSize --smallest smallestA-3x3.jpg "${IMAGES[@]}" smallestB-3x3.jpg
    assert_output $'3\t3'
    run -0 imageSize --with-filename --smallest smallestA-3x3.jpg "${IMAGES[@]}" smallestB-3x3.jpg
    assert_output - <<'EOF'
3	3	smallestA
3	3	smallestB
EOF
}

@test "on a tie, all dimensions are shown, including all files with the same dimensions" {
    run -0 imageSize --min-width king-stamp-25x40.jpg "${IMAGES[@]}" queen-stamp-25x40.jpg
    assert_output - <<'EOF'
25	40
25	800
EOF
    run -0 imageSize --with-filename --min-width king-stamp-25x40.jpg "${IMAGES[@]}" queen-stamp-25x40.jpg
    assert_output - <<'EOF'
25	40	king-stamp
25	800	tall
25	40	queen-stamp
EOF

    run -0 imageSize --min-both king-stamp-25x40.jpg "${IMAGES[@]}" queen-stamp-25x40.jpg banner-888x10.jpg
    assert_output $'25\t10'
    run -0 imageSize --with-filename --min-both king-stamp-25x40.jpg "${IMAGES[@]}" queen-stamp-25x40.jpg banner-888x10.jpg
    assert_output - <<'EOF'
25	40	king-stamp
25	800	tall
25	40	queen-stamp
900	10	wide
888	10	banner
EOF
}
