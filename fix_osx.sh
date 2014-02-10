#!/bin/sh

# I am a grownup, I can handle this knowledge
defaults write com.apple.Finder AppleShowAllFiles TRUE
defaults write com.apple.Finder ShowPathbar -bool true
defaults write com.apple.Finder _FXShowPosixPathInTitle -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Don't ask stupid questions
defaults write com.apple.Finder WarnOnEmptyTrash -bool false
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# ANIMATE FASTER
defaults write com.apple.dock expose-animation-duration -float 0.15

# Use autohide but make it quick
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-time-modifier -float 0.17

# Kill dashboard
defaults write com.apple.dock "dashboard-in-overlay" -bool true

# Mission Control
defaults write com.apple.dock wvous-br-corner -int 2
defaults write com.apple.dock wvous-br-modifier -int 0

# Start screen saver
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

# Allow keyboard navigation for modals
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# ANIMATE MORE FASTER
defaults write NSGlobalDomain NSWindowResizeTime .1

# I hope whoever came up with this stupid fucking idea dies in a tar pit
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Fastest key repeat. Still too slow.
defaults write NSGlobalDomain KeyRepeat -int 0

# Lower right corner click is right click
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# I prefer to scroll in the perverted, unnatural direction
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# This is not an iPad.
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Do not ask me if I'm sure. I am always sure.
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Do not shit all over my network shares
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Vermeidung von zeit-paradoxon
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable drop shadow on screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Disable stupid semitransparent menubar
defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

# I do not need my documents to be cloud
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Check for updates daily.
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# It's my library. Let me see it.
chflags nohidden ~/Library/
sudo chflags nohidden /tmp
sudo chflags nohidden /usr

# Link to the airport command
sudo ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/sbin/airport

# Stop DHCP from twiddling names
#scutil --set HostName local.foo.bar

# Disable "safe sleep", saving 8-16G of disk space. Doing so is basically no
# less secure than the default behavior when it comes to cold boot attacks, as
# Safe Sleep leaves the RAM powered for hours anyway. You'd have to hibernate
# every time you leave the machine to prevent that. If you want to do that, use
# this:
#
# sudo pmset -a destroyfvkeyonstandby 1 hibernatemode 25
#
# You can also use autopoweroff and reduce the autopoweroffdelay if you want 
# to sleep -> hibernate after a period of time.
# 
# pmset -a hibernatemode 0
# pmset -a autopoweroff 0
# rm /private/var/vm/sleepimage

# Make symlinks

read -p "Preparing to make symlinks"

for file in .zshrc .zshenv .vimrc .vim .ctags .editrc .inputrc .nexrc .tmux.conf
do
    ln -s ~/git/dotfiles/$file ~/$file
done

# Install things
read -p "Preparing to install apps"

cd ~/git && \
    git clone git://repo.or.cz/dvtm.git && \
    cd dvtm && \
    cp ~/git/dotfiles/dvtm-config.h ./config.h && \
    sed -i bak 's/ncursesw/ncurses/g' config.mk
    sed -i bak 's/strip -s/strip/g' Makefile
    sudo make install clean

# Brews

ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
brew doctor
brew install macvim tmux w3m apg bvi cscope ctags daemontools djbdns runit mutt nvi nmap par weechat wireshark youtube-dl
brew linkapps
