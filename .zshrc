# Set up the prompt

fpath=(/usr/local/share/zsh/functions ${fpath})

autoload -Uz promptinit
promptinit

setopt histignorealldups
unsetopt share_history

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

if [ `uname` = "Darwin" ]; then
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
fi

export TERM=xterm-256color

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

alias g='git'
alias ls='ls -la --color=auto'

if [ -e $HOME/.zsh/env.zsh ]; then
    source $HOME/.zsh/env.zsh
fi

export EC2_HOME=$HOME/Develop/ec2-api-tools
export AWS_ELB_HOME=$HOME/Develop/ec2-elastic-load-balancing
export AWS_AUTO_SCALING_HOME=$HOME/Develop/autoscaling
export PATH=$PATH:${EC2_HOME}/bin:${AWS_ELB_HOME}/bin:${AWS_AUTO_SCALING_HOME}/bin
export EC2_PRIVATE_KEY="~/.ec2/pk-amazon.pem"
export EC2_CERT="~/.ec2/cert-amazon.pem"
export EC2_URL="https://ec2.ap-northeast-1.amazonaws.com"

export EDITOR=vim

export PATH="$HOME/.rbenv/bin:$HOME/Documents/scripts/AWS-Utils/bin:$PATH"
eval "$(rbenv init -)"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
