#!/bin/bash

# Ask a voice assistant for answers.
#
# Use
#
#  ./command -m ./models/ggml-small.en.bin -t 8 -f voice-commands.txt
#
# to make whisper.cpp command write recognised commands to a file.
# Then use
#
#  tail -f voice-commands.txt | xargs -L1 ./assist.sh
#
# as the shell driver to ask the assistant to respond to each recognised command.

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
