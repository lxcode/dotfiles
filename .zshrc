umask 022

### Environment
export MAIL=/home/$USERNAME/Maildir

HISTSIZE=6665
SAVEHIST=6665
HISTFILE=~/.zsh_history

DIRSTACKSIZE=50
KEYTIMEOUT=1

### Watch
watch=(notme)                   # watch for everybody but me
LOGCHECK=300                    # check every 5 min for login/logout activity
WATCHFMT='%n %a %l from %m at %t.'

### Options
setopt   notify globdots pushdtohome autolist multios
setopt   autopushd pushdsilent pushdminus extendedglob rcquotes
setopt   autocd longlistjobs autoresume nocorrect nocorrectall
setopt   histignoredups histfindnodups histignorespace
setopt   histexpiredupsfirst inc_append_history share_history
unsetopt bgnice autoparamslash

# Where to look for autoloaded function definitions
fpath=(~/.zfunc ~/.zsh/pure $fpath)
for func in $^fpath/*(N-.x:t); autoload $func

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

### Aliases
alias j=jobs
alias dis=disown
alias pd=popd
alias yt='cd /tmp; youtube-dl `pbpaste`'
alias h=history
alias grep=rg
alias rmsvn="find . -type d -name '\.svn' |xargs rm -rf"
alias rmgit="find . -type d -name '\.git' |xargs rm -rf"
alias mic='sudo make install clean'
alias mu='cd /usr/ports && git pull'
alias mc='sudo make config'
alias mcr="sudo make config-recursive"
alias pwad='sudo portmaster -wad'
alias me="sudo make extract"
alias k="khal"
alias t="task"
alias th="task +home"
alias tw="task +work"
alias wtr="curl -s 'https://wttr.in/Lisbon?format=v2&m&F'|sed -e 's/☀️  /☀️ /g' -e 's/☀️ │/☀️│/g' -e 's/☁️  /☁️ /g'"
alias ws="python3 -m http.server"
alias lsd='ls -ld *(-/DN)'
alias vim="$EDITOR"
alias gv="vim -c GV"
alias vis="vise"
alias emo="emoji-fzf preview --prepend | fzf | awk '{ print \$1 }'"
# Gnuplot aliases
alias plot="gnuplot ~/bin/plot.gp && open /tmp/gpoutput.p*"
alias hist="gnuplot ~/bin/hist.gp && open /tmp/gpoutput.p*"
alias line="gnuplot ~/bin/line.gp && open /tmp/gpoutput.p*"
alias bar="gnuplot ~/bin/bar.gp && open /tmp/gpoutput.p*"

if [ -x /usr/local/bin/w3mman ]; then
    alias man=w3mman
fi

# Use fd for fzf
_fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
}

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

# Get the fingerprint of a host's TLS cert
fpr() { openssl s_client -connect $1 < /dev/null 2>/dev/null | openssl x509 -fingerprint -noout -in /dev/stdin }

# Default options for twarc2
twrc() { twarc2 --no-metadata $@ --flatten }

# typing ... expands to ../., ... to ../../., etc.
rationalise-dot() {
    if [[ $LBUFFER = *.. ]]; then
        LBUFFER+=/.
    else
        LBUFFER+=.
    fi
}

zle -N rationalise-dot

### Modules
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile
zmodload zsh/complist

### Completion
autoload -Uz compinit
compinit -u
autoload -U edit-command-line
zle -N edit-command-line

### Keep recent directory list for use by cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-pushd true

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zshcache

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*' menu select=long-list select=0 search
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' group-name ''

# match uppercase from lowercase + partial names
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists
zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

### Bindings
bindkey -v               # vi key bindings
bindkey "\e[Z" reverse-menu-complete
bindkey '^R' history-incremental-search-backward
bindkey . rationalise-dot
bindkey -M isearch . self-insert # history search fix
bindkey -M vicmd v edit-command-line
bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char
bindkey -M menuselect '^j' vi-down-line-or-history

### Source things
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

gcppath="/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
gcpcomp="/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

[ -f $gcppath ] && source $gcppath
[ -f $gcpcomp ] && source $gcpcomp
eval
TWILIO_AC_ZSH_SETUP_PATH=/Users/det/.twilio-cli/autocomplete/zsh_setup && test -f $TWILIO_AC_ZSH_SETUP_PATH && source $TWILIO_AC_ZSH_SETUP_PATH; # twilio autocomplete setup

# Prompt
autoload -U promptinit; promptinit
prompt pure
