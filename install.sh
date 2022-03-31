#!/bin/bash
#
# Script to install my dotfiles

# brew install
brew install neovim
mkdir ~/.config/nvim
brew install tmux
brew cleanup

BACKUPDIR="$HOME/dotfiles-backup/"
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P )

link_file ()
{

  if [ -h "$HOME/$1" ]; then
    if [ "$(pwd -P $HOME/$1)/$1" == $DIR/$1 ]; then
      echo "Your $1 is already linked up, good job!"
    else
      echo "Your $1 is already a symlink to something else, I'll leave you to fix that. Quickest fix is to delete the link and run this script again."
    fi
  else
    if [ -a "$HOME/$1" ]; then

      echo "Your $1 already exists, backing up to $BACKUPDIR and replacing."
      if [ $1 == .bashrc ] || [ $1 == .bash_profile ]; then
        echo "You might want to copy it into .bashrc.d if you want to keep it."
      fi
      mkdir $BACKUPDIR
      mv $HOME/$1 $BACKUPDIR

    fi

    ln -s $DIR/$1 $HOME/$1
    if [ $? -eq 0 ]; then
      echo "$DIR/$1 successfully linked to $HOME/$1."
    else
      echo "$DIR/$1 failed to link to $HOME/$1. Investigate and try again."
      exit 1
    fi

  fi
}

# peco
if [ ! -e "/usr/local/bin/peco" ]; then
  curl -L -O https://github.com/peco/peco/releases/download/v0.5.3/peco_darwin_amd64.zip > peco_darwin_amd64.zip
  unzip peco_darwin_amd64.zip
  rm peco_darwin_amd64.zip
  sudo mv peco_darwin_amd64/peco /usr/local/bin/
  sudo chmod +x /usr/local/bin/peco
fi

# nvim
if [ ! -e "$HOME/.config/nvim" ]; then
  ln -snfv ~/.vimrc ~/.config/nvim/init.vim
fi

# terminal系
if [ ! -d "$HOME/powerlevel9k" ]; then
  git clone https://github.com/bhilburn/powerlevel9k.git $HOME/powerlevel9k
fi

# prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# prezto editorをvimに変更
sed -e "s/nano/vim/g" ~/.zprofile > ~/.zprofile_temp
mv ~/.zprofile_temp ~/.zprofile

# prezto .zshrcに追記
cat <<EOL >> ~/.zshrc
# Source all files in ~/.zshrc.d/
for i in ~/.zshrc.d/* ; do
    if [ -r "$i" ]; then
        source $i
    fi
done
EOL

link_file .vimrc
link_file .tmux.conf

git submodule foreach --recursive git checkout master

