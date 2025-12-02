#!/bin/zsh

total_files=1000
files_per_dir=100
file_size=1024  # bytes per file
parallel_jobs=8  # adjust based on CPU cores

export files_per_dir
export file_size

# Generate files in parallel
seq 1 $total_files | xargs -n 1 -P $parallel_jobs zsh -c '
    i=$1
    dir_index=$(( (i-1) / files_per_dir + 1 ))
    dir_name=$(printf "dir_%04d" $dir_index)
    mkdir -p "$dir_name"
    file_name=$(printf "file_%07d.txt" $i)
    LC_ALL=C tr -dc "A-Za-z0-9 " < /dev/urandom | head -c $file_size > "$dir_name/$file_name"
' _