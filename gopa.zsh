# gopa is a dumb function to switch the $GOPATH environment variable to various
# go.* gopaths in ~/dev
function gopa() {
  if [[ -n "${1}" ]]
  then
    export GOPATH="${HOME}/dev/${1}"
  fi
  echo $GOPATH
}

_gopa() {
  zstyle ":completion:*:*:gopa:*:*" file-patterns 'go.*:directories'
  _files -g "go." -W "${HOME}/dev" 
}

compdef _gopa gopa
