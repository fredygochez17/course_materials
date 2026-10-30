#!/bin/bash

for dir in lesson*; do

    # Skip if not a directory
    [ -d "$dir" ] || continue

    # Extract lesson number
    lesson_num=$(echo "$dir" | cut -d'_' -f1 | sed 's/lesson/lesson_/')

    # Extract remaining portion
    remaining=$(echo "$dir" | cut -d'_' -f2-)

    # Rename folder
    mv "$dir" "$lesson_num"

    # Create empty text file
    touch "$lesson_num/$remaining.txt"

done


