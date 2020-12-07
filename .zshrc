
[ \( "`tty`" = "/dev/tty1" \) -a \( ! -e "$HOME/.env/.var/nostartx" \) ] && exec startx

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH="$HOME/.oh-my-zsh"

setopt PUSHD_SILENT

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="lambda"
ZSH_THEME="typewritten"

TYPEWRITTEN_SYMBOL='λ'
TYPEWRITTEN_RELATIVE_PATH='adaptive'
TYPEWRITTEN_CURSOR='terminal'

TYPEWRITTEN_COLOR_MAPPINGS='secondary:default;info_negative:white'
[ -e "$HOME/.env/.var/prompt" ] && export TYPEWRITTEN_RIGHT_PROMPT_PREFIX="[`cat $HOME/.env/.var/prompt`] "

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

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
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# [ -e "$HOME/.env/.var/prompt" ] && export PS1="(`cat $HOME/.env/.var/prompt`) $PS1"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias c='clear'

# supplement ls to exa
if [ \( -e /bin/exa \) -o \( -e /usr/bin/exa \) ]; then
    alias ls='exa' # a modern replacement for ls
    alias l='ls -la'
    alias ll='ls -l'
    alias la='ls -a'
fi
alias vim='nvim'
eu() {
    pushd
    cd $HOME/.env
    git fetch -q
    if ! git diff --quiet ..origin/master; then
        echo "[env] Would you like to update? [Y/n]: \c"
        read c
        if [[ "$c" == Y* ]] || [[ "$c" == y* ]] || [ -z "$c" ]; then
            git reset --hard origin/master && ./install update
        fi
    fi
    popd
}
alias wir='nmcli d wifi list --rescan yes'
wic() {
    ($(r="`nmcli d wifi c $1 2>&1`" || notify-send -u critical "$0: $r") &)
}
wirc() {
    notify-send "Rescanning and connecting to $1"
    ($(wir &>/dev/null ; wic $1) &)
}

# rebase flow helpers and git shortcuts
unalias gc gb gp
alias gs='git status'
alias gl='git --no-pager log --oneline -n20'
alias gu='git add -u'
alias ga='git add -i'
# commit
gc() {
    if [ -z $1 ]; then
        ga
        fp=`mktemp`
        $EDITOR $fp
        msg="`cat $fp`"
        rm $fp
    else
        msg="$@"
    fi
    git commit -m "$msg"
}
# switch to a new branch
gb() {
    [ -z $1 ] && echo "Specify a branch!" && return 1
    git checkout master
    git pull
    git checkout -b $1
}
# create a fixup commit and squash
alias gf='fixup'
fixup() {
    if [ -z $1 ]; then
        tofix=`gl | head -n1 | awk '{print $1}'`
    else
        tofix=$1
    fi
    un=$(sed -n -e "/$tofix/,\$p" <(gl) | sed -n 2p | awk '{print $1}')
    git commit --fixup $tofix
    GIT_SEQUENCE_EDITOR=: git rebase -i --autosquash $un
}
# push to master or rebase current branch to master
gp() {
    br=`git rev-parse --abbrev-ref HEAD`
    [ -z $br ] && echo "Not a git repository" && return 1
    if [ $br = "master" ]; then
        git push $@ || git push -u origin master $@
    else
        printf "Do you want to push current branch to master(y/N)? "
        read c
        [ -z $c ] && return 1
        [ \( $c != "y" \) -a \( $c != "Y" \) ] && return 1
        git fetch origin
        git rebase origin/master
        git checkout master
        git pull
        git rebase $br
        git push && git branch -d $br
    fi
}
