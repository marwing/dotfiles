if command -v op 2>&1 >/dev/null; then
  eval "$(op completion zsh)"; compdef _op op # op
fi
