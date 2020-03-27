if [[ -z $ANDROID_SDK_ROOT ]]; then
  PATHS=(
    "/opt/android-sdk"
    "/opt/android-sdk-linux"
    "/Users/$USER/Library/Android/sdk"
  )

  for p in "${PATHS[@]}"
  do
    if [[ -d $p ]]; then
      export ANDROID_HOME=$p
      export ANDROID_SDK_ROOT=$p
      PATH=$PATH:$p/tools:$p/tools/bin:$p/platform-tools
      break
    fi
  done
fi
