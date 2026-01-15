if [ -x "$(command -v yarn)" ]; then
  export PATH="$(yarn global bin):$PATH"
fi

if [ -x "$(brew --prefix 2>/dev/null)/bin/yarn" ]; then
  alias yarn1="$(brew --prefix)/bin/yarn"
fi
