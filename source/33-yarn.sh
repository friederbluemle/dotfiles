if [ -d "$HOME/.yarn/bin" ]; then
  export PATH="$HOME/.yarn/bin:$PATH"
fi

if [ -x "$(brew --prefix 2>/dev/null)/bin/yarn" ]; then
  alias yarn1="$(brew --prefix)/bin/yarn"
fi
