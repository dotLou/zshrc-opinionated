#!/usr/local/bin/zsh
# dave.zsh-theme, stolen and modified from https://github.com/hairyhenderson/dotfiles/blob/master/themes/dave.zsh-theme
# Use with a dark background and 256-color terminal!

local ret_status="%(?::%{$fg_bold[red]%})"

function prompt_char {
  git branch >/dev/null 2>/dev/null && echo "±" && return
  echo '○'
}

function box_name {
    hostname -s
}

function k8s_context {
	if [ ! -z "command -v kubectl" ]; then
		#local GEAR="⚙"
		local GEAR="\u26F5"
		echo -ne "$FG[239]${GEAR}$reset_color $FG[033]$(kubectl config current-context)$reset_color"
	fi
}

local current_dir='${PWD/#$HOME/~}'
local git_info='$(git_prompt_info)'
local prompt_char='${ret_status}$(prompt_char)'
local k8s_info='$(k8s_context)'

PROMPT="%{$FG[239]%}╭─%{$reset_color%}%{$terminfo[bold]$FG[226]%}${current_dir}%{$reset_color%}${git_info} ${k8s_info}
%{$FG[239]%}╰─${prompt_char}%{$reset_color%} "

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$FG[239]%}⎇%{$reset_color%} %{$fg[255]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$FG[202]%}✘"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$FG[040]%}✔"
