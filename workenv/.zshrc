#!/bin/zsh
#

ZSH_THEME="powerline"

if [ -f ~/.zsh_config ]; then
	source ~/.zsh_config
fi

# crontab edit
export EDITOR=vim

# path
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
# rust path
export PATH=~/.cargo/bin:$PATH
# yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# openssl
#export ARCHFLAGS="-arch x86_64"
#export LDFLAGS="-L/usr/local/opt/openssl/lib"
#export CFLAGS="-I/usr/local/opt/openssl/include"
#export PATH="/usr/local/opt/openssl/bin:$PATH"

# aws
#export AWS_IAM_HOME=/Users/admin/WorkSpace/aws/IAMCli-1.5.0
#export AWS_CREDENTIAL_FILE=$AWS_IAM_HOME/aws-credential.template
#export PATH=$PATH:$AWS_IAM_HOME/bin

# go
export GOROOT=/usr/local/go
export GOPATH=$HOME/Workspace/go
export GOARCH=amd64
export GOOS=darwin
export CGO_ENABLED=0
export GO15VENDOREXPERIMENT=1
export GOPROXY=https://goproxy.io
export GOPRIVATE=git.zuoyebang.cc
export GOSUMDB=sum.golang.google.cn
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:$GOPATH/bin

# java
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_333.jdk/Contents/Home
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=$HOME/.m2/repository/

# php
export PATH=/usr/local/php7/bin:$PATH
export PATH=/usr/local/php7/sbin:$PATH

# maven
export M2_HOME=/usr/local/apache-maven-3.8.4
export PATH=$PATH:$M2_HOME/bin

# TiDB
export PATH=$PATH:$HOME/.tiup/bin

# docker
export DOCKER_HOST=tcp://localhost:2375

# ansible
export ANSIBLE_HOSTS=/Users/admin/ansible_hosts

# hubot
export PATH=$PATH:/Users/admin/hubot/bin

if [ -d $HOME/bin ]; then
    export PATH=$PATH:$HOME/bin
fi
if [ -d $HOME/python/bin/ ]; then
    export PATH=$PATH:$HOME/python/bin
fi

# mongodb
export PATH=/usr/local/mongodb/bin:$PATH

alias md5sum="md5 -r"
alias grep='grep --color=auto'
alias build="CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build"
alias testcases="sed -n 's/func.*\(Test.*\)(.*/\1/p' | xargs | sed 's/ /|/g'"

alias rf="rm -f"
alias g=git
alias gst='git status'
alias gbr='git branch'
alias gdf='git difftool --tool=vimdiff --no-prompt'
alias gl='git log --pretty=format:"%Cred%t%Creset %Cred%h%Creset %C(yellow)@%cn%Creset %s %Cgreen%ad%Creset" --graph --date=iso'

alias port='sudo port'

if [ $(uname -s ) = "Linux" ] ; then
    alias ls='ls --color=auto  --time-style=+"%m月%d日 %H:%M"'
    alias la='ls -a --color=auto  '
    alias ll='ls -lth --color=auto --time-style=+"%m月%d日 %H:%M"'
    alias lla='ls -alth --color=auto --time-style=+"%m月%d日 %H:%M"'
    alias ip="ifconfig eth0"
else
    #-v  http:/lujun.info/2012/10/osx-%E7%9A%84-iterm2%E4%B8%AD%E6%98%BE%E7%A4%BA%E4%B8%AD%E6%96%87%E6%96%87%E4%BB%B6%E7%B3%BB%E7%BB%9F/
    alias ip='ifconfig en0'
    alias ipconfig='ifconfig en0'
    alias ls='ls -Gv '
    alias la='ls -aGvv'
    alias ll='ls -lthGv'
    alias lla='ls -althGv'
    # sort by cpu
    alias topc='top -o cpu'
    # sort by mreg(memory region)
    alias topm='top -o mreg'
    alias gdb='sudo gdb'
fi

alias tumx='tmux'
alias ta='tmux attach'
alias tt='tmux new  -s $USER'

alias docker='sudo docker'
alias docker-compose='sudo docker-compose'

# if [ $tmux_porcess_cnt -eq 0  ] ; then
#     tmux new -A -s $USER
# else
#     # echo "tt short for :tmux new -A -s $USER"
# fi
echo "ta short for tmux attach"

# docker
# alias swagger='docker run --rm -it  --user $(id -u):$(id -g) -e GOPATH=$(go env GOPATH):/go -v $HOME:$HOME -w $(pwd) quay.io/goswagger/swagger'

