alias be='bundle exec'
alias l='ls -Al'
alias v="vim -N -u ~/dotbraddenver/.vimrc"

# FUNCTIONS

# Create a new directory and enter it
function md() {
  mkdir -p "$@" && cd "$@"
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

