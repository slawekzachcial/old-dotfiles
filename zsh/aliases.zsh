
if [[ "$(uname)" == "Darwin" ]]; then
    alias ls='ls -G'
    alias la='ls -G -la'
    alias ll='ls -G -l'
elif [[ "$(uname)" == "Linux" ]]; then
    alias ls='ls --color=auto'
    alias la='ls --color=auto -la'
    alias ll='ls --color=auto -l'
fi

alias ld='ls -d *(/)'
alias h='history'
alias r='fc -e -'
alias cdiff=colordiff
alias cgrep='grep --color=auto'
alias egrep='grep -E'
alias psgrep='ps -ef | grep --color'

alias vi=vim
alias view='vim -R'

alias xarg1='xargs -n1 -i'

if [[ "$(uname)" == "Linux" ]]; then
    alias startx='startx &> ~/.xlog'

    # Pacman alias examples
    alias pacupg='sudo pacman -Syu'        # Synchronize with repositories and then upgrade packages that are out of date on the local system.
    alias pacin='sudo pacman -S'           # Install specific package(s) from the repositories
    alias pacins='sudo pacman -U'          # Install specific package not from the repositories but from a file
    alias pacre='sudo pacman -R'           # Remove the specified package(s), retaining its configuration(s) and required dependencies
    alias pacrem='sudo pacman -Rns'        # Remove the specified package(s), its configuration(s) and unneeded dependencies
    alias pacrep='pacman -Si'              # Display information about a given package in the repositories
    alias pacreps='pacman -Ss'             # Search for package(s) in the repositories
    alias pacloc='pacman -Qi'              # Display information about a given package in the local database
    alias paclocs='pacman -Qs'             # Search for package(s) in the local database

    # Additional pacman alias examples
    alias pacupd='sudo pacman -Sy && sudo abs'     # Update and refresh the local package and ABS databases against repositories
    alias pacinsd='sudo pacman -S --asdeps'        # Install given package(s) as dependencies of another package
    alias pacmir='sudo pacman -Syy'                # Force refresh of all package lists after updating /etc/pacman.d/mirrorlist

    alias cdrom='sudo mount /dev/cdrom /media/cdrom'
    alias eject='sudo eject'

    # -bg color taken for base16-default base00 from  https://github.com/chriskempson/base16-xresources/blob/master/base16-default.light.xresources
    alias urxvt-light='env BACKGROUND=light urxvt -bg "#f8f8f8"'
fi
