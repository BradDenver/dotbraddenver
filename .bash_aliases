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
_completion_loader git
# assign git's completion function _git to gi
complete -o bashdefault -o default -o nospace -F _git g

# load git completions
# if [ -f `brew --prefix`/etc/bash_completion ]; then
#   . `brew --prefix`/etc/bash_completion
# fi
# complete -o default -o nospace -F _git g

