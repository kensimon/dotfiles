About
-----

Directory containing my homedir's dotfiles.  I use this directory by cloning it
to ~/.dotfiles and using symlinks to actually use the configs.

Setup
-----

* <tt>rake</tt>

Initializes git submodules (if you didn't already git clone with --recursive)
and clones some of the rbenv plugins I'm using.  This is done because using
submodules for rbenv would create a situation where I'd have to commit the
submodules, but I don't really want to fork rbenv just for that.

* <tt>rake update</tt>

Pulls down new verisons of submodules

* <tt>rake symlink</tt>

Creates symlinks from this directory to the real dot files under ~.
ie.

ln -s .dotfiles/vim/vimrc .vimrc
ln -s .dotfiles/zshrc .zshrc

etc.
