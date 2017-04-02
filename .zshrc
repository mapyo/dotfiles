# auto-fu.zsh
if [ -f ~/.zsh/auto-fu.zsh/auto-fu.zsh ]; then
  source ~/.zsh/auto-fu.zsh/auto-fu.zsh
  function zle-line-init () {
  auto-fu-init
  }
  zle -N zle-line-init
fi

# autojump
#alias j="autojump"
#if [ -f `brew --prefix`/etc/autojump ]; then
#    . `brew --prefix`/etc/autojump
#fi
export FPATH="$FPATH:/opt/local/share/zsh/site-functions/"
if [ -f /usr/local/Cellar/autojump/21.6.9/etc/autojump.zsh ]; then
    . /usr/local/Cellar/autojump/21.6.9/etc/autojump.zsh
fi
autoload -U compinit && compinit
alias j="autojump"


# Path to your oh-my-zsh configuration.
ZSH=$HOME/dotfiles/oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="wedisagree"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting
# for completion COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.  DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in
# ~/.oh-my-zsh/plugins/*) Custom plugins may be added to
# ~/.oh-my-zsh/custom/plugins/ Example format: plugins=(rails git textmate ruby
# lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# disable autocorrect
unsetopt correct_all

# Customize to your needs...
export PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin
export EDITOR="/usr/bin/vim"

## for alias

# alias vim='/Applications/MacVim.app/Contents/MacOS/mvim -v'

alias sb="open -a 'Sublime Text 2'"
alias mvim="open -a MacVim"
alias fg="find ./ -path \"./userdata\" -prune -o -name '*' | xargs grep -n"
alias gd="git di"
alias gs="git st"
alias gf="git fh"
alias gg="git grep --line-number --show-function --color --heading --break"
alias gup="git up"
alias gupd="git upd"
alias gpr="git pr"
alias gcp="git-checkout-this-pr"
alias gcop="git checkout \`git branch | peco | sed -e \"s/\* //g\" | awk \"{print \$1}\"\`"
alias gb="git br"
alias sha="git rev-parse @"
alias hp="hub pull-request -o"

alias vu="vagrant up"
alias vs="vagrant ssh"
alias vst="vagrant status"
alias vh="vagrant halt"
alias vd="vagrant destroy"
alias vr="vagrant reload"

alias dc="docker"
alias dcc="docker-compose"


alias be="bundle exec"
alias pbcopy_chomp="ruby -pe 'chomp' | pbcopy"

# adb-peco
# ref. https://github.com/tomorrowkey/adb-peco
alias adbp="adb-peco"
# alias pidcat='pidcatp'


## 履歴を残す
HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=1000000
# 重複を記録しない
setopt hist_ignore_dups
# 履歴の共有
setopt share_history
# ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_all_dups
# スペースで始まるコマンド行はヒストリリストから削除
setopt hist_ignore_space
# 余分な空白は詰めて記録
setopt hist_reduce_blanks
# 補完時にヒストリを自動的に展開
setopt hist_expand
# 履歴をインクリメンタルに追加
setopt inc_append_history
# インクリメンタルからの検索
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward
# 実行時刻と実行時間も保存する。
setopt extended_history
# ディレクトリ名入れるだけでcd出来る
setopt auto_cd

# MySQL Path Setting
#export PATH=$PATH:/usr/local/mysql/bin
# for brew
#export PATH=$PATH:/usr/local/Cellar/mysql/5.6.13/bin


# pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# for go
export PATH="$PATH:/usr/local/go/bin"
export GOPATH="$HOME/.go"
export PATH="$PATH:$GOPATH/bin"

# for android
export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"
export PATH="$PATH:$HOME/Library/Android/sdk/ndk-bundle"
export ANDROID_HOME="$HOME/Library/Android/sdk"


# for composer
export PATH="$PATH:$HOME/.composer/vendor/bin"

# for java
export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8
alias javac='javac -J-Dfile.encoding=UTF-8'

# for git
alias gdc='git dc'

# for android
alias adb-restart='adb kill-server; adb start-server'

