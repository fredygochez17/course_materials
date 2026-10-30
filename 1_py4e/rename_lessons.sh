#!/bin/bash

for dir in lesson*; do


    # extract lesson number
    num=${dir#lesson_}

    # skip if already two digits
    if [[ ${#num} -eq 1 ]]; then

        new_name="lesson_0$num"

        echo "Renaming $dir -> $new_name"

        mv "$dir" "$new_name"

    fi



done