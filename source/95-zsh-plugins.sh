if [ -n "$ZSH_VERSION" ]; then
  if [[ -f "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  else
    if [[ -f "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
      source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    fi
    if [[ -f "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
      source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    fi
  fi
  if [[ -f "/usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh" ]]; then
    source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
  else
    if [[ -f "/usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh" ]]; then
      source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh
    fi
    if [[ -f "/opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh" ]]; then
      source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh
    fi
  fi
fi
