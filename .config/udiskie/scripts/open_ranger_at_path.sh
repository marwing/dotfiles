#!/bin/sh

exec "${TERMINAL:-alacritty}" -e ranger "$@"
