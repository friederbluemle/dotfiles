NVM_DIR=$HOME/.nvm
if [[ -d $NVM_DIR ]]; then
  export NVM_DIR
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
else
  NVM_DIR=/usr/share/nvm
  if [[ -d $NVM_DIR ]]; then
    source /usr/share/nvm/init-nvm.sh
  fi
fi
NODE_MODULES_DIR=$HOME/.node_modules
if [[ -d $NODE_MODULES_DIR ]]; then
  export npm_config_prefix=$NODE_MODULES_DIR
  PATH="$NODE_MODULES_DIR/bin:$PATH"
fi
