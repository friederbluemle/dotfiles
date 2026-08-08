# Keep PATH and fpath entries unique; nested shells and repeated
# sourcing re-add the same directories otherwise.
# Both sides of each tied pair need the flag: scalar assignments like
# PATH=x:$PATH bypass dedup when only the array is flagged.
# -g is required: this file is sourced from inside the src() function,
# and a plain typeset would create function-local variables instead.
# shellcheck disable=SC2034  # path and fpath are zsh builtins, not unused
[ -n "$ZSH_VERSION" ] && typeset -gU PATH path FPATH fpath
