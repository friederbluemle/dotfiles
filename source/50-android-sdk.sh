ANDROID_HOME=/opt/android-sdk-linux
if [[ -d $ANDROID_HOME ]]; then
  export ANDROID_HOME
  export PATH=$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH
fi