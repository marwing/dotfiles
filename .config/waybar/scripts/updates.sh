#!/bin/sh

command_exists() {
  if command -v $1 > /dev/null 2>&1; then
    return 0;
  else
    return 1;
  fi
}

get_updates_count_fwupd() {
  if command_exists fwupdmgr; then
    fwupdmgr --json get-updates | jq '.Devices | length'
  fi
}

get_updates_count_pacman() {
  if command_exists checkupdates; then
    checkupdates | wc -l
  elif command_exists pacman; then
    pacman -Qu | grep -v "\[ignored\]" | wc -l
  fi
}

get_updates_count_aur() {
  if command_exists paru; then
    paru -Qua | grep -v "\[ignored\]" | wc -l
  fi
}

FWUPD_UPDATE_COUNT=$(get_updates_count_fwupd)
PACMAN_UPDATE_COUNT=$(get_updates_count_pacman)
AUR_UPDATE_COUNT=$(get_updates_count_aur)

echo "{ \"text\": \"$((${FWUPD_UPDATE_COUNT} + ${PACMAN_UPDATE_COUNT} + ${AUR_UPDATE_COUNT}))\", \"tooltip\": \"fwupd: ${FWUPD_UPDATE_COUNT}\\npacman: ${PACMAN_UPDATE_COUNT}\\nAUR: ${AUR_UPDATE_COUNT}\" }"
