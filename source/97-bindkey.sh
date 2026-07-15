bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# Completion menu selection: Enter executes the command line right away,
# Ctrl-J/Ctrl-K move the selection (fzf-style). Typing any ordinary
# character (e.g. Space) accepts the highlight and continues editing.
bindkey -M menuselect '^M' .accept-line
bindkey -M menuselect '^J' down-line-or-history
bindkey -M menuselect '^K' up-line-or-history
