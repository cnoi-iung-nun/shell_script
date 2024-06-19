#!/bin/bash 
echo "[ENV1.sh] 패키지 설치 및 서비스 기동" 
# 서비스 환경설정 쉘 스크립트
# 필요한 서비스들을 설치하는 스크립트

. ./functions.sh
# 패키지 설치 및 서비스 기동
#1) 단순 패키지 설치
# epel-release
# boxes, cowsay
# gnome-tweaks

# 서비스 기동
# * telnet 서비스 
# *  -telent. telnet-server
# * ftp 서비스
#    - vsftpd, ftp
# httpd 서비스
# - httpd, mod_ssl

#################
# 1. 단순 패키지 설치
######################
echo "[1. 단순 패키지 설치]"
PkgInstall epel-release
PkgInstall gnome-tweaks boxes cowsay

################
# 2. 서비스 기동
#################
# telnet
# ftp
# web
echo "[2. 서비스기동]"
# 1) telnet 서비스
# 패키지 설치
PkgInstall telnet telnet-server

# 서비스 기동 
SrvStart start telnet.socket

# 2) ftp 서비스
# 패키지 설치
PkgInstall vsftpd ftp

# ftp 설정
sed -i 's/^root/#root/' /etc/vsftpd/vsftpd.conf
sed -i 's/^root/#root/' /etc/vsftpd/user_list

# ftp 서비스 기동
SrvStart start vsftpd.service

# 3) web 서비스

PkgInstall httpd mod_ssl

# 서비스 설정
cat << EOF > /var/www/html/index.html
<pre>
$(cowsay -f dragon-and-cow HTTPD | boxes -d boy)
</pre>
EOF
# 서비스 기동 
SrvStart start httpd.service