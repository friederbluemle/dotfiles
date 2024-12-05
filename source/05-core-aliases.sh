export GITHUB_ROOT=$HOME/src
export GITHUB_USER=friederbluemle
export GITHUB_USER_SHORT=fb
export SRC_ROOT=$GITHUB_ROOT
export MISC_ROOT=$SRC_ROOT/$GITHUB_USER/misc

alias inithomedirs="mkdir -p $HOME/{bin,src,tmp,wsrc}"
alias initvimplug="mkdir -p $HOME/.vim/autoload && git clone https://github.com/junegunn/vim-plug.git $SRC_ROOT/junegunn/vim-plug && ln -s $SRC_ROOT/junegunn/vim-plug/plug.vim $HOME/.vim/autoload/plug.vim"
alias initgitdiff="git clone https://github.com/so-fancy/diff-so-fancy.git $SRC_ROOT/so-fancy/diff-so-fancy && ln -s $SRC_ROOT/so-fancy/diff-so-fancy/diff-so-fancy $HOME/bin/diff-so-fancy"
alias initdotfiles="git clone https://github.com/$GITHUB_USER/dotfiles.git $SRC_ROOT/$GITHUB_USER/dotfiles && ln -s $SRC_ROOT/$GITHUB_USER/dotfiles $HOME/.dotfiles"
alias initomz="git clone https://github.com/ohmyzsh/ohmyzsh.git $SRC_ROOT/ohmyzsh/ohmyzsh && ln -s $SRC_ROOT/ohmyzsh/ohmyzsh $HOME/.oh-my-zsh"
alias initomzfork="pushd $SRC_ROOT/ohmyzsh/ohmyzsh && git remote add $GITHUB_USER_SHORT https://github.com/$GITHUB_USER/ohmyzsh.git && git fetch --all && git checkout $GITHUB_USER_SHORT-custom && popd"
alias initzshrc="ln -s $SRC_ROOT/ohmyzsh/ohmyzsh/templates/zshrc.zsh-template $HOME/.zshrc"

alias cb='cd ~/bin'
alias cs='cd ~/src'
alias ct='cd ~/tmp'
alias cw='cd ~/wsrc'
