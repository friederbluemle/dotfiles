NODE_MODULES_DIR=$HOME/.node_modules
if [[ -d $NODE_MODULES_DIR ]]; then
  if [[ -z "$npm_config_prefix" ]]; then
    export npm_config_prefix=$NODE_MODULES_DIR
    PATH="$NODE_MODULES_DIR/bin:$PATH"
  fi
else
  NVM_SOURCE=/usr/share/nvm
  if [[ -d $NVM_SOURCE ]]; then
    [ -s "$NVM_SOURCE/init-nvm.sh" ] && . "$NVM_SOURCE/init-nvm.sh"
  fi
fi

# On macOS, open React Native bundler in normal Terminal app
if [[ "$OSTYPE" = darwin* ]]; then
  export REACT_TERMINAL=Terminal
fi
