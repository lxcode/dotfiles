for VI in /usr/local/bin/vim /opt/local/bin/vim /Applications/MacVim.app/Contents/MacOS/Vim /usr/bin/vim /usr/local/bin/nvi /usr/bin/vi
do
	if [ -x $VI ]; then
		export EDITOR=$VI
		export VISUAL=$VI
		break
	fi
done

export FPATH=/usr/share/zsh/site-functions:$FPATH
export GREP_COLORS="ms=01;31:mc=:sl=:cx=:fn=:ln=:bn=:se=:ne="
export PATH=/usr/local/libexec/ccache:$PATH
export CCACHE_PATH=/usr/bin:/usr/local/bin
export CCACHE_DIR="/home/lx/.ccache"
export CLICOLOR=yes
#export TERM=xterm-256color

export LC_CTYPE=en_US.UTF-8
export LESSHISTFILE="-"
export X11HOME=/usr/local
export MANPATH=/usr/man:/usr/share/man:/usr/local/man:/usr/local/share/man:/usr/lang/man:/var/qmail/man:/usr/pkg/man:/opt/local/man
export ORACLE_HOME=/compat/linux/usr/lib/oracle/10.2.0.3 
export ANDROID_HOME=/usr/local/opt/android-sdk

path=( /usr/bin /bin /usr/sbin /sbin /usr/local/bin /usr/local/sbin /var/qmail/bin $X11HOME/bin /usr/local/9/bin /crypt/usr/local/texlive/2012/bin/amd64-freebsd /usr/texbin ~/bin ~/android/tools /home/lx/git/isec/tools/misc/graudit /usr/local/libexec/git-core )

case $OSTYPE in
	solaris*)
		path=( $path  /usr/platform/`arch -k`/sbin /usr/ccs/bin )
	;;
	darwin*)
		path=( $path /opt/local/bin /opt/local/sbin )
	;;
esac

