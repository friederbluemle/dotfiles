#!/usr/bin/env bash

# Bootstrap a blank $HOME from this checkout, simulating a new machine:
# run the init.sh aliases, the dotfiles sync script, and an interactive
# zsh startup, asserting on the results after each stage.
#
# Never touches the real $HOME; safe to run locally. Requires git, zsh,
# and network access (clones oh-my-zsh and friends). The zsh startup
# check expects the omz plugins' tools (autojump, direnv, fzf) to be
# installed; missing ones show up as stderr output.

set -euo pipefail
shopt -s expand_aliases

repo=$(cd "$(dirname "$0")/.." && pwd)

fail() { echo "FAIL: $*" >&2; exit 1; }

# Blank, isolated home.
HOME=$(mktemp -d)
export HOME
cd "$HOME"
export TERM="${TERM:-xterm-256color}"

source "$repo/init.sh"

# Serve this checkout's HEAD where initdotfiles expects the GitHub repo.
mirror=$(mktemp -d)
mirror_repo=$mirror/$GITHUB_USER/dotfiles.git
git init --quiet --bare "$mirror_repo"
git -C "$repo" push --quiet "$mirror_repo" "HEAD:$(git -C "$mirror_repo" symbolic-ref HEAD)"

inithomedirs
export GIT_BASE="file://$mirror"
initdotfiles
unset GIT_BASE
initomz
initomzfork
initzshrc
initvimplug
initgitdiff

[[ -L "$HOME/.dotfiles" && -f "$HOME/.dotfiles/init.sh" ]] || fail "dotfiles link missing or wrong"
[[ -f "$HOME/.zshrc" ]] || fail "zshrc link missing or dangling"
[[ -f "$HOME/.vim/autoload/plug.vim" ]] || fail "vim-plug missing"
[[ -x "$HOME/bin/diff-so-fancy" ]] || fail "diff-so-fancy missing"

# First sync copies and links files into $HOME.
"$HOME/.dotfiles/bin/dotfiles"
[[ -f "$HOME/.gitconfig" && ! -L "$HOME/.gitconfig" ]] || fail "gitconfig not copied"
[[ -L "$HOME/.vimrc" && -f "$HOME/.vimrc" ]] || fail "vimrc not linked"

# Second sync must skip everything and take no backups.
"$HOME/.dotfiles/bin/dotfiles"
[[ ! -d "$HOME/.dotfiles/backups" ]] || fail "second sync was not idempotent"

# Interactive zsh startup: .zshrc -> oh-my-zsh -> fork custom config,
# which puts bin/ on PATH and sources the fragments.
out=$(zsh -i -c 'whence -p dotfiles && print -r -- "$EDITOR"' 2>"$HOME/zsh-stderr") \
  || { cat "$HOME/zsh-stderr" >&2; fail "interactive zsh exited nonzero"; }
[[ "$out" == "$HOME/.dotfiles/bin/dotfiles"$'\n'"vim" ]] \
  || fail "unexpected zsh startup state: $out"
# fzf's key-bindings and completion scripts end by restoring a saved
# option list that includes "zle on", which zsh rejects without a tty.
noise="can't change option: zle"
if grep -v "$noise" "$HOME/zsh-stderr" | grep -q .; then
  grep -v "$noise" "$HOME/zsh-stderr" >&2
  fail "zsh startup wrote to stderr"
fi

echo "PASS: bootstrapped in $HOME"
