#!/usrv/env bash

### set a colored prompt for server, not to confuse on dev station

### also set a clearer root prompt

# require tput
if ! which tput &>/dev/null; then
    echo ERREUR tput introuvable >&2
    return
fi

# black="$(tput setaf 0)"
red="$(tput setaf 1)"
#green="$(tput setaf 40)"
yellow="$(tput setaf 3)"
# blue="$(tput setaf 4)"
 grey="$(tput setaf 8)"
# light_blue="$(tput setaf 14)"

bold="$(tput bold)"
reset="$(tput sgr0)"

if [ "$(id -u)" == "0" ]; then 
    PS1="\[$red$bold\]ROOT\[$reset\]@\h\[$reset\] \$ "
else
    PS1="\[$yellow\]\u@\h\[$grey\] \$ \[$reset\]"
fi

PROMPT_COMMAND="
    tput setaf 14
    if (which git && git status) &>/dev/null; then
        basename -s .git $(git config --get remote.origin.url)
        echo -n ' ↳ '
        git rev-parse --abbrev-ref HEAD
        echo ' '
    fi | tr -d '\n'

    tput setaf 8
    pwd
    tput sgr0
"

export PROMPT_COMMAND
export PS1