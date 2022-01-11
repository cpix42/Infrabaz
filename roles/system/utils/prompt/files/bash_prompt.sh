#!/usrv/env bash

# require tput
if ! which tput &>/dev/null; then
    echo "$0" ERREUR tput introuvable >&2
    return
fi

term_type=xterm-256color
function setaf_with_type() {
    tput setaf "${1}" -T"${term_type}"
}

# black="$(setaf_with_type 0)"
red="$(setaf_with_type 1)"
#green="$(setaf_with_type 2)"
light_yellow="$(setaf_with_type 223)"
# blue="$(setaf_with_type 4)"
 grey="$(setaf_with_type 252)"

bold="$(tput bold)"
reset="$(tput sgr0)"

if [ "$(id -u)" == "0" ]; then
    PS1="\[$red$bold\]ROOT\[$reset\]@\h\[$reset\] \\$ "
else
    PS1="\[$light_yellow\]\u@\h\[$grey\] \$ \[$reset\]"
fi

PROMPT_COMMAND='
    tput setaf 8
    tput bold
    if (which git && git status) &>/dev/null; then
        basename -s .git $(git config --get remote.origin.url)
        tput setaf 14
        echo -n ·↳
        git rev-parse --abbrev-ref HEAD
        echo -n ·
    fi | tr -d \\n

    tput setaf 242
    echo -n ↓
    pwd
    tput sgr0
'

export PROMPT_COMMAND
export PS1
