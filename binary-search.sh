#!/usr/bin/env bash

search() {
	min="$1"
	max="$2"

	if (( "$min" > "$max" )); then
		echo "such prank much wow" 1>&2
		exit
	fi

	guess=$(((min+max) / 2))

	echo -n "I guess $guess. [higher/lower/correct]: "
	read result
	case "$result" in
		higher)
			min=$((guess+1))
			;;
		lower)
			max=$((guess-1))
			;;
		correct)
			exit
	esac
	search "$min" "$max"
}
search 1 3000000000
