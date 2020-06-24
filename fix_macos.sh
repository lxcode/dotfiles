#!/bin/sh
# Run this script as a regular user.

# Re-enable chime on older macs
sudo /usr/sbin/nvram 'BootAudio=%01'

# And newer ones?
sudo nvram 'StartupMute=%00'

# Don't show me a splash screen
sudo nvram boot-args="-v"

# Don't hide things
defaults write com.apple.Finder AppleShowAllFiles TRUE
defaults write com.apple.Finder ShowPathbar -bool true
defaults write com.apple.Finder _FXShowPosixPathInTitle -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Don't ask stupid questions
defaults write com.apple.Finder WarnOnEmptyTrash -bool false
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Don't do the stupid workspace reordering thing
defaults write com.apple.dock mru-spaces -bool false

# Disable the desktop
defaults write com.apple.finder CreateDesktop -bool false

# Make things less transparent and get rid of nauseating desktop switching animation
sudo defaults write com.apple.universalaccess reduceTransparency -bool true
sudo defaults write com.apple.universalaccess reduceMotion -bool true

# Use autohide but make it quick
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-time-modifier -float 0.17
# On second thought, let's make it fast to animate but hard to trigger
defaults write com.apple.dock autohide-delay -int 1

# Kill dashboard
defaults write com.apple.dock "dashboard-in-overlay" -bool true

# Mission Control
defaults write com.apple.dock wvous-br-corner -int 2
defaults write com.apple.dock wvous-br-modifier -int 0

# Start screen saver
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

# Disable screen saver
defaults write com.apple.dock wvous-tl-corner -int 6
defaults write com.apple.dock wvous-tl-modifier -int 0

# Make the dock all NeXTy
defaults write com.apple.dock orientation left
defaults write com.apple.dock pinning -string start

# Remove all dock icons
defaults write com.apple.dock persistent-apps -array

# Allow keyboard navigation for modals
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# ANIMATE MORE FASTER
defaults write NSGlobalDomain NSWindowResizeTime .1

# By default, you can't type things like "GAAAAAAAAAAAH".
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Fastest key repeat. Still too slow.
defaults write NSGlobalDomain KeyRepeat -int 1

# Lower right corner click is right click
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# This is not an iPad.
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Do not ask me if I'm sure
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Do not leave crap all over my network shares
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Time machine is great, but I don't need this prompt
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable drop shadow on screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# I do not need my documents to be cloud
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Check for updates daily.
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Disable candy colors
defaults write -g AppleAquaColorVariant -int 6;

# 24 hour clock, show date
defaults write com.apple.menuextra.clock DateFormat -string "EEE d MMM HH:mm"
defaults write NSGlobalDomain AppleICUForce24HourTime -bool "YES"

# Use proper temperature units
defaults write NSGlobalDomain AppleTemperatureUnit -string "Celsius"

# Turn on firewall, such as it is
sudo defaults write /Library/Preferences/com.apple.sharing.firewall state -bool YES

# Ask for password after lock
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 5

# Enable subpixel font rendering on non-Apple LCDs
defaults write NSGlobalDomain AppleFontSmoothing -int 2

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Enable HiDPI display modes
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

# Expand print and save panels by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Give basic info on login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Don't pop up the photos app when stuff gets plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# Disable sketchy spotlight options
defaults write com.apple.spotlight orderedItems -array \
    '{"enabled" = 1;"name" = "APPLICATIONS";}' \
    '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
    '{"enabled" = 1;"name" = "DIRECTORIES";}' \
    '{"enabled" = 1;"name" = "PDF";}' \
    '{"enabled" = 1;"name" = "FONTS";}' \
    '{"enabled" = 1;"name" = "DOCUMENTS";}' \
    '{"enabled" = 0;"name" = "MESSAGES";}' \
    '{"enabled" = 1;"name" = "CONTACT";}' \
    '{"enabled" = 0;"name" = "EVENT_TODO";}' \
    '{"enabled" = 0;"name" = "IMAGES";}' \
    '{"enabled" = 1;"name" = "BOOKMARKS";}' \
    '{"enabled" = 1;"name" = "MUSIC";}' \
    '{"enabled" = 1;"name" = "MOVIES";}' \
    '{"enabled" = 1;"name" = "PRESENTATIONS";}' \
    '{"enabled" = 1;"name" = "SPREADSHEETS";}' \
    '{"enabled" = 0;"name" = "SOURCE";}' \
    '{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
    '{"enabled" = 0;"name" = "MENU_OTHER";}' \
    '{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
    '{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
    '{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
    '{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'

# Disable Time Machine icon
for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
    defaults write "${domain}" dontAutoLoad -array \
        "/System/Library/CoreServices/Menu Extras/TimeMachine.menu"
done

# It's my library. Let me see it.
chflags nohidden ~/Library/
sudo chflags nohidden /tmp

# Kill parentalcontrolsd
sudo rm -rf "/Library/Application Support/Apple/ParentalControls"

# Link to the airport command
sudo mkdir -p /usr/local/bin
sudo ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/local/bin/airport

# The old Solaris admin in me still cringes when I see this command
killall Dock
killall Finder
killall SystemUIServer

# Index things for locate(1)
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

# Stop DHCP from twiddling names
#scutil --set HostName local.foo.bar

# Make symlinks

read -p "Preparing to make symlinks"

for file in .zshrc .zshenv .zsh .vimrc .vim .ctags .editrc .inputrc .nexrc .tmux.conf bin .config .mailcap
do
    ln -s ~/git/dotfiles/$file ~/$file
done

chsh

mkdir ~/.w3m
ln -s ~/git/dotfiles/w3m-config ~/.w3m/config

# Install things
read -p "Preparing to install apps"

# Brews

sudo xcodebuild -license accept
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor
brew install task tmux w3m bvi cscope runit mutt nvi nmap par \
    python3 weechat youtube-dl bbe zsh vdirsyncer khal \
    fzf mosh tree ripgrep fd htop mtr cmus notmuch isync \
    bitlbee khard go pass rclone vim magic-wormhole ctags \
    automake libtool pkg-config json-glib gnupg pinentry-mac \
    gawk cmusfm
pip3 install peewee python-language-server requests pip-review

# Services
brew services vdirsyncer start
brew services isync start
brew services bitlbee start

# Install casks
read -p "Preparing to install casks"
brew install homebrew/cask-cask
brew tap buo/cask-upgrade
brew tap homebrew/cask-fonts
brew cask install font-inconsolata
brew cask install font-source-code-pro
brew cask install kitty
brew cask install rectangle
brew cask install karabiner-elements
brew cask install wireshark

task
/usr/local/opt/fzf/install
xcode-select --install

read -p "Preparing to install language servers"
pip3 install 'python-language-server[all]'
brew install cquery
brew install luarocks
luarocks install --server=https://luarocks.org/dev lua-lsp
brew tap dart-lang/dart
brew install dart
pub global activate dart_language_server
brew install node yarn
yarn global add javascript-typescript-langserver
GO111MODULE=on go get golang.org/x/tools/gopls@latest
