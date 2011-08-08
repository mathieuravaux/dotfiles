JAVA_OPTS="-Xmx1024m -Xms32m -Xss4m"


export TITANIUM="/Library/Application Support/Titanium/mobilesdk/osx/1.6.1/titanium.py"
alias titanium="'$TITANIUM'"
export ANDROID_SDK="/Users/Mathieu/code/android-sdk"

export ANT_HOME=/opt/local/share/java/apache-ant
export HBASE_HOME=/Users/Mathieu/hbase
export MAGICK_HOME=/usr/local/Cellar/imagemagick/6.6.4-5
export SCALA_HOME=/Developer/Java/scala-2.8.0.final

export MAVEN_OPTS="-Xmx2048m -Xms512m"

export M2_HOME=/Developer/Java/maven3.0-beta2
export M2=$M2_HOME/bin

PATH=~/bin:$PATH
PATH=/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:$PATH
PATH=$PATH:/usr/local/mysql/bin/:/usr/local/mongodb/bin
PATH=$PATH:/Developer/Java/scala-2.8.0.final/bin
PATH=$PATH:$M2_HOME/bin
PATH=$PATH:$MAGICK_HOME/bin
PATH=$PATH:/usr/local/rvm/bin/
PATH=$PATH:/Developer/btrace-bin/bin
PATH=$PATH:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools
export PATH

NVM_DIR=$HOME/.nvm
. $NVM_DIR/nvm.sh
# nvm use v0.2.4 -q

export DYLD_LIBRARY_PATH="/Applications/YourKit_Java_Profiler_9.0.7.app/bin/mac:$DYLD_LIBRARY_PATH:$MAGICK_HOME/lib"
export YOURKIT_AGENT_PATH="-agentpath:/Applications/YourKit_Java_Profiler_9.0.7.app/bin/mac/libyjpagent.jnilib"


alias which="which -as"
alias m="mate"
alias "icoffee"="rlwrap coffee -i"
mw() {
  file=$(which $1)
  echo "$1 => '$file'"
  if [[ -e $file ]]; then mate $file; fi
}
alias editprof="mate -w ~/.profile; . ~/.profile"

alias l="ls -lhp"
alias ll="ls -alhG"

# alias o="open"
function o {
  if [[ "$@" == "" ]]; then open ".";
  else open $@; fi
}

alias q="qlmanage -p"
alias rmr="rm -rfv"

alias egrep="egrep --color"

alias irb='irb --simple-prompt -r irb/completion -rubygems'
alias serv="./script/server"
alias cons="./script/console"

function pgrep {
  if [[ "$1" == "" ]]; then echo "usage: pgrep PATTERN [signal to send to the processes]"; return; fi
  ps aux | grep -i $1 | grep -v "grep -i "
  if [[ "$2" != "" ]]; then
    ps aux | grep -i $1 | grep -v "grep -i " | cut -f 3 -d " " | xargs kill $2
  fi
}

function edit {
  if [[ "$1" == "" ]]; then echo "usage: edit NAME (NAME is a bundled gem or npm package)"; return; fi
  RES=$(git rev-parse --quiet --is-inside-work-tree 2>&1)
  if [[ "$?" == "0" ]]; then
    GIT_DIR=$(git rev-parse --show-toplevel)
    if [[ -f "$GIT_DIR/package.json" ]]; then
      npm edit $1
    fi
    if [[ -f "$GIT_DIR/Gemfile.lock" ]]; then
      bundle open $1
    fi
  else
    echo "Error: not in a git working copy."
  fi
}


alias gweb="git instaweb --httpd=webrick"

alias up="git-up"
alias gu="git-up"
alias gco="git checkout"
alias ci="git commit"
alias st="clear; git status"
alias stn="git status"
alias di="git diff"
alias gg="git lg"
alias gco='git checkout'
alias gu='git up'

# alias pulu="hg pull -u"
# alias pulreb="hg pull --rebase"
# alias pushdep="hg push; cap deploy"
# alias revnb="hg revert --no-backup"
# alias glog="hg glog"
# alias qser="hg qser"
# alias qpop="hg qpop -a"
# alias qpush="hg qpush -a"
# alias qedit="mate -w .hg/patches/series"

alias c="gitx -c"
alias ga="git add"
alias gci="git commit"
alias gdi="git diff"
alias gst="git status"
alias gcia="git commit --all -m"

alias growl_pass="growlnotify --image '/Users/Mathieu/Library/autotest/rails_ok.png'"
alias growl_fail="growlnotify --image '/Users/Mathieu/Library/autotest/build_failed.png'"

alias hpush='git push heroku master && growl_pass -n heroku -m "Deployment was successful." || growl_fail -n heroku -m "Deployment failed !"'
alias hlog='heroku logs'

