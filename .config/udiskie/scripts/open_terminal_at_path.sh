#!/bin/sh

exec "${TERMINAL:-alacritty}" --working-directory "$@"
