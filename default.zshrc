# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# ZSH_THEME="avit"
# ZSH_THEME="pure"
ZSH_THEME=${ZSH_THEME:="dave"}

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Automatically use the version of node specified in .nvmrc of a given dir
NVM_AUTO_USE=true

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
ZSH_CUSTOM=$HOME/dotlou/zshrc-opinionated/zsh_custom

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins+=(git docker nvm kubectl zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

export EDITOR='vim'

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Load the shell dotfiles, and then some:
# * ~/.extra can be used for other settings you don’t want to commit.

local extraFile=$HOME/.extra

if [[ -r "$extraFile" && -f "$extraFile" ]]; then
	source $extraFile
fi
for file in $HOME/dotlou/zshrc-opinionated/*.zshrc; do
  if [[ "$file" == *"default.zshrc" ]]; then
    continue
  fi
	if [[ -r "$file" &&  -f "$file" ]]; then
		source "$file"
	fi
done
unset file

# Recursively load other extras. This is useful if you have some git repositories or a series of other files to run
if [[ -d "$HOME/.zsh_extras" ]]; then
  for file in $(find $HOME/.zsh_extras -type f -name "*.zshrc"); do
    if [[ -r "$file" &&  -f "$file" ]]; then
      source "$file"
    fi
  done
fi


if [[ $(command -v helm) ]]; then
  # Fix for autocomplete from https://github.com/helm/helm/issues/5046#issuecomment-463576351
  source <(helm completion zsh | sed -E 's/\["(.+)"\]/\[\1\]/g')
fi

if [[ $(command -v az) && -f "/usr/local/etc/bash_completion.d/az" ]]; then
  autoload bashcompinit && bashcompinit
  source /usr/local/etc/bash_completion.d/az
fi

if [[ $(command -v kubectl) ]]; then
  source <(kubectl completion zsh)
fi

if [[ -d "/usr/local/share/zsh-completions" ]]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi

if [[ -d "/usr/local/share/zsh-syntax-highlighting" ]]; then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
if [ $(command -v iterm2_set_user_var) ] && [ $(command -v kubectx) ]; then
  iterm2_print_user_vars() {
    # example usage in iterm2 badge: \(user.kubecontext):\(user.kubenamespace)
    K8s_CONTEXT=$(kubectl config current-context)
    K8s_NAMESPACE="$(kubectl config view -o=jsonpath="{.contexts[?(@.name==\"${K8s_CONTEXT}\")].context.namespace}")" \
      || exit_err "error getting current namespace"
    iterm2_set_user_var kubecontext $K8s_CONTEXT
    iterm2_set_user_var kubenamespace $K8s_NAMESPACE
  }
fi


# Allow watch command to support alias expansion (e.g. watch ll)
if [[ $(command -v watch) ]]; then
  alias watch='watch '
fi

## kubectx and kubens shortcuts since homebrew removed the possibility for --with-short-names to work
if [ $(command -v kubectx) ] && ! [ $(command -v kctx) ]; then
  CMD="$(which kubectx)"
  ln -s $CMD /usr/local/bin/kctx || alias kctx=$CMD
fi
if [ $(command -v kubens) ] && ! [ $(command -v kns) ]; then
  CMD="$(which kubens)"
  ln -s $CMD /usr/local/bin/kns || alias kns=$CMD
fi

if [[ -d "${HOME}/Library/Python/2.7/bin" ]]; then
  export PATH=$PATH:$HOME/Library/Python/2.7/bin
fi

if [[ $(command -v minishift) ]]; then
  eval $(minishift oc-env) || echo "no minishift running, oc command not setup"
fi

# For elastic charts dev, use local charts by default
export LOCAL_CHARTS=true
