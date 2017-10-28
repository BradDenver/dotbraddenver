
# Alias definitions.
if [ -f ~/dotbraddenver/.bash_aliases ]; then
    . ~/dotbraddenver/.bash_aliases
fi

# Git
git config --global alias.co checkout
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.br branch
git config --global user.email "brad.denver@gmail.com"
git config --global user.name "BradDenver”
git config --global core.editor "$(which nvim)”
git config --global push.default current

# export EDITOR='vim -N -u ~/dotbraddenver/.vimrc'

# https://spin.atomicobject.com/2016/05/28/log-bash-history/
[[ -d ~/.logs ]] || mkdir ~/.logs
export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi'

[[ -d ~/.npm-global ]] || mkdir ~/.npm-global
export PATH=~/.npm-global/bin:$PATH
