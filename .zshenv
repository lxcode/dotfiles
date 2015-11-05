for VI in /usr/local/bin/vim /usr/local/bin/nvim /opt/local/bin/vim /Applications/MacVim.app/Contents/MacOS/Vim /usr/bin/vim /usr/local/bin/nvi /usr/bin/vi
do
	if [ -x $VI ]; then
		export EDITOR=$VI
		export VISUAL=$VI
		break
	fi
done
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1
export FZF_DEFAULT_OPTS="--extended"
export FZF_DEFAULT_COMMAND='ag -l -g ""'

export FPATH=/usr/share/zsh/site-functions:$FPATH
export GREP_COLORS="ms=01;31:mc=:sl=:cx=:fn=:ln=:bn=:se=:ne="
export PATH=/usr/local/libexec/ccache:$PATH
export CCACHE_PATH=/usr/bin:/usr/local/bin
export CCACHE_DIR="/home/lx/.ccache"
export CLICOLOR=yes
export DVTM_TERM=rxvt
export ANDROID_HOME=/usr/local/opt/android-sdk

export LC_CTYPE=en_US.UTF-8
export LESSHISTFILE="-"
export X11HOME=/usr/local
export MANPATH=/usr/man:/usr/share/man:/usr/local/man:/usr/local/share/man:/usr/lang/man:/var/qmail/man:/usr/pkg/man:/opt/local/man

path=( /usr/bin /bin /usr/sbin /sbin /usr/local/bin /usr/local/sbin /var/qmail/bin $X11HOME/bin /usr/local/9/bin /crypt/usr/local/texlive/2015/bin/amd64-freebsd /usr/texbin ~/bin /opt/facebook/bin /home/lx/tools/graudit /usr/local/libexec/git-core /opt/android_sdk/platform-tools)

case $OSTYPE in
	solaris*)
		path=( $path  /usr/platform/`arch -k`/sbin /usr/ccs/bin )
	;;
	darwin*)
		path=( $path /opt/local/bin /opt/local/sbin )
	;;
esac

