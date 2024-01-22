src=$HOME/src
alias inithomedirs="mkdir -p $HOME/{bin,src,tmp,wsrc}"
alias initvimplug="mkdir -p $HOME/.vim/autoload && git clone https://github.com/junegunn/vim-plug.git $src/junegunn/vim-plug && ln -s $src/junegunn/vim-plug/plug.vim $HOME/.vim/autoload/plug.vim"
alias initgitdiff="git clone https://github.com/so-fancy/diff-so-fancy.git $src/so-fancy/diff-so-fancy && ln -s $src/so-fancy/diff-so-fancy/diff-so-fancy $HOME/bin/diff-so-fancy"
alias initdotfiles="git clone https://github.com/friederbluemle/dotfiles.git $src/friederbluemle/dotfiles && ln -s $src/friederbluemle/dotfiles $HOME/.dotfiles"
alias initomz="git clone https://github.com/ohmyzsh/ohmyzsh.git $src/ohmyzsh/ohmyzsh && ln -s $src/ohmyzsh/ohmyzsh $HOME/.oh-my-zsh"
alias initomzfork="pushd $src/ohmyzsh/ohmyzsh && git remote add fb https://github.com/friederbluemle/ohmyzsh.git && git fetch fb && git checkout fb-custom && popd"
alias initzshrc="ln -s $src/ohmyzsh/ohmyzsh/templates/zshrc.zsh-template $HOME/.zshrc"
