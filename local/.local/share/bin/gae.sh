#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Usage: gae.sh <text>"
  exit 1
fi

text="$*"

printf '%s\n' "$text" | toilet | lolcat

