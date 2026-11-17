#!/bin/sh
set -eu

if [ "$#" -ne 2 ]; then
  echo "usage: extract-last-frame.sh INPUT_VIDEO OUTPUT_PNG" >&2
  exit 2
fi

input=$1
output=$2

command -v ffmpeg >/dev/null 2>&1 || {
  echo "ffmpeg is required to extract continuity frames" >&2
  exit 127
}

ffmpeg -hide_banner -loglevel error -sseof -0.1 -i "$input" -frames:v 1 -y "$output"
