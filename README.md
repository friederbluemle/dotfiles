# dotfiles

Personal dotfiles and setup scripts for macOS and Linux.

## Layout

- `bin/` - standalone utility scripts, added to `PATH` at shell startup
- `copy/` - files copied into `$HOME`, so local changes stay local
  (e.g. `.gitconfig`)
- `link/` - files symlinked into `$HOME` (e.g. `.vimrc`)
- `source/` - numbered fragments sourced in order at shell startup
- `manual/` - configs installed by hand (terminal emulators, window
  managers, key bindings, LaunchDaemons, agent instructions)
- `init.sh` - aliases for bootstrapping a new machine

## Bootstrap

`init.sh` defines one-shot aliases for setting up a new machine:

```sh
source init.sh
inithomedirs   # create ~/bin, ~/src, ~/tmp, ~/wsrc
initdotfiles   # clone this repo into ~/src and link ~/.dotfiles
initomz        # clone oh-my-zsh and link ~/.oh-my-zsh
initomzfork    # add my fork as a remote and check out its branch
initzshrc      # link ~/.zshrc to the oh-my-zsh template
```

Run only the ones you need. There are additional aliases for vim-plug,
diff-so-fancy, and other repos.

The aliases are parameterized by `GITHUB_USER` and `GITHUB_USER_SHORT`,
which default to my values; `initomzfork` checks out the fork's
`$GITHUB_USER_SHORT-custom` branch.

## Syncing

```sh
dotfiles
```

The `dotfiles` script (in `bin/`):

1. Fast-forwards the repo to the latest upstream, restarting itself if
   anything changed
2. Copies everything in `copy/` into `$HOME`, skipping files that are
   identical or newer at the destination
3. Symlinks everything in `link/` into `$HOME`

Existing files are backed up to `backups/<timestamp>/` before being
replaced.

## Shell startup

The fragments in `source/` are sourced in numeric order at shell
startup. They are kept shell-agnostic; zsh-only parts are guarded with
`$ZSH_VERSION` checks. The zsh configuration itself (theme, plugins,
options) lives in my oh-my-zsh fork, not in this repo.

## Scripts

Some of the utilities in `bin/`:

- `branches` - list recently checked-out git branches, or switch to one
  by index (aliased to `b` and `11`-`99`)
- `check-git` - show branch and short status for every git repo under
  the current directory
- `check-node-modules` - show disk usage of nearby `node_modules` dirs
- `node-switch` - download Node.js releases into `~/.node-versions` and
  switch the active version
- `git-fake-merge` - create a merge commit that records a branch as
  merged without changing the tree
- `adbsysui` - toggle Android systemui demo mode on a connected device

## Hostname fix

macOS may silently override the local hostname via DHCP, remote
management, or other network signals. A LaunchDaemon checks every
60 seconds and restores the desired value.

### Setup

```sh
echo 'my-hostname' | sudo tee /etc/fix-hostname
sudo cp ~/.dotfiles/bin/fbfh /usr/local/bin/
sudo chown root:wheel /usr/local/bin/fbfh
sudo cp ~/.dotfiles/manual/LaunchDaemons/org.fbluemle.fbfh.plist /Library/LaunchDaemons/
sudo chown root:wheel /Library/LaunchDaemons/org.fbluemle.fbfh.plist
sudo launchctl bootstrap system/ /Library/LaunchDaemons/org.fbluemle.fbfh.plist
```

The script is copied to a root-owned location so the daemon never
executes a user-writable file as root.

### Removal

```sh
sudo launchctl bootout system/org.fbluemle.fbfh
sudo rm /Library/LaunchDaemons/org.fbluemle.fbfh.plist /usr/local/bin/fbfh
```

## Credits

Projects this repo is based on or works closely with:

- [cowboy/dotfiles][1] - the `dotfiles` sync script (copy/link/backup)
  is adapted from Ben Alman's dotfiles
- [ohmyzsh/ohmyzsh][2] - the zsh setup builds on oh-my-zsh via a
  personal fork
- [junegunn/vim-plug][3] - vim plugin manager used by the linked
  `.vimrc`
- [so-fancy/diff-so-fancy][4] - human-readable git diffs, wired up in
  `.gitconfig`

## License

[MIT](LICENSE)

[1]: https://github.com/cowboy/dotfiles
[2]: https://github.com/ohmyzsh/ohmyzsh
[3]: https://github.com/junegunn/vim-plug
[4]: https://github.com/so-fancy/diff-so-fancy
