Slawek's Dotfiles
=================

I use the dotfiles present in the project in the following setup:
- ArchLinux VirtualBox VM running in Windows 8
- ZSH
- XMonad window manager

The project should be cloned into user's home directory as follows:

    git clone https://github.com/slawekzachcial/dotfiles.git .dotfiles

The project files are organized into topics. All the files or directories having `.symlink` extension
should be symlinked in the home directory, e.g. `~/.zshrc -> ~/.dotfiles/zsh/zshrc.symlink`

