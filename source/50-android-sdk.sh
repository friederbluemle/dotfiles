PATHS=(
  "/opt/android-sdk"
  "/opt/android-sdk-linux"
  "/Users/$USER/Library/Android/sdk"
)

for p in "${PATHS[@]}"
do
  if [[ -d $p ]]; then
    export ANDROID_HOME=$p
    PATH=$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH
    break
  fi
done
