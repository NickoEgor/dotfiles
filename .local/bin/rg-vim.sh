#!/bin/sh

rg --vimgrep -F --hidden --no-messages \
    -g '!venv' \
    -g '!build' \
    -g '!.git' \
    -g '!ci' \
    "$@"
    # -g '!tests' \