alias sl='ls'
alias mkdir='mkdir -p'
alias cp='cp -r'
alias lp='ls|less'
alias lls='ls'
alias ps='ps -ef'
alias pp='ps -ef|grep '
alias -g ...=" ../.."
alias ..="cd .."
alias cd..="cd .."
alias v='sudo vim'
alias k="pkill  -9 -f "
alias kk="sudo pkill  -9 -f "
alias ta="tmux attach"
FINISH="%{$terminfo[sgr0]%}"
# }}}
autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
    colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
    eval _$color='%{$terminfo[bold]$fg[${(L)color}]%}'
    eval $color='%{$fg[${(L)color}]%}'
    (( count = $count + 1 ))
done

# 标题栏、任务栏样式
case $TERM in (*xterm*|*rxvt*|(dt|k|E)term)
    preexec () {
        #print -Pn "\e]0;%n@%M//%/\ $1\a"
        print -Pn "\e]0;%~ $1\a"
    }
   ;;
esac

setopt hist_ignore_all_dups hist_ignore_space # 如果你不想保存重复的历史
#历史纪录条目数量
export HISTSIZE=1000
#注销后保存的历史纪录条目数量
export SAVEHIST=1000
#历史纪录文件
export HISTFILE=~/.zsh_history
#以附加的方式写入历史纪录
setopt INC_APPEND_HISTORY
#如果连续输入的命令相同，历史纪录中只保留一个
setopt HIST_IGNORE_DUPS
#为历史纪录中的命令添加时间戳
setopt EXTENDED_HISTORY

#启用 cd 命令的历史纪录，cd -[TAB]进入历史路径
setopt AUTO_PUSHD
#相同的历史路径只保留一个
setopt PUSHD_IGNORE_DUPS

#在命令前添加空格，不将此命令添加到纪录文件中
setopt HIST_IGNORE_SPACE

# {{{ 杂项
#允许在交互模式中使用注释  例如：
#cmd #这是注释
setopt INTERACTIVE_COMMENTS

#启用自动 cd，输入目录名回车进入目录
#稍微有点混乱，不如 cd 补全实用
setopt AUTO_CD

#扩展路径
setopt complete_in_word

#禁用 core dumps
limit coredumpsize 0

#Emacs风格 键绑定
bindkey -e
#设置 [DEL]键 为向后删除
bindkey "\e[3~" delete-char

#以下字符视为单词的一部分
WORDCHARS='*?_-[]~=&;!#$%^(){}<>'
# }}}
# {{{ 行编辑高亮模式
# Ctrl+@ 设置标记，标记和光标点之间为 region
zle_highlight=(region:bg=magenta #选中区域
               special:bold      #特殊字符
               isearch:underline)#搜索时使用的关键字
# }}}


# {{{ startx
# if [ $(uname -s ) = "Linux" ] ; then
#  if [ ! -f /tmp/.X0-lock  ] ; then
#    startx
#   logout
#  fi
# fi


# }}}
# {{{ 路径别名
#进入相应的路径时只要 cd ~xxx
# }}}
#export GDK_NATIVE_WINDOWS=true
export AWT_TOOLKIT=MToolkit
export _JAVA_AWT_WM_NONREPARENTING=1
# wmname LG3D
# }}}
# {{{ bindkey -L 列出现有的键绑定
# Alt-r
bindkey "^[r" history-incremental-search-backward
bindkey "^[n" down-line-or-history
bindkey "^[p" up-line-or-history
bindkey ^\U backward-kill-line



# {{{ 命令提示符
precmd () {
# local count_db_wth_char=${#${${(%):-%/}//[[:ascii:]]/}}
# local leftsize=${#${(%):-%(!.%B$RED%n.%B$GREEN%n)@%m$CYAN %2~ $WHITE%#%(1j.(%j jobs%).) %b}}+$count_db_wth_char
# local rightsize=${#${(%):-%D %T }}
# HBAR=" "
# FILLBAR="\${(l.(($COLUMNS - ($leftsize + $rightsize +2)))..${HBAR}.)}"


# zsh 显示git 分支信息 begin
setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{3}(%F{5}%b%F{3})%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

zstyle ':vcs_info:*' enable git svn

# or use pre_cmd, see man zshcontrib
vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
  fi
}
# 注掉下面RPROMP内容 与下面的 RPROMPT合并
# RPROMPT=$'$(vcs_info_wrapper)'
# zsh 显示git 分支信息 end

#当上一个命令不正常退出时的提示  及显示git 分支信息
RPROMPT=$(echo "%(?..$RED%?$FINISH)")
# PROMPT=$(echo "%(!.%B$RED%n.%B$GREEN%n)@%m$CYAN %2~ $(vcs_info_wrapper)$WHITE%(!.#.$)%(1j.(%j jobs%).) %b")
PROMPT=$(echo "%(!.%B$RED%n.%B$GREEN%n)@work$CYAN %2~ $(vcs_info_wrapper)$WHITE%(!.#.$)%(1j.(%j jobs%).) %b")

