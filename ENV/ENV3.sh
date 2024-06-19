#!/bin/bash 
# 서비스 환경설정 쉘 스크립트
echo
echo "[ENV3.sh] 환경설정 "

. ./functions.sh

#-------PS1 color-----------
export linux200=31
export linux201=32
export linux202=34
#---------------------------
short_hostname=$(hostname | awk -F. '{print $1}')

#  환경설정
# *PS1 변수 (색깔표시)
echo "[1. ($HOME/.basrc) 환경설정 "

cat << EOF > $HOME/.bashrc
# .bashrc
# #-------PS1 color-----------
# export linux200=31
# export linux201=32
# export linux202=33
# #---------------------------
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "\$PATH" =~ "\$HOME/.local/bin:\$HOME/bin:" ]]
then
    PATH="\$HOME/.local/bin:\$HOME/bin:\$PATH"
fi
PATH=$PATH:/script/ENV
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
 
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias aaa='chmod 700 *.sh'
alias df='df -hT'
alias ls='ls --color=auto -h -F'
export PS1='\[\e[$(eval echo \$${short_hostname});1m\][\u@\h\[\e[33;1m\] \w]\\$ \[\e[m\]'
EOF
## eval : 해석을 한번 더한다. 

cat << EOF
---------------------------------
다음과 같이 환경파일을 적용해주세요.
# source ~/.bashrc
---------------------------------
EOF
