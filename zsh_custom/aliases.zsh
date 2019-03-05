# Extra aliases
alias cleanBranches="git branch --merged master | grep -v master | xargs -n 1 git branch -d"

if [[ -f "${HOME}/.nvm/versions/node/v8.1.2/bin/gtop" ]]; then
  alias top=${HOME}/.nvm/versions/node/v8.1.2/bin/gtop
fi

alias dnpm='docker run --rm -v `pwd`:/usr/src/app -w /usr/src/app node:8.11-alpine npm'

if [[ $(command -v thefuck) ]]; then
  eval $(thefuck --alias)
fi
