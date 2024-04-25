#!/bin/bash

#set -x

input="$@"

preprompt=$(cat << EOF
Every subsequent text you will get is going to be a request to: turn the light on, turn the light off, dim the light to a percentage. Interpret every following prompt and output just: light-on, light-off, dim-N, where N is the percentage from 0 to 100.
EOF)

history_file=lights-control.history.txt

if [ x"$input" != x"" ]; then
  echo "$0: $input"
  history=$(cat $history_file)
  prompt=$(printf "$preprompt $history $input")
  echo "$0: $prompt"
  printf "$prompt\n/bye" | ollama run llama2
  echo "$input" >> $history_file
  exit 0
else
  echo "$0: ignoring: $input"
  exit 1
fi
