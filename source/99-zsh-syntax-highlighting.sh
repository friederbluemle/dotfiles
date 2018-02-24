if [ -n "$ZSH_VERSION" ]; then
  if [[ -f "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  else
    if [[ -f "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
      source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    fi
  fi
fi
