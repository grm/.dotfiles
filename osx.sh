#!/usr/bin/env bash

SELF_NAME=$(basename "$0")
green_echo() {
    echo -e "\x1b[1;32m>>>>>>>>>>>>>> $MESSAGE"
}

mkdir -p tmp

USERNAME=grm
#Install brew
MESSAGE="Installing homebrew" ; green_echo
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

MESSAGE="Installing fish and tmux" ; green_echo
brew install fish tmux

#Configure python (pip, virtualenv)
MESSAGE="Installing python, pip and virtualenv" ; green_echo
brew install python3
curl https://bootstrap.pypa.io/get-pip.py -o tmp/get-pip.py
sudo python tmp/get-pip.py
sudo pip install virtualenv

#Configure fish and set as default shell
MESSAGE="Fish configuration" ; green_echo
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s "/usr/local/bin/fish" ${USERNAME}
mkdir -p ~/.config/fish/functions
cp config/config.fish ~/.config/fish/
#Install fisher
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
#Install bobthefish theme for fish
fish -c "fisher add oh-my-fish/theme-bobthefish"

#Installing fonts
MESSAGE="installing fonts" ; green_echo
brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font

#Installing iterm
MESSAGE="installing iterm" ; green_echo
curl -L https://iterm2.com/downloads/stable/latest -o tmp/iterm2.zip
unzip tmp/iterm2.zip -d tmp/
sudo mv tmp/iTerm.app /Applications
# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.dotfiles/iterm2"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
curl -L https://iterm2.com/shell_integration/install_shell_integration.sh | bash

#Configure tmux
MESSAGE="Configuring tmux" ; green_echo
cd ~
ln -sf .dotfiles/config/.tmux.conf 
cp .dotfiles/config/.tmux.conf.local .

#Cleaning
rm -rf .dotfiles/tmp/
