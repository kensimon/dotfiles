# gopa is a dumb function to switch the $GOPATH environment variable to various
# go.* gopaths in ~/dev
function gopa() {
  if [[ -z "${1}" ]]
  then
    export GOPATH="${HOME}/dev/go"
  else
    export GOPATH="${1}"
  fi
  echo $GOPATH
}

_gopa() {
  #zstyle ":completion:*:*:gopa:*:*" file-patterns '%p(^-/):other-files'
  _path_files -/ -W "${HOME}/dev/go.*" 
}

compdef _gopa gopa
