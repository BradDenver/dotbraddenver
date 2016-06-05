
# Alias definitions.
if [ -f ~/dotbraddenver/.bash_aliases ]; then
    . ~/dotbraddenver/.bash_aliases
fi

export EDITOR='vim -N -u ~/dotbraddenver/.vimrc'

# https://spin.atomicobject.com/2016/05/28/log-bash-history/
[[ -d ~/.logs ]] || mkdir ~/.logs
export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi'

source ~/dotbraddenver/tmuxinator.bash
