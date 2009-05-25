export ANT_HOME=/usr/share/ant
export GROOVY_HOME=/Users/fjean/groovy
export GRAILS_HOME=/Users/fjean/grails
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home
export JAVA_HOME_16=$JAVA_HOME
export JAVA_HOME_15=/System/Library/Frameworks/JavaVM.framework/Versions/1.5/Home
export JAVA_HOME_14=/System/Library/Frameworks/JavaVM.framework/Versions/1.4/Home
export JDK_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home
export MAVEN_HOME=/Users/fjean/maven
export JRUBY_HOME=/Users/fjean/jruby
export SCALA_HOME=/Users/fjean/scala
export TC_HOME=/Users/fjean/terracotta
export TC_JAVA_HOME=$JAVA_HOME
export APPENGINE_HOME=/Users/fjean/appengine
export MYSQL_HOME=/usr/local/mysql
export PATH=.:~/bin:~/depot_tools:$JAVA_HOME/bin:$SCALA_HOME/bin:$GROOVY_HOME/bin:$GRAILS_HOME/bin:$MAVEN_HOME/bin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:$MYSQL_HOME/bin:$PATH:$JRUBY_HOME/bin
export CDPATH=.:~:~/Projects:~/Projects/kenai\~subversion:~/Library:~/Documents

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;36'

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
