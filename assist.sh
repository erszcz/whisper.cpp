#!/bin/bash

#set -x

input="$@"

preprompt="Answer with one sentence."

if [ x"$input" != x"" ]; then
  echo "$0: $input"
  printf "$preprompt $input\n/bye" | ollama run llama2 | say
  exit 0
else
  echo "$0: ignoring: $input"
  exit 1
fi
