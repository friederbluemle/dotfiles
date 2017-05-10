GOPATH=~/.go
if [[ -d $GOPATH ]]; then
  export GOPATH
  export PATH=$PATH:$GOPATH/bin
fi
