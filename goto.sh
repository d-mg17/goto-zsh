#!/bin/bash

[ ! -f ~/.goto_mappings ] && touch ~/.goto_mappings

goto() {
    if [ "$1" = "add" ]; then
        echo "$2 $3" >> ~/.goto_mappings
        return
    elif [ "$1" = "remove" ]; then
        sed -i "/^$2 /d" ~/.goto_mappings
        return
    elif [ "$1" = "update" ]; then
        sed -i "/^$2 /d" ~/.goto_mappings
        echo "$2 $3" >> ~/.goto_mappings
        return
    elif [ "$1" = "list" ]; then
        awk '{print "• " $1 ": " $2}' ~/.goto_mappings
        return
    fi

    target=$(grep "^$1 " ~/.goto_mappings | awk '{print $2}')
    if [ -n "$target" ]; then
        cd "$target"
    else
        echo "No mapping found for $1"
    fi
}

_goto_names() {
    awk '{print $1}' ~/.goto_mappings
}

if [ -n "$ZSH_VERSION" ]; then
    _goto_completion() {
        local -a subs names
        subs=(add remove update list)
        names=(${(f)"$(_goto_names)"})
        if (( CURRENT == 2 )); then
            compadd -- "${subs[@]}" "${names[@]}"
        fi
    }
    whence compdef >/dev/null || { autoload -Uz compinit; compinit -i; }
    compdef _goto_completion goto
elif [ -n "$BASH_VERSION" ]; then
    _goto_completion() {
        local cur names
        COMPREPLY=()
        cur="${COMP_WORDS[COMP_CWORD]}"
        names=$(_goto_names)
        COMPREPLY=( $(compgen -W "add remove update list ${names}" -- ${cur}) )
        return 0
    }
    complete -F _goto_completion goto
fi
