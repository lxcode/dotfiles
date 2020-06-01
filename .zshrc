### Limits
unlimit
limit stack 8192
limit core unlimited
limit -s

umask 022

### Environment
export MAIL=/home/$USERNAME/Maildir
export HELPDIR=/usr/local/lib/zsh/help  # directory for run-help function to find docs

HISTSIZE=1336
DIRSTACKSIZE=20
HISTFILE=~/.zsh_history
SAVEHIST=1336
KEYTIMEOUT=0
MAILCHECK=0

### Watch
watch=(notme)                   # watch for everybody but me
LOGCHECK=300                    # check every 5 min for login/logout activity
WATCHFMT='%n %a %l from %m at %t.'

### Options
setopt   notify globdots pushdtohome autolist multios
setopt   autocd longlistjobs autoresume histignorealldups histignorespace
setopt   autopushd pushdsilent pushdminus extendedglob rcquotes
setopt   nocorrect nocorrectall inc_append_history share_history
unsetopt bgnice autoparamslash

### Aliases
alias j=jobs
alias dis=disown
alias pd=popd
alias p=popd
alias yt='cd /tmp; youtube-dl `sselp`'
alias h=history
alias grep=egrep
alias ll='ls -l'
alias la='ls -a'
alias be='sudo -s -H -u'
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
alias k="khal"
alias t="task"
alias tl="task long"
alias th="task +home"
alias tw="task +work"
alias wtr="curl 'wttr.in/SFO?m'"
alias ws="python3 -m http.server"
alias lsd='ls -ld *(-/DN)'
alias lsa='ls -ld .*'
alias ctags-objc='/usr/local/bin/ctags --languages=objectivec --langmap=objectivec:.h.m -R .'
alias vim="$EDITOR"
alias sx="exec startx"
alias vis="vise"
alias emo="emoji-fzf preview | fzf --preview 'emoji-fzf get --name {1}' | cut -d \" \" -f 1 | emoji-fzf get"

if [ -x fd ]; then
    _fzf_compgen_dir() {
        fd --type d --hidden --follow --exclude ".git" . "$1"
    }
fi

### Functions
bvimdiff() {
    vimdiff <(xxd $1) <(xxd $2)
}

# fuzzy find recent vim files to edit
v() {
  local files
  files=$(grep '^>' ~/.viminfo | cut -c3- |
          while read line; do
            [ -f "${line/\~/$HOME}" ] && echo "$line"
          done | fzf-tmux -d -m -q "$*" -1) && vim ${files//\~/$HOME}
}

# list the cdr recent directories stack
fzf-cdr() {
    local dir=$(cdr -l | fzf-tmux |cut -c6-) && zle -U "cd ${dir//\~/$HOME}"
}
zle -N fzf-cdr
bindkey '^b' fzf-cdr

mus() {
    sudo zpool import backup
    cmus
    sudo zpool export backup
}

fpr() { openssl s_client -connect $1 < /dev/null 2>/dev/null | openssl x509 -fingerprint -noout -in /dev/stdin }

setenv() { typeset -x "${1}${1:+=}${(@)argv[2,$#]}" }  # csh compatibility

freload() { while (( $# )); do; unfunction $1; autoload -U $1; shift; done }

# Where to look for autoloaded function definitions
fpath=(~/.zfunc $fpath)
for func in $^fpath/*(N-.x:t); autoload $func

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

### Prompts
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
setopt prompt_subst
zstyle ':vcs_info:git*' actionformats "%s  %r/%S %b %m%u%c "

PROMPT='[%B%n%b@%m %3~ %h ] '
RPROMPT='${vcs_info_msg_0_}'

# Change cursor shape in insert mode
function zle-keymap-select zle-line-init
{
    case $KEYMAP in
        vicmd)      print -n -- "\E[2 q";;  # block cursor
        viins|main) print -n -- "\E[4 q";;  # underscore cursor
    esac

    zle reset-prompt
    zle -R
}

function zle-line-finish
{
    print -n -- "\E[2 q"  # block cursor
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

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
    vcs_info
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

# typing ... expands to ../., ... to ../../., etc.
rationalise-dot() {
    if [[ $LBUFFER = *.. ]]; then
        LBUFFER+=/.
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

### Keep recent directory list for use by cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-pushd true

### Bindings
bindkey -v               # vi key bindings
bindkey "\e[Z" reverse-menu-complete
bindkey '^R' history-incremental-search-backward
bindkey . rationalise-dot
bindkey -M isearch . self-insert # history search fix
bindkey -M vicmd v edit-command-line

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

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

#zstyle -e ':completion:*:ports' ports 'reply=($(nmap $1 |grep open |awk -F / {print $1}))'

### Source things
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
