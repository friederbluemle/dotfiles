if [ -d "$HOME/.yarn/bin" ]; then
  export PATH="$HOME/.yarn/bin:$PATH"
fi

if [ -x "$HOMEBREW_PREFIX/bin/yarn" ]; then
  # Alias intentionally expands at definition time.
  # shellcheck disable=SC2139
  alias yarn1="$HOMEBREW_PREFIX/bin/yarn"
fi
