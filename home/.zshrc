# echo "Running .zshrc"
# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
# export ZSH_THEME="robbyrussell"
# export ZSH_THEME="aussiegeek"
export ZSH_THEME="aussiegeek2"

# get the name of the branch we are on
function rvm_prompt_info() {
  ruby_version=$(~/.rvm/bin/rvm-prompt 2> /dev/null) || return
  echo " on $ruby_version"
}




function git_info_for_prompt() {
  local g="$(git rev-parse --git-dir 2>/dev/null)"
  if [ -n "$g" ]; then
    local r
    local b
    if [ -d "$g/../.dotest" ]
    then
      if test -f "$g/../.dotest/rebasing"
      then
        r="|REBASE"
      elif test -f "$g/../.dotest/applying"
      then
        r="|AM"
      else
        r="|AM/REBASE"
      fi
      b="$(git symbolic-ref HEAD 2>/dev/null)"
    elif [ -f "$g/.dotest-merge/interactive" ]
    then
      r="|REBASE-i"
      b="$(cat "$g/.dotest-merge/head-name")"
    elif [ -d "$g/.dotest-merge" ]
    then
      r="|REBASE-m"
      b="$(cat "$g/.dotest-merge/head-name")"
    elif [ -f "$g/MERGE_HEAD" ]
    then
      r="|MERGING"
      b="$(git symbolic-ref HEAD 2>/dev/null)"
    else
      if [ -f "$g/BISECT_LOG" ]
      then
        r="|BISECTING"
      fi
      if ! b="$(git symbolic-ref HEAD 2>/dev/null)"
      then
        if ! b="tag: $(git describe --exact-match HEAD 2>/dev/null)"
        then
          b="$(cut -c1-7 "$g/HEAD")..."
        fi
      fi
    fi

    if [ -n "$1" ]; then
      printf "$1" "${b##refs/heads/}$r"
    else
      printf "[%s]" "${b##refs/heads/}$r"
    fi
  fi
}







# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git rails textmate ruby gem brew)

# echo "Done."

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
# export PATH=/Users/Mathieu/.rvm/gems/ruby-1.9.2-p0/bin:/Users/Mathieu/.rvm/gems/ruby-1.9.2-p0@global/bin:/Users/Mathieu/.rvm/rubies/ruby-1.9.2-p0/bin:/Users/Mathieu/.rvm/bin:/Users/Mathieu/.nvm/v0.2.1/bin:/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:/Users/Mathieu/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:/usr/X11/bin:/usr/libexec:/Developer/Tools:/usr/local/mysql/bin/:/usr/local/mongodb/bin:/Developer/Java/flex_sdk/bin:/Developer/Java/scala-2.7.6.final/bin:/Developer/Java/tomcat6/bin:/Users/Mathieu/code/narwhal/bin:/Users/Mathieu/hbase/bin:/Users/Mathieu/Documents/Projects/Trylog/EC2_tools/bin:/usr/bin/Ec2_aliases:/Developer/Java/maven3.0-beta2/bin:/opt/ImageMagick/bin:/usr/local/rvm/bin/:/Developer/btrace-bin/bin

unsetopt ignoreeof
unsetopt auto_name_dirs

setopt RMSTARSILENT # don't confirm an rm *

fpath=(~/.zsh/Completion $fpath)
. ~/.profile
__rvm_project_rvmrc