# alias gi="sudo gem install -V --no-update-sources --no-ri --no-rdoc"
# alias gs="sudo gem search -r"
# alias gu="sudo gem uninstall -V "
alias gin="gem install -V --no-update-sources --no-ri --no-rdoc"
alias gs="gem search -r"
alias gu="gem uninstall -V "

alias capdev="cap development"
alias capprod="cap production"

alias rhino="java -classpath ~/code/rhino/js.jar org.mozilla.javascript.tools.shell.Main"

alias say_trinoids="say -v 'Trinoids'"
alias yay="afplay ~/.sounds/happykids.wav > /dev/null 2>&1 &"

# Proxies a distant server's port to he same port number, locally
proxy() {
    LOCAL_PORT=$3
    if [[ ("$1" == "") || ("$2" == "") ]]; then
        echo "Usage: proxy <server> <remote port> [ local port ]"
        echo "<local port> defaults to <remote port>"
    else
        if [[ "$LOCAL_PORT" == "" ]]; then LOCAL_PORT=$2; fi
        echo "Proxying $1:$2 <--> localhost:$LOCAL_PORT"
        ssh -L $LOCAL_PORT:localhost:$2 -N $1
    fi
}

function gem_doc {
  GEMDIR=`gem env gemdir`/doc
  open $GEMDIR/`ls $GEMDIR | grep $1 | sort | tail -1`rdoc/index.html
}

_gem_mate()
{
    local curw
    COMPREPLY=()
    curw=${COMP_WORDS[COMP_CWORD]}
    local gems="$(gem environment gemdir)/gems"
    COMPREPLY=($(compgen -W '$(ls $gems)' -- $curw));
    return 0
}
# complete -F _gem_mate -o dirnames gem_mate

export EVENT_NOKQUEUE=yes
export HISTCONTROL=erasedups
export HISTSIZE=60000
export HISTTIMEFORMAT="%D %T "
export HISTIGNORE="&:ls:[bf]g:exit"
# shopt -s histappend
PROMPT_COMMAND='history -a'
# shopt -s cdspell
# shopt -s cmdhist


export EDITOR="mate"
# export BROWSER=/Applications/Safari.app/Contents/MacOS/Safari
# export BROWSER=/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome
export CLICOLOR=true

function jargrep
{
  jar tf $2 | grep $1 -
}


# source ~/bin/autojump.bash
source ~/bin/autojump.zsh 
# source ~/.tabtab.bash
# source ~/bin/git_autocomplete.sh
# source ~/bin/rake_cap_bash_autocomplete.sh

##
# DELUXE-USR-LOCAL-BIN-INSERT
# (do not remove this comment)
##
echo $PATH | grep -q -s "/usr/local/bin"
if [ $? -eq 1 ] ; then
    PATH=$PATH:/usr/local/bin
    export PATH
fi

if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
  source "$HOME/.rvm/scripts/rvm"
  rvm use 1.9.3
fi

export PATH=./bundle_bin:$PATH

alias rm="rm -f"

alias fp="filepath"
alias b="bundle"
alias bi="b install --verbose --path vendor --binstubs=bundle_bin"
alias bu="b update --verbose"
alias be="b exec"
alias binit="bi && b package && echo 'vendor/ruby' >> .gitignore"
alias bo="bundle open"

function selenium_server {
  cd ~/code/selenium_server
  java -jar selenium-server-standalone*.jar
}

# echo "Setting env vars for iProxy !"
# . ~/bin/iProxy

source .secrets

# export RUBY_GC_MALLOC_LIMIT=80000000
export RUBY_GC_MALLOC_LIMIT=50000000
# export RUBY_FREE_MIN=65536

export RUBY_HEAP_MIN_SLOTS=500000
export RUBY_HEAP_SLOTS_INCREMENT=250000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1

export PG_DATA=usr/local/var/postgres
export PGDATA=usr/local/var/postgres
alias pg_log="tail -f /usr/local/var/postgres/server.log"
# settings for Postgresql
# sudo sysctl -w kern.sysv.shmall=4096
# sudo sysctl -w kern.sysv.shmmax=4194304
alias edit_pg_conf="mate /usr/local/var/postgres/"

alias egem="mate --wait Gemfile && bi"

function pid_for {
  ps axc | grep "$1" | awk '{print $1}'
}
function pid_for_server {
  # ps -a | grep "ruby ./script/server" | grep -v grep| awk '{print $1}'
  ps -a | grep "thin start" | grep -v grep| awk '{print $1}'
}

alias dtrace_scripts="grep -l DTrace /usr/bin/* 2&>/dev/null; ls /usr/share/examples/DTTk"

function debug_async {
  rbtrace -p `pid_for_server` --devmode -m 'TCPSocket#(__source__, self)' 'OpenSSL::SSL::SSLSocket#(__source__, self)' 'Net::HTTP#exec(__source__, self)'
}

alias growl_restart="sudo killall GrowlHelperApp;  open -b com.Growl.GrowlHelperApp"
