#!/usr/bin/env bash

start=$(date +%s%3N)
set -euo pipefail

DIR_NAME="./archived"
TOTAL_FILES=1000
FILE_SIZE=1024

mkdir -p "$DIR_NAME"

echo "Generating $TOTAL_FILES files (~$FILE_SIZE bytes each) in $DIR_NAME..."

for ((i=1; i<=TOTAL_FILES; i++)); do
    FILE_NAME="file_$(printf "%07d" "$i").txt"

    # Generate random letters by converting random bytes to letters
    # This maps each byte (0-255) to a letter (a-z, A-Z)
    head -c "$FILE_SIZE" /dev/urandom | LC_ALL=C tr '\000-\377' 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' > "$DIR_NAME/$FILE_NAME"

    if (( i % 100 == 0 )); then
        echo "$i files generated..."
    fi
done

echo "Done! Generated $TOTAL_FILES files in $DIR_NAME."

end=$(date +%s%3N)
echo "Duration: $((end - start)) ms"