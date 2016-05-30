#!/bin/bash

# Inspired by https://github.com/nicknisi/dotfiles.git

DOTFILES=$HOME/.dotfiles

echo "Installing dotfiles"

echo "Initializing submodule(s)"
git submodule update --init --recursive

echo "Creating symlinks"
for file in $(ls -1 -d **/*.symlink); do
    if [[ "$(name)" == "Darwin" &&  ( "$file" =~ "X/" || "$file" =~ "xmonad" || "$file" =~ "zprofile" ) ]]; then
        # do nothing - we don't want to link those on OS X
        echo "Skiping $file"
    else
        target="$HOME/.$(basename $file ".symlink")"
        echo "$target -> $file"
        ln -s $DOTFILES/$file $target
    fi
done

if [[ "$(uname)" == "Darwin" ]]; then
    echo "Running on OS X"

    echo "Installing Homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    echo "Brewing"
    brew install brew-cask
    brew install colordiff
    brew install docker
    brew install docker-machine
    brew install git
    brew install go
    brew install maven
    brew install openssl
    brew install reattach-to-user-namespace
    brew install source-highlight
    brew install tmux
    brew install tree
    brew install zsh
    brew install zsh-completions
    brew install zsh-history-substring-search
    brew install zsh-syntax-highlighting

    brew cask install flash
    brew cask install font-inconsolata-for-powerline
    brew cask install intellij-idea-ce
    brew cask install java
    brew cask install utorrent
    brew cask install vagrant
    brew cask install virtualbox
fi

echo "Configuring zsh as default shell"
chsh -s $(which zsh)

echo "All done!"
