FASTPATH="$HOME/.fastlane"
if [[ -d "$FASTPATH/bin" ]]; then
  PATH=$PATH:$FASTPATH/bin
fi
