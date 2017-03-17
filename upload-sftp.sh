#!/bin/sh
s="$1"
shift 1
for f in "$@"; do
  printf "progress\nput $f" | sftp -b- "$s" || return 1
done
