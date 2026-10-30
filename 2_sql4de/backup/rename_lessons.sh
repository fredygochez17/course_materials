#!/usr/bin/env bash

for i in {1..9}; do
    old=$(printf "1.%d" "$i")
    new=$(printf "1.%02d" "$i")

    for file in "$old"_*.sql; do
        [[ -e "$file" ]] || continue
        mv -i -- "$file" "${file/#$old/$new}"
    done
done