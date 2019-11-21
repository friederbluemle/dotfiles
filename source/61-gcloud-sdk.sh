if [ -n "$ZSH_VERSION" ]; then
  if [[ -f "$HOME/.gcloud-sdk/path.zsh.inc" ]]; then
    source "$HOME/.gcloud-sdk/path.zsh.inc"
  fi
  if [[ -f "$HOME/.gcloud-sdk/completion.zsh.inc" ]]; then
    source "$HOME/.gcloud-sdk/completion.zsh.inc"
  fi
fi
