JAVA_HOME=/Library/Java/Home
JAVA_OPTS="-Xmx512M -XX:PermSize=256m -XX:MaxPermSize=512m -Djava.awt.headless=true"
JREBEL_HOME=/Applications/ZeroTurnaround/JRebel
MAVEN_HOME=/opt/tools/maven2
MAVEN_OPTS="$JAVA_OPTS -noverify -javaagent:$JREBEL_HOME/jrebel.jar"
PATH=$JAVA_HOME/bin:$MAVEN_HOME/bin:/usr/local/bin:/Applications/Flash\ Player.app/Contents/MacOS:$PATH
export JAVA_HOME JAVA_OPTS JREBEL_HOME MAVEN_HOME MAVEN_OPTS

export CDPATH=.:~:~/dev:~/dev/video:~/Library:~/Documents
export CLASSPATH=$CLASSPATH:/usr/local/Cellar/clojure-contrib/HEAD

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;36'

export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"

export EDITOR=emacs

export HGMERGE=kdiff3

alias screen='screen -U'
alias mq='hg -R $(hg root)/.hg/patches'

set meta-flag on
set input-meta on
set output-meta on
set convert-meta off

typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
    colors
fi

setopt prompt_subst
fpath=(~/.zsh/fns $fpath)
autoload promptinit && promptinit
prompt fred

# based) programmable completion, check Misc/compctl-examples in the zsh
# distribution.
autoload -U compinit
compinit

# Completion Styles

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate _match _correct _approximate _prefix

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
#zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
zstyle '*' hosts $hosts

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

export CLICOLOR=true

