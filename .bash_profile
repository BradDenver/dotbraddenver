
# Alias definitions.
if [ -f ~/dotbraddenver/.bash_aliases ]; then
    . ~/dotbraddenver/.bash_aliases
fi

# Git
git config --global alias.co checkout
git config --global alias.ci 'commit -vp'
git config --global alias.st status
git config --global alias.br branch
git config --global user.email "brad.denver@gmail.com"
git config --global user.name "BradDenver"
git config --global core.editor "$(which nvim)"
git config --global push.default current

export EDITOR="$(which nvim)"

# https://spin.atomicobject.com/2016/05/28/log-bash-history/
[[ -d ~/.logs ]] || mkdir ~/.logs
export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi'

[[ -d ~/.npm-global ]] || mkdir ~/.npm-global
export PATH=~/.npm-global/bin:$PATH

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '

# Move next only if `homebrew` is installed
if command -v brew >/dev/null 2>&1; then
	# Load rupa's z if installed
	[ -f $(brew --prefix)/etc/profile.d/z.sh ] && source $(brew --prefix)/etc/profile.d/z.sh
fi

# https://stackoverflow.com/questions/4188324/bash-completion-of-makefile-target
complete -W "\`grep -oE '^[a-zA-Z0-9_-]+:([^=]|$)' Makefile | sed 's/[^a-zA-Z0-9_-]*$//'\`" make

# export FZF_DEFAULT_COMMAND='ag --nocolor --ignore node_modules -g ""'
# https://sidneyliebrand.io/blog/how-fzf-and-ripgrep-improved-my-workflow
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden --ignore-file ~/dotbraddenver/.ignore'

# owen.cymru/fzf-ripgrep-navigate-with-bash-faster-than-ever-before/
if command -v bfs >/dev/null 2>&1; then
  export FZF_ALT_C_COMMAND="cd ~/; bfs -type d -nohidden | sed s/^\./~/"
fi

if ! [ -f ~/.config/nvim/init.vim ]; then
  ln -s ~/dotbraddenver/init.vim ~/.config/nvim/init.vim
fi

eval "$(direnv hook bash)"
