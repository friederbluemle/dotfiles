#!/usr/bin/env bash

# Exercise bin/dotlink against a blank $HOME: deploy, adopt, idempotence,
# a symlinked destination, and the two ways it must refuse to proceed.
#
# Never touches the real $HOME; safe to run locally.

set -euo pipefail

repo=$(cd "$(dirname "$0")/.." && pwd)

fail() { echo "FAIL: $*" >&2; exit 1; }

# Blank, isolated home with the repo linked like initdotfiles does.
HOME=$(mktemp -d)
export HOME
cd "$HOME"
mkdir -p "$HOME/src/dotfiles"
cp -R "$repo/bin" "$HOME/src/dotfiles/"
ln -s src/dotfiles "$HOME/.dotfiles"
dotfiles=$HOME/.dotfiles

dotlink() { "$dotfiles/bin/dotlink" "$@"; }

# links_to <link> <target>: link exists, has that target, and resolves.
links_to() {
  [[ -L "$1" && "$(readlink "$1")" == "$2" && -e "$1" ]] \
    || fail "$1 -> $(readlink "$1" || echo missing), want $2"
}

mkdir -p "$dotfiles/manual/config/yabai" "$dotfiles/manual/store/app"
echo yabai > "$dotfiles/manual/config/yabai/yabairc"
echo app > "$dotfiles/manual/store/app/conf"

# Deploy, idempotently.
dotlink config/yabai
links_to "$HOME/.config/yabai" ../.dotfiles/manual/config/yabai
[[ "$(dotlink config/yabai)" == *"Already linked"* ]] || fail "deploy not idempotent"

# Deploy into a symlinked directory: the relative target must count
# from the physical location.
mkdir -p "$HOME/deep/er/store"
ln -s deep/er/store "$HOME/.store"
dotlink store/app
links_to "$HOME/.store/app" ../../../.dotfiles/manual/store/app

# Deploy refuses to clobber an existing file.
echo mine > "$HOME/.config/yabai.conf"
echo repo > "$dotfiles/manual/config/yabai.conf"
if dotlink config/yabai.conf; then fail "deploy over an existing file succeeded"; fi
[[ "$(cat "$HOME/.config/yabai.conf")" == mine ]] || fail "deploy clobbered a file"

# Adopt, idempotently.
echo vim > "$HOME/.vimrc"
dotlink "$HOME/.vimrc"
links_to "$HOME/.vimrc" .dotfiles/manual/vimrc
[[ "$(cat "$HOME/.vimrc")" == vim ]] || fail "adopted file lost"
[[ "$(dotlink "$HOME/.vimrc")" == *"Already linked"* ]] || fail "adopt not idempotent"

# A failed move must stop before linking (root ignores permissions).
if [[ $EUID -ne 0 ]]; then
  mkdir -p "$HOME/.baz/sub" && echo q > "$HOME/.baz/sub/q"
  mkdir "$dotfiles/manual/baz" && chmod a-w "$dotfiles/manual/baz"
  if dotlink "$HOME/.baz/sub"; then fail "adopt succeeded despite failed move"; fi
  [[ -f "$HOME/.baz/sub/q" && -z "$(find "$HOME/.baz" -type l)" ]] \
    || fail "failed adopt left a link behind"
  chmod u+w "$dotfiles/manual/baz"
fi

echo "PASS: dotlink in $HOME"
