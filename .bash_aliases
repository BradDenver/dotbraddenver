alias be='bundle exec'
alias dc="docker-compose"
alias l='ls -Al'
alias v="vim"
alias va="vagrant"


# FUNCTIONS

# Create a new directory and enter it
function md() {
  mkdir -p "$@" && cd "$@"
}

# browse style cd
function c() {
  while true
  do
    clear
    echo "pwd: $PWD"
    ls -ACFG
    read -e -p "cd into > " answer
    case "$answer" in
      q) break;;
      *) cd $answer;;
    esac
  done
}

# http://tilvim.com/2013/05/02/g-function.html
function g {
  if [[ $# > 0 ]]; then
    git $@
  else
    git status
  fi
}

# load git completions
# https://github.com/git/git/blob/master/contrib/completion/git-completion.bash
if [ -f ~/dotbraddenver/.git-completion.bash ]; then
  source ~/dotbraddenver/.git-completion.bash

  # assign git's completion function _git to g
  # complete -o default -o nospace -F _git g
  complete -o bashdefault -o default -o nospace -F _git g
fi

#https://github.com/ggreer/the_silver_searcher/wiki/Advanced-Usage
if [ -f ~/dotbraddenver/.ignore ]; then
  alias ag='ag --path-to-ignore ~/dotbraddenver/.ignore'
  alias rg='rg --ignore-file ~/dotbraddenver/.ignore'
fi
