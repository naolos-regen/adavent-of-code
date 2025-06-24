#! /bin/bash

YEAR=2023
SESSION=$1
BASE_URL="https://adventofcode.com"

mkdir -p "$YEAR"

for DAY in {1..25}; do
	DAY_PADDED=$(printf "%02d" $DAY)
	DAY_DIR="$YEAR/DAY$DAY_PADDED"
	mkdir -p "$DAY_DIR"

	echo "fetching"

	curl -s -H "Cookie: session=$SESSION" "$BASE_URL/$YEAR/day/$DAY" -o "$DAY_DIR/task.html"
	curl -s -H "Cookie: session=$SESSION" "$BASE_URL/$YEAR/day/$DAY/input" -o "$DAY_DIR/input.txt"

done

echo "done!"

