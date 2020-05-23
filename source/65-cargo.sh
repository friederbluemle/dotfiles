CARGOPATH="$HOME/.cargo"
if [[ -d "$CARGOPATH/bin" ]]; then
  PATH="$CARGOPATH/bin:$PATH"
fi
