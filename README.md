# dotsfiles

settings bash or zsh, and vim settings
this dotfiles setting base on zsh

## Import Settings

```shell
./install.sh
```

## Install brew

```shell
./brew.sh
```

# Use iTerm2

```shell

cd ~/Library/Fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
# iTerm2 -> Preferences -> Profiles -> Text -> Font -> Change Font

git clone https://github.com/dracula/iterm.git
# iTerm2 -> Preferences -> Profiles -> Colors -> Color Presets -> Import

```

# Install dein Plugins

please install dein plugins after install neovim, if you want

```shell
:call dein#install()
```
