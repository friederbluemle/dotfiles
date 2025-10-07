if [ -x "$(command -v yarn)" ]; then
  export PATH="$(yarn global bin):$PATH"
fi
