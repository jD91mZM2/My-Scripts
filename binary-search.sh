#!/usr/bin/env bash

echo -n "Min: "
read min
echo -n "Max: "
read max

while true; do
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
done
