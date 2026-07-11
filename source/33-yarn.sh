if [ -d "$HOME/.yarn/bin" ]; then
  export PATH="$HOME/.yarn/bin:$PATH"
fi

if [ -x "$HOMEBREW_PREFIX/bin/yarn" ]; then
  alias yarn1="$HOMEBREW_PREFIX/bin/yarn"
fi
