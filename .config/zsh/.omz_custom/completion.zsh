if (( $+commands[op] )); then
  eval "$(op completion zsh)"; compdef _op op # op
fi

if (( $+commands[ykman] )); then
  eval "$(_YKMAN_COMPLETE=zsh_source ykman)"
fi
