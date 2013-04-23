# .bashrc
# Dustin Pate

# return if not running interactively
[ -z "$PS1" ] && return
. /etc/profile > /dev/null

# Source config variables file.
if [ -f ~/.bash_config ]; then
  . ~/.bash_config
fi

function update_git_branch {
    PS1="\[$green\]\u@:\w\[$magenta\]$(setGitPrompt)\[$green\]\\$\[$normal_colours\] "
}

# history
PROMPT_COMMAND='history -a; history -n'
HISTCONTROL=ignoredups:ignorespace
HISTIGNORE='ls:bg:fg:history'
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s histappend
shopt -s cmdhist

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

export GREP_OPTIONS="--color=auto"
export GREP_COLOR="1;32"
export EDITOR="nano"
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:usr/X11/bin"
export COPYFILE_DISABLE=true

#Prompt
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

green=$'\e[1;32m'
magenta=$'\e[1;35m'
normal_colours=$'\e[m'

if [ "$color_prompt" = yes ]; then
    PROMPT_COMMAND="update_git_branch; $PROMPT_COMMAND"
    PS1="\[$green\]\u@:\w\[$magenta\]$(setGitPrompt)\[$green\]\\$\[$normal_colours\] "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

# Try to keep environment pollution down, EPA loves us.
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# ls colors
# (via http://github.com/inky/dotfiles/blob/master/home/.bashrc)
uname=$(uname)
if [ "$TERM" != "dumb" ]; then
    case "$uname" in
    Darwin)
        # MAC ONLY
        export CLICOLOR=1
        export LSCOLORS="ExFxCxDxBxegedabagacad"  # legible colours
        # behave like vi on MAC only
        set -o vi
        # Load Homebrew's bash-completion helpers
        if [ -f $(brew --prefix)/etc/bash_completion ]; then
            . $(brew --prefix)/etc/bash_completion
        fi
        ;;
    *)
        if [ -n "`which dircolors`" ]; then
            test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
            alias ls='ls --color=auto'
            #alias dir='dir --color=auto'
            #alias vdir='vdir --color=auto'

            alias grep='grep --color=auto'
            alias fgrep='fgrep --color=auto'
            alias egrep='egrep --color=auto'
        fi
        ;;
    esac
fi

# Include alias definitions
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# Include environment-specific odds-n-ends
if [ -f ~/.bashrc.local ]; then
  . ~/.bashrc.local
fi
