#!/bin/sh

# This script installes the dotfiles in this repository into the HOME directory
# of the executing user. It does not install any software that uses said
# dotfiles. Any preexisting dotfiles that conflict with files in this
# repository are moved into a backup folder in the users home directory.

cd "$HOME" || exit 1

GIT_URL="https://gitlab.com/marwing/dotfiles.git"
CONFIG_BACKUP="$HOME/.config_backup"
DOTFILES_DIR="$HOME/.dotfiles"
BRANCH="${1:-master}"

dotfiles() {
  git --git-dir="$DOTFILES_DIR" --work-tree="$HOME" "$@"
}

set -e

if ! command -v git > /dev/null 2>&1; then
  echo "Missing git dependency"
  exit 2
fi

# setup repo
git clone --bare "$GIT_URL" "$DOTFILES_DIR"
dotfiles config --local status.showUntrackedFiles no

if ! dotfiles checkout "$BRANCH"; then
  echo "Backing up old dotfiles to '$CONFIG_BACKUP'"
  mkdir -p "$CONFIG_BACKUP"

  for file in $(dotfiles checkout 2>&1 | grep -E "\s+\." | awk '{ print $1 }'); do
    echo "moving $file to $CONFIG_BACKUP/$file"
    mkdir -p "$CONFIG_BACKUP/$(dirname "$file")"
    mv "$file" "$CONFIG_BACKUP/$file"
  done

  echo "Retrying checkout..."
  dotfiles checkout "$BRANCH"
else
  echo "Checked out dotfiles"
fi

dotfiles submodule update --init

# install oh-my-zsh
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.config/zsh/.oh-my-zsh
