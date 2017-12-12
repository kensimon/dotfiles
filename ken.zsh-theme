local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

local user_host='%{$terminfo[bold]$fg[green]%}%n@%m%{$reset_color%}'
local current_dir='%{$terminfo[bold]$fg[blue]%}%~%{$reset_color%}'
local git_branch=''
local rbenv_version='${RBENV_VERSION:+" %{$fg[red]%}‹rbenv:${RBENV_VERSION}›%{$reset_color%}"}'
local conda_env='${CONDA_DEFAULT_ENV:+" %{$fg[red]%}‹conda:${CONDA_DEFAULT_ENV}›%{$reset_color%}"}'

if which git &> /dev/null; then
  git_branch=' $(git_prompt_info)'
fi

PROMPT="╭─${user_host} ${current_dir}${conda_env}${rbenv_version}${git_branch}
╰─%B$%b "
RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$terminfo[bold]$fg[blue]%}«%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[blue]%}» %{$reset_color%}"