# for peco
# ghqのlist検索
alias p='cd $(ghq list -p | peco)'
# コマンド履歴
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# jsonを整形してvimで開く
jqless() { jq . $* | vim -c "set ft=json" - }

# urldecodeしてくれるやつ
urldecode() { nkf --url-input  $* }

#source /Users/usr0600285/.zsh/zaw/zaw.zsh

# zshにてcd後に自動的にlsを行うchpwd関数
# https://gist.github.com/yonchu/3935922
chpwd() {
    ls_abbrev
}
ls_abbrev() {
    # -a : Do not ignore entries starting with ..
    # -C : Force multi-column output.
    # -F : Append indicator (one of */=>@|) to entries.
    local cmd_ls='ls'
    local -a opt_ls
    opt_ls=('-aCF' '--color=always')
    case "${OSTYPE}" in
        freebsd*|darwin*)
            if type gls > /dev/null 2>&1; then
                cmd_ls='gls'
            else
                # -G : Enable colorized output.
                opt_ls=('-aCFG')
            fi
            ;;
    esac

    local ls_result
    ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')

    local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')

    if [ $ls_lines -gt 10 ]; then
        echo "$ls_result" | head -n 5
        echo '...'
        echo "$ls_result" | tail -n 5
        echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
    else
        echo "$ls_result"
    fi
}

# 起動時にtmuxをデフォルトで開くようにする
# if [ -z "$TMUX" -a -z "$STY" ]; then
#   if type tmuxx >/dev/null 2>&1; then
#     tmuxx
#   elif type tmux >/dev/null 2>&1; then
#     if tmux has-session && tmux list-sessions | /usr/bin/grep -qE '.*]$'; then
#       tmux attach && echo "tmux attached session "
#     else
#       tmux new-session && echo "tmux created new session"
#     fi
#   elif type screen > /dev/null 2>&1; then
#     screen -rx || screen -D -RR
#   fi
# fi

# for scala
export PATH=$PATH:$HOME/bin
export SCALA_HOME=~/.svm/current/rt
export PATH=$SCALA_HOME/bin:$PATH

# for brew install git
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# for brew openssl
export PATH="/usr/local/opt/openssl/bin/openssl:$PATH"


# zsh-bd
# https://github.com/Tarrasch/zsh-bd
. $HOME/.zsh/plugins/bd/bd.zsh

# local setting
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# phpbrew
[ -f ~/.phpbrew/bashrc ] && source ~/.phpbrew/bashrc

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Android Stuido のエラー対策
export PATH="/Library/Java/JavaVirtualMachines/jdk1.8.0_60.jdk/Contents/Home/bin/java and /Library/Java/JavaVirtualMachines/jdk1.8.0_60.jdk/Contents/Home/jre/lib:$PATH"

# for dotfiles bin
export PATH=$PATH:$HOME/dotfiles/bin

# adb_peco
[ -f ~/dotfiles/genymotion-peco/bin/genymotion_peco.sh ] && source ~/dotfiles/genymotion-peco/bin/genymotion_peco.sh

# for kotlin
# export JAVA_HOME=`/usr/libexec/java_home -v 1.6`
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export JDK_16=`/usr/libexec/java_home -v 1.6`
export JDK_17=`/usr/libexec/java_home -v 1.7`
export JDK_18=`/usr/libexec/java_home -v 1.8`

export ANT_OPTS="-Xmx1024m -XX:MaxPermSize=512m"

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"
eval "$(rbenv init -)"

export PATH=$PATH:$HOME/bin

# Decompile Java classes recursively keeping hierarchy
jadr() {
  jad -8 -s java -d $2 -r $1/**/*.class
}

# Decompile Android application
deapk() {
  local dst=${${1##*/}%%.*}
  dst+=".depackaged.`date +"%Y%m%d%H%M"`"
  unzip $1 -d $dst
  d2j-dex2jar -o ${dst}/classes-dex2jar.jar ${dst}/classes.dex
  mkdir -p ${dst}/classes
  unzip ${dst}/classes-dex2jar.jar -d ${dst}/classes
  jadr ${dst} ${dst}/src
}
