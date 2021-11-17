if (( $+commands[op] )); then
  eval "$(op completion zsh)"; compdef _op op # op
fi
