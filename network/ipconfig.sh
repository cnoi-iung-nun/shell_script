#!/bin/bash

# C:\> ipconfig /all

# Windows IP 구성
#    호스트 이름 . . . . . . . . : DESKTOP-H9EDUL9
#    주 DNS 접미사 . . . . . . . :
#    노드 유형 . . . . . . . . . : 혼성
#    IP 라우팅 사용. . . . . . . : 아니요
#    WINS 프록시 사용. . . . . . : 아니요

# 이더넷 어댑터 이더넷:

#    연결별 DNS 접미사. . . . :
#    설명. . . . . . . . . . . . : Intel(R) Ethernet Connection (22) I219-LM
#    물리적 주소 . . . . . . . . : F4-F1-9E-23-2C-7E
#    DHCP 사용 . . . . . . . . . : 아니요
#    자동 구성 사용. . . . . . . : 예
#    링크-로컬 IPv6 주소 . . . . : fe80::a59c:8705:3673:a1bf%9(기본 설정)
#    IPv4 주소 . . . . . . . . . : 172.16.6.20(기본 설정)
#    서브넷 마스크 . . . . . . . : 255.255.0.0
#    기본 게이트웨이 . . . . . . : 172.16.6.254
#    DHCPv6 IAID . . . . . . . . : 351596958
#    DHCPv6 클라이언트 DUID. . . : 00-01-00-01-2D-B0-E0-7D-F4-F1-9E-23-2C-7E
#    DNS 서버. . . . . . . . . . : 205.251.195.147
#                                  8.8.8.8
#    Tcpip를 통한 NetBIOS. . . . : 사용

# 1) 호스트 이름
SERVER=$(hostname)
cat << EOF
 Linux IP 구성
    호스트 이름................: $SERVER

EOF


# 4) 이더넷 어뎁터 이름
NICS=$(nmcli device | tail -n +2 | grep -v '^lo' | awk '{print $1}')


for NIC in $NICS
do
    # 3) MAC 주소)
    MAC=$(echo$(nmcli device show $NIC | grep '^GENERAL.HWADDR' | awk -F'HWADDR:' '{print $2}'))
    # 4) 커넥션 이름
    CON=$(echo$(nmcli device show $NIC | grep 'GENERAL.CONNECTION' | awk -F: '{print $2'}))
     # 5) DHCP 사용 유무
    DHCP=$(echo$(nmcli connection show $CON | grep 'ipv4.method' | awk -F: '{print $2}'))
    # 6) IP 주소 
    IP=$(echo$(nmcli device show $NIC | grep 'IP4.ADDRESS' | awk -F: '{print $2'}))
    # 7) 게이트 웨이
    GW=$(echo$(nmcli device show $NIC | grep 'IP4.GATEWAY' | awk -F: '{print $2'}))
    # 8) DNS 주소
    DNS=$(echo$(nmcli device show $NIC | grep 'IP4.DNS' | awk -F: '{print $2'}))
    #9 ) 서브넷 주소
    SUB=$(ifconfig $NIC |grep netmask | awk -F' ' '{print $4}')

    cat << EOF
    이더넷 어뎁터: $NIC
        커넥션 이름 ...............: $CON
        물리적 주소 ...............: $MAC
        DHCP 사용   ...............: $DHCP
        IPv4 주소   ...............: $IP
        서브넷 마스크 .............: $SUB
        기본 게이트웨이 ...........: $GW
        DNS 서버    ...............: $DNS

EOF
done