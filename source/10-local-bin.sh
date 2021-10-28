# set PATH so it includes user's local bin if it exists
if [[ -d "$HOME/.local/bin" ]]; then
  export PATH=$HOME/.local/bin:$PATH
fi
