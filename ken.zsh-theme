local return_code="%(?..%(130?..%{$fg[red]%}%? ↵%{$reset_color%}))"

if [[ "$(whoami)" == "root" ]]
then
    local user_host='%{$terminfo[bold]$fg[red]%}%n@%m%{$reset_color%}'
else
    local user_host='%{$terminfo[bold]$fg[green]%}%n@%m%{$reset_color%}'
fi

local current_dir='%{$terminfo[bold]$fg[blue]%}%~%{$reset_color%}'
local git_branch=''
local rbenv_version='${RBENV_VERSION:+" %{$fg[red]%}‹💎 ${RBENV_VERSION}›%{$reset_color%}"}'
local conda_env='${CONDA_DEFAULT_ENV:+" %{$fg[red]%}‹🐍 ${CONDA_DEFAULT_ENV}›%{$reset_color%}"}'
local ios_sdk='${IOS_SDK_VERSION:+" %{$fg[red]%}‹📱${IOS_SDK_VERSION}›%{$reset_color%}"}'

function rust_version() {
    if which rustup &>/dev/null; then
        local rustup_output="$(rustup show active-toolchain --verbose)"
        if echo $rustup_output | grep -q overridden
        then
            local rust_version_number="$(echo "${rustup_output}" | grep ^compiler | awk '{print $3}')"
            echo " %{$fg[red]%}‹🦀 ${rust_version_number}›%{$reset_color%}"
        fi
    elif which rustc &>/dev/null; then
        local rust_version_number="$(rustc --version | awk '{print $2}')"
        echo " %{$fg[red]%}‹🦀 ${rust_version_number}›%{$reset_color%}"
    fi
}

if which git &> /dev/null; then
  git_branch=' $(git_prompt_info)'
fi

PROMPT="╭─${user_host} ${current_dir}${conda_env}${rbenv_version}${ios_sdk}\$(rust_version)${git_branch}
╰─%B$%b "
RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$terminfo[bold]$fg[blue]%}«%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[blue]%}» %{$reset_color%}"
