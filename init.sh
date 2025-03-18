export GITHUB_USER=${GITHUB_USER:=friederbluemle}
export GITHUB_USER_SHORT=${GITHUB_USER_SHORT:=fb}
export SRC_ROOT=$HOME/src

function gcl2src() {
    git clone https://github.com/$1.git $SRC_ROOT/$1
}

alias inithomedirs="mkdir -p $HOME/{bin,src,tmp,wsrc}"
alias initvimplug="mkdir -p $HOME/.vim/autoload && gcl2src junegunn/vim-plug && ln -s $SRC_ROOT/junegunn/vim-plug/plug.vim $HOME/.vim/autoload/plug.vim"
alias initgitdiff="gcl2src so-fancy/diff-so-fancy && ln -s $SRC_ROOT/so-fancy/diff-so-fancy/diff-so-fancy $HOME/bin/diff-so-fancy"
alias initdotfiles="gcl2src $GITHUB_USER/dotfiles && ln -s $SRC_ROOT/$GITHUB_USER/dotfiles $HOME/.dotfiles"
alias initmisc="gcl2src $GITHUB_USER/misc && ln -s $SRC_ROOT/$GITHUB_USER/misc $HOME/.misc"
alias initomz="gcl2src ohmyzsh/ohmyzsh && ln -s $SRC_ROOT/ohmyzsh/ohmyzsh $HOME/.oh-my-zsh"
alias initomzfork="pushd $SRC_ROOT/ohmyzsh/ohmyzsh && git remote add $GITHUB_USER_SHORT https://github.com/$GITHUB_USER/ohmyzsh.git && git fetch --all && git checkout $GITHUB_USER_SHORT-custom && popd"
alias initzshrc="ln -s $SRC_ROOT/ohmyzsh/ohmyzsh/templates/zshrc.zsh-template $HOME/.zshrc"
