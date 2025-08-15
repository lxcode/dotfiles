# Editor selection
for VI in /usr/local/bin/vim /opt/homebrew/bin/vim /usr/bin/vim /opt/homebrew/bin/vise /usr/local/bin/nvi /usr/bin/vi; do
	if [ -x $VI ]; then
		export EDITOR=$VI
		export VISUAL=$VI
		export SUDO_EDITOR=$VI
		break
	fi
done

# FZF configuration
export FZF_DEFAULT_OPTS="--extended --bind ctrl-a:select-all --height 60%"
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Shell and display settings
export FPATH=/usr/share/zsh/site-functions:/opt/homebrew/share/zsh/site-functions:$FPATH
export GREP_COLORS="ms=01;31:mc=:sl=:cx=:fn=:ln=:bn=:se=:ne="
export CLICOLOR=yes
export LC_CTYPE=en_US.UTF-8
export LESSHISTFILE="-"
export MANPATH=/usr/man:/usr/share/man:/usr/local/man:/usr/local/share/man:/usr/lang/man:/usr/pkg/man

# PATH configuration
path=( 
    /usr/bin /bin /usr/sbin /sbin
    /usr/local/bin /usr/local/sbin
    /opt/homebrew/bin /opt/homebrew/opt/llvm/bin
    $X11HOME/bin
    $HOME/go/bin
    /usr/local/texlive/20*/bin/*
    ~/bin
    /usr/local/libexec/git-core
    ~/.cabal/bin
    ~/.cargo/bin
    ~/.local/bin
    ~/.pub-cache/bin
    ~/dev/flutter/bin
    ~/Library/Android/sdk/platform-tools
    ~/Library/Android/sdk/cmdline-tools/latest/bin
    ~/Library/Android/sdk/emulator
)

# For runit
export SVDIR=/var/service

# Development environments
export GOPATH=$HOME
export ANDROID_HOME=~/Library/Android/sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME
