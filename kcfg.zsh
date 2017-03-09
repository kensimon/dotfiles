function kcfg() {
  if [[ -z "${1}" ]]
  then
    echo $(basename ${KUBECONFIG:-"<default>"})
  else
    export KUBECONFIG=~/.kube/${1}
  fi
}

_kcfg() {
  zstyle ":completion:*:*:kcfg:*:*" file-patterns '%p(^-/):other-files'
  _files -W "${HOME}/.kube"
}

compdef _kcfg kcfg
