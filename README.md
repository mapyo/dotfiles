dotfiles
----------------

```
cd ~
git clone git@github.com:mapyo/dotfiles.git
sh -x ./dotfiles/setup.sh
cd ./dotfiles
git submodule init
git submodule update

# brew install
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew bundle
```

