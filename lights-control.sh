#!/bin/bash

# Control lights (currently just output a simple action name) with a voice command.
#
# Use
#
#  ./command -m ./models/ggml-small.en.bin -t 8 -f voice-commands.txt
#
# to make whisper.cpp command write recognised commands to a file.
# Then use
#
#  echo > lights-control.history.txt; tail -f voice-commands.txt | xargs -L1 ./lights-control.sh ; stty sane
#
# as the shell driver to use this script for each recognised command.

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
