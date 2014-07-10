#!/bin/sh
# Run this script as a regular user.

# I am a grownup, I can handle this knowledge
defaults write com.apple.Finder AppleShowAllFiles TRUE
defaults write com.apple.Finder ShowPathbar -bool true
defaults write com.apple.Finder _FXShowPosixPathInTitle -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Don't ask stupid questions
defaults write com.apple.Finder WarnOnEmptyTrash -bool false
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Stop doing the stupid desktop reordering thing
defaults write com.apple.dock mru-spaces -bool false

# ANIMATE FASTER
defaults write com.apple.dock expose-animation-duration -float 0.15

# Use autohide but make it quick
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-time-modifier -float 0.17
# On second thought, let's make it fast to animate but hard to trigger
defaults write com.apple.dock autohide-delay -int 2

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

# Allow keyboard navigation for modals
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# ANIMATE MORE FASTER
defaults write NSGlobalDomain NSWindowResizeTime .1

# By default, you can't type things like "GAAAAAAAAAAAH". Unacceptable.
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Fastest key repeat. Still too slow.
defaults write NSGlobalDomain KeyRepeat -int 0

# Lower right corner click is right click
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# I prefer to scroll in the perverted, unnatural direction
# Actually nevermind, I'll try to adapt. Sigh.
#defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false


# This is not an iPad.
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Do not ask me if I'm sure. I am always sure.
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Do not leave crap all over my network shares
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Time machine is great, but I don't need this prompt
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable drop shadow on screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Disable stupid semitransparent menubar
# This is probably counterproductive with dark mode
# defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

# I do not need my documents to be cloud
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Check for updates daily.
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Disable candy colors
defaults write -g AppleAquaColorVariant -int 6;

# Turn on firewall, such as it is
defaults write /Library/Preferences/com.apple.sharing.firewall state -bool YES

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

# Disable Time Machine icon
for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
    defaults write "${domain}" dontAutoLoad -array \
        "/System/Library/CoreServices/Menu Extras/TimeMachine.menu"
done

# It's my library. Let me see it.
chflags nohidden ~/Library/
sudo chflags nohidden /tmp
sudo chflags nohidden /usr

# Link to the airport command
sudo ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/sbin/airport

# The old Solaris admin in me still cringes when I see this command
killall Dock
killall Finder

# Stop DHCP from twiddling names
#scutil --set HostName local.foo.bar

# Disable "safe sleep", saving 8-16G of disk space. Doing so is basically no
# less secure than the default behavior when it comes to cold boot attacks, as
# Safe Sleep leaves the RAM powered for 24 hours anyway. You'd have to hibernate
# every time you close the machine to prevent that. If you want to do that, use
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
# sudo touch /private/var/vm/sleepimage
# sudo chflags uchg /private/var/vm/sleepimage

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
brew install task macvim tmux w3m apg bvi cscope daemontools djbdns runit mutt nvi nmap par weechat wireshark youtube-dl bbe
brew install ctags --HEAD
brew linkapps
