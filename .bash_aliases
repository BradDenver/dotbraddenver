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

# create github origin for local repe
# if not local repo git init first
# https://viget.com/extend/create-a-github-repo-from-the-command-line
github-create() {
  repo_name=$1
 
  dir_name=`basename $(pwd)`
 
  if [ "$repo_name" = "" ]; then
    echo "Repo name (hit enter to use '$dir_name')?"
    read repo_name
  fi
 
  if [ "$repo_name" = "" ]; then
    repo_name=$dir_name
  fi
 
  username=`git config github.user`
  if [ "$username" = "" ]; then
    echo "Could not find username, run 'git config --global github.user <username>'"
    invalid_credentials=1
  fi
 
  token=`git config github.token`
  if [ "$token" = "" ]; then
    echo "Could not find token, run 'git config --global github.token <token>'"
    invalid_credentials=1
  fi
 
  if [ "$invalid_credentials" == "1" ]; then
    return 1
  fi
 
  echo -n "Creating Github repository '$repo_name' ..."
  curl -u "$username:$token" https://api.github.com/user/repos -d '{"name":"'$repo_name'"}' > /dev/null 2>&1
  echo " done."
 
  echo -n "Pushing local code to remote ..."
  git remote add origin git@github.com:$username/$repo_name.git > /dev/null 2>&1
  git push -u origin master > /dev/null 2>&1
  echo " done."
}
