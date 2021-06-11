for VI in /usr/local/bin/vim /usr/bin/vim /usr/local/bin/nvi /usr/bin/vi
do
	if [ -x $VI ]; then
		export EDITOR=$VI
		export VISUAL=$VI
		break
	fi
done

export FZF_DEFAULT_OPTS="--extended --bind ctrl-a:select-all --height 60%"
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export GOPATH=$HOME/go
export FPATH=/usr/share/zsh/site-functions:$FPATH
export GREP_COLORS="ms=01;31:mc=:sl=:cx=:fn=:ln=:bn=:se=:ne="
export CLICOLOR=yes

export LC_CTYPE=en_US.UTF-8
export LESSHISTFILE="-"
export X11HOME=/usr/local
export MANPATH=/usr/man:/usr/share/man:/usr/local/man:/usr/local/share/man:/usr/lang/man:/usr/pkg/man

path=( /usr/bin /bin /usr/sbin /sbin /usr/local/bin /usr/local/sbin $X11HOME/bin $HOME/go/bin /usr/local/texlive/2021/bin/amd64-freebsd /usr/local/texlive/2021/bin/x86_64-darwin ~/bin /usr/local/libexec/git-core ~/.cabal/bin ~/.cargo/bin ~/.local/bin)

export ANDROID_HOME=~/Library/Android/sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=${PATH}:~/dev/flutter/bin:~/.pub-cache/bin