#在 Emacs终端 中使用 Zsh 的一些设置 及Eamcs tramp sudo 远程连接的设置
if [[ "$TERM" == "dumb" ]]; then
    prompt='%1/ %(!.#.$) '
    unsetopt zle
    unsetopt prompt_cr
    unsetopt prompt_sp
    unsetopt prompt_subst
    unfunction precmd
    unfunction preexec
    PS1='$ '
fi
}
# }}}
# {{{ 关于历史纪录的配置

# gc
prefixes=(5 6 8)
for p in $prefixes; do
    compctl -g "*.${p}" ${p}l
    compctl -g "*.go" ${p}g
done

# {{{ 自动补全功能
#setopt AUTO_LIST
setopt AUTO_MENU
#开启此选项，补全时会直接选中菜单项
#setopt MENU_COMPLETE
#横向排列
setopt  LIST_ROWS_FIRST

#自动补全缓存
#zstyle ':completion::complete:*' use-cache on
#zstyle ':completion::complete:*' cache-path .zcache
#zstyle ':completion:*:cd:*' ignore-parents parent pwd

#自动补全选项
zstyle ':completion:*' verbose yes
#指定使用菜单,select表示会高亮选中当前在哪个选项上,no=5表示当候选项大于5时就不自动补全
#而仅仅是列出可用的候选项,这样可以手动输入内容后过滤掉一部分
#也就是说只有少于5个选项的时候而循环选中每一个
#yes=long表示当无法完整显示所有内容时,可以循环之
# zstyle ':completion:*' menu select no=8 yes=long
zstyle ':completion:*' menu select yes=long no=5
#force-list表示尽管只有一个候选项,也更出菜单,没必要
#zstyle ':completion:*:*:default' force-list always
zstyle ':completion:*' select-prompt '%SSelect:  lines: %L  matches: %M  [%p]'


zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate

#路径补全
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes'
zstyle ':completion::complete:*' '\\'

#彩色补全菜单
#eval $(dircolors -b)
export ZLSCOLORS="${LS_COLORS}"
zmodload zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

#修正大小写
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
#错误校正
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

#kill 命令补全
# compdef pkill=killall
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes' command 'ps -au$USER'

#补全类型提示分组
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'
zstyle ':completion:*:corrections' format $'\e[01;32m -- %d (errors: %e) --\e[0m'

# cd ~ 补全顺序
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
# }}}
# {{{自定义补全
#补全 ping
zstyle ':completion:*:ping:*' hosts 192.168.128.1{38,} http://www.g.cn \
       192.168.{1,0}.1{{7..9},}

#补全 ssh scp sftp 等
my_accounts=(
# {deployer,root}@{42.62.77.86}
# kardinal@linuxtoy.org
# 123@211.148.131.7
)
zstyle ':completion:*:my-accounts' users-hosts $my_accounts

# F1 计算器
# arith-eval-echo() {
#   LBUFFER="${LBUFFER}echo \$(( "
#   RBUFFER=" ))$RBUFFER"
# }
# zle -N arith-eval-echo
# bindkey "^[[11~" arith-eval-echo

# {{{ (光标在行首)补全 "cd "
user-complete(){
    case $BUFFER in
        # "" )                       # 空行填入 "cd "
        #     BUFFER="cd "
        #     zle end-of-line
        #     zle expand-or-complete
        #     ;;
        "cd --" )                  # "cd --" 替换为 "cd +"
            BUFFER="cd +"
            zle end-of-line
            zle expand-or-complete
            ;;
        "cd +-" )                  # "cd +-" 替换为 "cd -"
            BUFFER="cd -"
            zle end-of-line
            zle expand-or-complete
            ;;
        * )
            zle expand-or-complete
            ;;
    esac
}
zle -N user-complete
bindkey "\t" user-complete
#[[ -s "/Users/admin/.gvm/scripts/gvm" ]] && source "/Users/admin/.gvm/scripts/gvm"

if [ -f ~/.zsh/golang-config-zsh ]; then
    . ~/.zsh/golang-config-zsh
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f ~/.pwdx_for_mac.zsh ] && source ~/.pwdx_for_mac.zsh


# oh my zsh
export TERM="xterm-256color"
POWERLINE_GIT_CLEAN="✔"
POWERLINE_GIT_DIRTY="✘"
POWERLINE_GIT_ADDED="%F{green}✚%F{black}"
POWERLINE_GIT_MODIFIED="%F{blue}✹%F{black}"
POWERLINE_GIT_DELETED="%F{red}✖%F{black}"
POWERLINE_GIT_UNTRACKED="%F{yellow}✭%F{black}"
POWERLINE_GIT_RENAMED="➜"
POWERLINE_GIT_UNMERGED="═"



export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export PATH=/Users/wgyuuu/.tiup/bin:$PATH

unset ALL_PROXY

