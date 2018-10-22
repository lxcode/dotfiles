for VI in /usr/local/bin/vim /usr/local/bin/nvim /opt/local/bin/vim /Applications/MacVim.app/Contents/MacOS/Vim /usr/bin/vim /usr/local/bin/nvi /usr/bin/vi
do
	if [ -x $VI ]; then
		export EDITOR=$VI
		export VISUAL=$VI
		break
	fi
done
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1

export FZF_DEFAULT_OPTS="--extended --bind ctrl-a:select-all --height 60%"
if [ -x rg ]; then
    export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

export GOPATH=$HOME/go
export FPATH=/usr/share/zsh/site-functions:$FPATH
export GREP_COLORS="ms=01;31:mc=:sl=:cx=:fn=:ln=:bn=:se=:ne="
export CLICOLOR=yes
export DVTM_TERM=rxvt

export LC_CTYPE=en_US.UTF-8
export LESSHISTFILE="-"
export X11HOME=/usr/local
export MANPATH=/usr/man:/usr/share/man:/usr/local/man:/usr/local/share/man:/usr/lang/man:/usr/pkg/man

path=( /usr/bin /bin /usr/sbin /sbin /usr/local/bin /usr/local/sbin $X11HOME/bin $HOME/go/bin /usr/local/texlive/2017/bin/amd64-freebsd /usr/local/texlive/2017/bin/x86_64-darwin ~/bin /opt/facebook/bin /usr/local/libexec/git-core ~/.cabal/bin )

export PATH=${PATH}:~/dev/flutter/bin:~/.pub-cache/bin
