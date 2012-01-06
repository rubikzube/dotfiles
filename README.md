# Installation 

*Instructions and Rake file borrowed from https://github.com/craveytrain/dotfiles/*

1. Install Pathogen
```sh
mkdir -p ~/.vim/autoload ~/.vim/bundle; \
curl -so ~/.vim/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim
```

2. Clone the repo (be sure to grab submodules)
```sh
git clone --recursive git@github.com:craveytrain/dotfiles.git
```

3. Get inside the repo
```sh
cd dotfiles
```

4. Run the Rakefile
```sh
rake install
```

# Sources

## Vim
* [Steve Losh] (http://stevelosh.com/blog/2010/09/coming-home-to-vim/)
* [Vimcasts] (http://vimcasts.org/)
* [Derek Wyatt] (http://ontwik.com/tools/vim-from-novice-to-professional-by-derek-wyatt-p1/)
* [Ack] (http://betterthangrep.com/)