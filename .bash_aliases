# .bash_aliases
# Dustin Pate

if [ ! -z $ALIAS_SH_PRIVATE_KEY ]; then
    source <(curl -s https://alias.sh/user/$ALIAS_SH_USER_ID/alias/key/$ALIAS_SH_PRIVATE_KEY)
else
    if [ ! -z $ALIAS_SH_USER_ID ]; then
        source <(curl -s https://alias.sh/user/$ALIAS_SH_USER_ID/alias)
    fi
fi

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# ls
alias ls="ls -G"
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ltr="ls -hltr"
alias tree="tree --charset=NULL"

# git
alias gst="git status"
alias gfo="git fetch origin"
alias gsu="git submodule update --init --recursive"
alias gc="git commit"

# etc
#alias src="cd ~/src"
#alias m="mvim --remote-tab-silent"
alias cdns="sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder"
alias diff="diff --suppress-common-lines"
alias reload="source ~/.bashrc"
alias t="tree"
alias utime="date +%s"

# `.. 3` will `cd ../../..`
..() {
    local arg=${1:-1}; while [ $arg -gt 0 ]; do
        local dir="$dir../"; arg=$(($arg - 1))
    done
    cd $dir >& /dev/null;
}


# generate a random password
gpw() {
    local length=$1
    [ -z "$length" ] && length=20
    case `uname` in
        Darwin)
            LC_CTYPE=C tr -dc "A-Za-z0-9&^%$#@" < /dev/urandom | head -c ${length} | xargs
            ;;

        *)
            tr -dc "A-Za-z0-9&^%$#@" < /dev/urandom | head -c ${length} | xargs
            ;;
    esac
}

# create directories and cd to the first one
mkcd() { [ -n "$1" ] && mkdir -p "$@" && cd "$1"; }

# simpler find
f() { find . -iname "*$1*"; }

