#export LESS=MrXE
export PS1="[\u@\h \w]\\$ "
alias ls='ls -F --show-control-chars'
alias ll='ls -la'
#alias ntemacs='~/tools/emacs/22.2/bin/emacs'
HISTCONTROL=ignoredups
HISTFILESIZE=5000
HISTSIZE=5000

#export SVN_EDITOR=vim
#export LC_CTYPE=ja_JP.UTF-8
#export LC_ALL=ja_JP.UTF-8
#export LC_ALL=en_US.UTF-8
#export LANG=ja_JP.UTF-8 
export LANG=en_US.UTF-8

#export HOME=/home/m-oono
umask 002
cd $HOME

export PATH=$PATH:/usr/bin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:$HOME/bin

#export JAVA_HOME=$HOME/opt/jdk1.6.0_24
#export ANT_HOME=$HOME/opt/apache-ant-1.7.0
#export M2_HOME=$HOME/opt/apache-maven-2.2.1
#export PATH=$PATH:$ANT_HOME/bin
#export PATH=$PATH:$JAVA_HOME/bin
#export PATH=$PATH:$M2_HOME/bin
#export PATH=$PATH:$USERPROFILE/.lein/bin
set -o emacs

alias javac='javac -J-Dfile.encoding=UTF-8'
