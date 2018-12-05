if [[ -z $GROOVY_HOME ]]; then
  PATHS=(
  "/usr/local/opt/groovy/libexec"
  )
  for p in "${PATHS[@]}"
  do
    if [[ -d $p ]]; then
      export GROOVY_HOME=$p
      break
    fi
  done
fi
