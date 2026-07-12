# Shims alone make ruby/gem/bundle resolve; defer the rbenv init fork
# until the rbenv command itself is first used.
if command -v rbenv >/dev/null; then
  export PATH="${RBENV_ROOT:-$HOME/.rbenv}/shims:$PATH"
  rbenv() {
    unset -f rbenv
    eval "$(command rbenv init - --no-rehash zsh)"
    rbenv "$@"
  }
fi
