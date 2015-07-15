### Limits
unlimit
limit stack 8192
limit core unlimited
limit -s

umask 022

### Environment
export MAIL=/home/$USERNAME/Maildir
export HELPDIR=/usr/local/lib/zsh/help  # directory for run-help function to find docs

MAILCHECK=300
HISTSIZE=1336
DIRSTACKSIZE=20
HISTFILE=~/.zsh_history
SAVEHIST=1336

### Watch
watch=(notme)                   # watch for everybody but me
LOGCHECK=300                    # check every 5 min for login/logout activity
WATCHFMT='%n %a %l from %m at %t.'

### Options
setopt   notify globdots pushdtohome cdablevars autolist
setopt   autocd longlistjobs
setopt   autoresume histignoredups pushdsilent
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
setopt   multios
unsetopt bgnice autoparamslash

# argh, cut it out!
setopt nocorrect nocorrectall
setopt NO_CDABLE_VARS

### Aliases
alias skype='skype --resources=/usr/local/share/skype'
alias j=jobs
alias dis=disown
alias pd=popd
alias p=popd
alias x=exit
alias yt='cd /tmp; youtube-dl `sselp`'
alias d='dirs -v'
alias h=history
alias grep=egrep
alias ll='ls -l'
alias la='ls -a'
alias become='sudo -s -H -u'
alias burp='LC_CTYPE=C java -mx512m -jar /Users/lx/Tools/burpsuite_pro*.jar'
alias vpn='sudo openvpn /usr/local/etc/openvpn.conf'
alias wu='sudo sv stat /service/*'
alias rmsvn="find . -type d -name '\.svn' |xargs rm -rf"
alias rmgit="find . -type d -name '\.git' |xargs rm -rf"
alias mic='sudo make install clean'
alias mu='sudo portsnap fetch update'
alias mc='sudo make config'
alias mcr="sudo make config-recursive"
alias pwad='sudo portmaster -wad'
alias pm="sudo portmaster"
alias me="sudo make extract"
alias cc_args="gmake CC='/home/lx/.vim/bin/cc_args.py gcc' CXX='/home/lx/.vim/bin/cc_args.py g++' -B"
alias c64term='urxvt -bg "#3a319c" -fg "#7b71d6" -fn "xft:Adore64:size=10"'
alias srv="sudo service"
alias k="khal calendar --days 90"
alias t="task"
alias tl="task long"
alias th="task list +home"
alias tw="task list +work"
alias ws="python -m SimpleHTTPServer 8080"
alias tws="twistd -no web --path=. --port=8080"
alias tpush="pushd ~/.task && git add * && git commit -m 'Task update' && git push; popd"
alias tpull="pushd ~/.task && git pull; popd"
alias lsd='ls -ld *(-/DN)'
alias lsa='ls -ld .*'
alias ctags-objc='ctags --languages=objectivec --langmap=objectivec:.h.m'

### Functions
bvimdiff() {
    vimdiff <(xxd $1) <(xxd $2)
}

mcd() {
    cd `locate "$*"|slmenu -l 50`
}

mvi() {
    vim `locate "$*"|slmenu -l 50`
}

if [ -n "$DISPLAY" ]; then
    alias vim="$EDITOR --servername VIM"
fi

setenv() { typeset -x "${1}${1:+=}${(@)argv[2,$#]}" }  # csh compatibility

hgdiff() {
    vimdiff -c 'map q :qa!<CR>' <(hg cat "$1") "$1";
}

freload() { while (( $# )); do; unfunction $1; autoload -U $1; shift; done }

pskill()
{
	for pid in `ps $PSFLAGS |grep $1 |grep -v grep |awk '{print $1}'`
	do
		echo "killing $1 ($pid)"
		kill $2 $pid
	done
}

cgrep()
{
	regex=$1
	file=$2
	sed -n -e '/$regex/{=;x;1!p;g;$!N;p;D;}' -e h $file
}

lxdo()
{
	args=$*
	su root -mc $args
}

# Where to look for autoloaded function definitions
fpath=(~/.zfunc $fpath)
for func in $^fpath/*(N-.x:t); autoload $func

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

### Prompts
PROMPT='[%B%n%b@%m %3~ %h ] '

# set up cool things in xterm title bars
function title {

	case $TERM in
	xterm*)

	   print -nR $'\033]0;'$*$'\a'
	;;
	rxvt*)

	   print -nR $'\033]0;'$*$'\a'
	;;

	dvtm*)

	   print -nR $'\033]0;'$*$'\a'
	;;

	screen*)

	    print -nR $'\033k'$1$'\033'\\
	    print -nR $'\033]0;'$2$'\a'
	;;
	esac

}

function precmd {
	case $TERM in
	rxvt*|xterm*|screen*)
	    print -Pn "\e]0;%n@%m: %~\a"
	;;
	esac
}

function preexec {
    emulate -L zsh
    local -a cmd; cmd=(${(z)1})
case $TERM in
xterm*)
    title `print -Pn %n@%m:` $cmd[1]:t "$cmd[2,-1]"
;;

rxvt*)
    title `print -Pn %n@%m:` $cmd[1]:t "$cmd[2,-1]"
;;

dvtm*)
    title `print -Pn %n@%m:` $cmd[1]:t "$cmd[2,-1]"
;;

screen*)
    title $cmd[1]:t "$cmd[2,-1]"
;;
esac
}

# typing ... expands to ../.., .... to ../../.., etc.
rationalise-dot() {
    if [[ $LBUFFER = *.. ]]; then
        LBUFFER+=/..
    else
        LBUFFER+=.
    fi
}
zle -N rationalise-dot
zle -N edit-command-line

### Modules
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile

### Bindings
bindkey -v               # vi key bindings
bindkey "\e[Z" reverse-menu-complete
bindkey '^R' history-incremental-search-backward
bindkey . rationalise-dot
bindkey -M isearch . self-insert # history search fix
bindkey -M vicmd v edit-command-line
bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

### Completion
autoload -Uz compinit
compinit -u
autoload -U edit-command-line

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zshcache

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=long-list select=0
zstyle ':completion:*' list-colors ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists
zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'

# ssh hosts matching style
zstyle -e ':completion:*:hosts' hosts 'reply=($(cat $HOME/.ssh/known_hosts $HOME/.ssh/known_hosts2 /{usr/local/,}etc/ssh/ssh_known_hosts 2>/dev/null | sed -e "/^#/d" -e "s/ .*\$//" -e "s/,/ /g"))'

# URL completion style...
zstyle -e ':completion:*:urls' urls 'reply=($(cat $HOME/.w3m/history 2>/dev/null | sed -e "/^#/d" -e "s:http\://::g" ))'

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

#zstyle -e ':completion:*:ports' ports 'reply=($(nmap $1 |grep open |awk -F / {print $1}))'

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

### Source things
source ~/.zsh/zsh-history-substring-search.zsh
