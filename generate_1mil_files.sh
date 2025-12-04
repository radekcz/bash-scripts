#!/usr/bin/env bash

set -euo pipefail

start=$(date +%s%3N)

DIR_NAME="./archived"
TOTAL_FILES=1000
FILE_SIZE=1024

mkdir -p "$DIR_NAME"

echo "Generating $TOTAL_FILES files (~$FILE_SIZE bytes each) in $DIR_NAME..."

for ((i=1; i<=TOTAL_FILES; i++)); do
    FILE_NAME="file_$(printf "%07d" "$i").txt"

    # Faster: write random bytes directly
    head -c "$FILE_SIZE" /dev/urandom > "$DIR_NAME/$FILE_NAME"

    if (( i % 50 == 0 )); then
        echo "$i files generated..."
    fi
done

echo "Done! Generated $TOTAL_FILES files in $DIR_NAME."

end=$(date +%s%3N)
echo "Duration: $((end - start)) ms"