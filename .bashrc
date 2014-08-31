echo "friederbluemle/dotfiles"

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    echo "Linux environment"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Mac OSX environment"
elif [[ "$OSTYPE" == "cygwin" ]]; then
    echo "Cygwin environment"
elif [[ "$OSTYPE" == "msys" ]]; then
    echo "msysGit environment"
elif [[ "$OSTYPE" == "freebsd"* ]]; then
    echo "FreeBSD environment"
else
    echo "Unsupported \$OSTYPE: $OSTYPE"
fi
