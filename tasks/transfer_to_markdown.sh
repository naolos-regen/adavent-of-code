#! /bin/bash

for DAY in {1..25}; do
	DAY_PADDED=$(printf "%02d" $DAY)
	DAY_DIR="2023/DAY$DAY_PADDED"
	cat $DAY_DIR/task.html | pup 'article.day-desc' | lynx -stdin -dump -nolist > $DAY_DIR/task.md
done
