#!/usr/bin/env bash

# Exercise bin/dotlink against a blank $HOME holding a copy of this
# checkout, covering deploy and adopt in both path forms, dot-less
# destinations, symlinked directories, idempotence, and every refusal.
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
cp -R "$repo/bin" "$repo/manual" "$HOME/src/dotfiles/"
ln -s src/dotfiles "$HOME/.dotfiles"
dotfiles=$HOME/.dotfiles

dotlink() { "$dotfiles/bin/dotlink" "$@"; }

# refuse <message> <args...>: dotlink must fail and print the message.
refuse() {
  local msg=$1 out; shift
  if out=$(dotlink "$@" 2>&1); then fail "dotlink $* succeeded: $out"; fi
  [[ "$out" == *"$msg"* ]] || fail "dotlink $*: $out"
}

# links_to <link> <target>: link exists, has that target, and resolves.
links_to() {
  [[ -L "$1" && "$(readlink "$1")" == "$2" && -e "$1" ]] \
    || fail "$1 -> $(readlink "$1" || echo missing), want $2"
}

mkdir -p "$dotfiles/manual/config/yabai" "$dotfiles/manual/Library/KeyBindings" \
  "$dotfiles/manual/config/kitty" "$dotfiles/manual/store/app" "$dotfiles/manual/ext"
echo yabai > "$dotfiles/manual/config/yabai/yabairc"
echo dict > "$dotfiles/manual/Library/KeyBindings/x.dict"
echo kitty > "$dotfiles/manual/config/kitty/kitty.conf"
echo app > "$dotfiles/manual/store/app/conf"
echo ext > "$dotfiles/manual/ext/conf"

# Deploy: shorthand, absolute repo path, manual/ path.
dotlink config/yabai
links_to "$HOME/.config/yabai" ../.dotfiles/manual/config/yabai
dotlink "$dotfiles/manual/config/kitty/kitty.conf"
links_to "$HOME/.config/kitty/kitty.conf" ../../.dotfiles/manual/config/kitty/kitty.conf
dotlink manual/i3blocks.conf
links_to "$HOME/.i3blocks.conf" .dotfiles/manual/i3blocks.conf

# Deploy keeps the undotted name when it already exists in $HOME.
mkdir "$HOME/Library"
dotlink Library/KeyBindings/x.dict
links_to "$HOME/Library/KeyBindings/x.dict" ../../.dotfiles/manual/Library/KeyBindings/x.dict

# Deploy into symlinked directories: the relative target must count
# from the physical location; outside $HOME it must be absolute.
mkdir -p "$HOME/deep/er/store"
ln -s deep/er/store "$HOME/.store"
dotlink store/app
links_to "$HOME/.store/app" ../../../.dotfiles/manual/store/app
outside=$(mktemp -d)
ln -s "$outside" "$HOME/.ext"
dotlink ext/conf
links_to "$HOME/.ext/conf" "$dotfiles/manual/ext/conf"

# Deploy is idempotent and refuses to clobber anything else.
[[ "$(dotlink config/yabai)" == *"Already linked"* ]] || fail "deploy not idempotent"
echo mine > "$HOME/.config/kitty/mine"
mkdir -p "$dotfiles/manual/config/kitty" && echo repo > "$dotfiles/manual/config/kitty/mine"
refuse "Refusing to overwrite" config/kitty/mine
[[ "$(cat "$HOME/.config/kitty/mine")" == mine ]] || fail "deploy clobbered a file"
ln -s /elsewhere "$HOME/.config/kitty/other"
echo repo > "$dotfiles/manual/config/kitty/other"
refuse "Refusing to replace" config/kitty/other
refuse "Only files under manual/" "$dotfiles/bin/dotlink"
refuse "Not found" nonexistent
refuse "Usage:"

# Adopt: a file by absolute path, a directory by relative path.
echo vim > "$HOME/.vimrc"
dotlink "$HOME/.vimrc"
links_to "$HOME/.vimrc" .dotfiles/manual/vimrc
[[ "$(cat "$dotfiles/manual/vimrc")" == vim ]] || fail "adopted file lost"
mkdir -p "$HOME/.foo/bar" && echo z > "$HOME/.foo/bar/z"
(cd "$HOME/.foo" && dotlink bar)
links_to "$HOME/.foo/bar" ../.dotfiles/manual/foo/bar
[[ -f "$dotfiles/manual/foo/bar/z" ]] || fail "adopted directory lost"
[[ "$(dotlink "$HOME/.vimrc")" == *"Already linked"* ]] || fail "adopt not idempotent"

# Adopt refusals leave the source untouched.
echo p > "$HOME/plain"
refuse "Not a dotfile" "$HOME/plain"
refuse "outside" "$outside/conf"
echo dup > "$HOME/.dup" && echo repo > "$dotfiles/manual/dup"
refuse "Refusing to overwrite" "$HOME/.dup"
[[ -f "$HOME/.dup" && ! -L "$HOME/.dup" ]] || fail "refused adopt moved the file"
ln -s /elsewhere "$HOME/.foreign"
refuse "Refusing to adopt symlink" "$HOME/.foreign"

# A failed move must stop before linking (root ignores permissions).
if [[ $EUID -ne 0 ]]; then
  mkdir -p "$HOME/.baz/sub" && echo q > "$HOME/.baz/sub/q"
  mkdir "$dotfiles/manual/baz" && chmod a-w "$dotfiles/manual/baz"
  refuse "Permission denied" "$HOME/.baz/sub"
  [[ -f "$HOME/.baz/sub/q" && -z "$(find "$HOME/.baz" -type l)" ]] \
    || fail "failed adopt left a link behind"
  chmod u+w "$dotfiles/manual/baz"
fi

echo "PASS: dotlink in $HOME"
