Understanding and Configuring Linux Network Interfaces

1. 개요
   최신 Linux 시스템에서 네트워크를 구성하는 방법에는 여러 가지가 있습니다. 가장 널리 사용되는 방법은 Network Manager와 Systemd를 사용하는 것입니다. 그러나 때로는 /etc/network/interfaces 구성 파일을 사용하여 수동으로 수행해야 하는 경우도 있습니다.

이 튜토리얼에서는 구성 파일을 사용하여 네트워크를 구성하는 방법을 살펴보겠습니다. 먼저 네트워크 인터페이스가 무엇인지 살펴보겠습니다. 그런 다음 /etc/network/interfaces 파일이 무엇인지 알아 보겠습니다. 마지막으로 /etc/network/interfaces를 사용하여 네트워크를 구성하는 전체 예를 살펴보겠습니다.

2. 네트워크 인터페이스란 무엇입니까?
   간단히 말해서 네트워크 인터페이스는 컴퓨터와 네트워크를 연결하는 지점입니다. 즉, Linux 시스템이 네트워킹의 소프트웨어 측면을 하드웨어 측면에 연결하는 방법입니다.

2.1. 네트워크 인터페이스 유형
Linux 시스템은 물리적 네트워크 인터페이스와 가상 네트워크 인터페이스라는 두 가지 유형의 네트워크 인터페이스를 구별합니다.

물리적 네트워크 인터페이스는 NIC(네트워크 인터페이스 카드), WNIC(무선 네트워크 인터페이스 카드) 또는 모뎀과 같은 네트워크 하드웨어 장치를 나타냅니다.
가상 네트워크 인터페이스는 하드웨어 장치를 나타내지 않고 네트워크 장치에 연결됩니다. 물리적 또는 가상 인터페이스와 연결될 수 있습니다.

2.2. 네트워크 인터페이스 이름
Linux 시스템은 네트워크 인터페이스 이름을 지정하는 데 두 가지 다른 스타일을 사용합니다. 첫 번째 스타일은 eth0, eth1 및 wlan0과 같은 이전 스타일 이름입니다. 새로운 것들은 enp3s0 및 wlp2s0과 같은 하드웨어 위치를 기반으로 합니다.

따라서 ls 명령과 sys 파일 시스템을 사용하여 사용 가능한 네트워크 인터페이스를 빠르게 나열할 수 있습니다. /sys/class/net 디렉토리의 각 항목은 물리적 또는 가상 네트워크 인터페이스를 나타냅니다.

```
ls /sys/class/net
```

네트워크 인터페이스에 대한 자세한 내용을 보려면 ip link 명령을 사용할 수 있습니다:

```sh
ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
    link/ether 54:ee:74:c1:19:92 brd ff:ff:ff:ff:ff:ff
3: wlan0: <BROADCAST,MULTICAST> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
    link/ether 52:54:00:f0:27:9a brd ff:ff:ff:ff:ff:ff permaddr 94:e9:79:fd:51:5d
```

여기서는 세 가지 네트워크 인터페이스, 해당 유형 및 상태를 볼 수 있습니다. 또는 ifconfig 명령을 사용할 수도 있습니다.
또한 IP 주소 및 기타 관련 정보를 얻으려면 ip addr 명령을 사용합니다.

```
ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 54:ee:74:c1:19:92 brd ff:ff:ff:ff:ff:ff
    inet 192.168.0.122/24 brd 192.168.0.255 scope global dynamic noprefixroute enp3s0
       valid_lft 80953sec preferred_lft 80953sec
    inet6 fe80::bb4c:8096:6:3695/64 scope link noprefixroute
       valid_lft forever preferred_lft forever
3: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 52:54:00:f0:27:9a brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.13/24 brd 192.168.1.255 scope global dynamic noprefixroute wlp2s0
       valid_lft 42974sec preferred_lft 42974sec
    inet6 fe80::f73c:2d98:746f:9582/64 scope link noprefixroute
       valid_lft forever preferred_lft forever
```

3. /etc/network/interfaces 파일이란 무엇입니까?
   명확히 말하면 /etc/network/interfaces 파일은 네트워크 인터페이스를 구성하는 방법입니다. 주로 Linux Debian과 유사한 배포판에서 사용됩니다.

대부분의 네트워크 설정은 이 파일을 통해 수행할 수 있습니다. 정적 또는 동적으로 네트워크 인터페이스에 IP 주소를 제공할 수 있습니다. 또한 라우팅 정보, DNS 서버 등을 설정할 수 있습니다.

또한 네트워크 인터페이스 관리 명령을 사용하면 인터페이스를 가져오고 중지하고 /etc/network/interfaces 파일을 기반으로 구성합니다. ifup 명령은 네트워크 인터페이스를 작동시키고 ifdown 명령은 작동을 중지합니다.

4. /etc/network/interfaces를 사용하여 네트워크 인터페이스를 구성하는 방법
   구성 세부 사항을 살펴보기 전에 /etc/network/interfaces 파일의 구문을 숙지해 보겠습니다. 네트워크를 올바르게 구성할 수 있도록 몇 가지 키워드를 이해하겠습니다.

4.1. /etc/network/interfaces 파일 구문
부팅 시 자동으로 네트워크 인터페이스를 활성화하려면 다음 구문을 사용합니다:

bash
코드 복사
auto <interface>
여기서 <interface>는 네트워크 인터페이스 이름(예: eth0)입니다.

네트워크 인터페이스를 선언하려면 iface 키워드를 사용합니다:

bash
코드 복사
iface lo inet loopback
lo는 루프백 인터페이스를 나타내며, inet은 인터넷 프로토콜 계열(IPv4)을 의미합니다. IP 주소는 127.0.0.1로 할당됩니다.

다음은 인터페이스 선언 형식입니다:

bash
코드 복사
iface <interface> <address_family> <method>
예를 들어, DHCP를 사용하여 IP 주소를 동적으로 할당하려면 다음과 같이 선언할 수 있습니다:

bash
코드 복사
iface eth0 inet dhcp
정적으로 구성하려면 다음 단계를 따릅니다. 먼저, 인터페이스를 정적으로 정의합니다:

bash
코드 복사
iface eth1 inet static
그런 다음 IP 주소, 네트워크 마스크, 게이트웨이를 설정합니다:

bash
코드 복사
address 192.168.1.100
netmask 255.255.255.0
gateway 192.168.1.1
DNS 서버를 구성하려면 다음을 추가합니다:

bash
코드 복사
dns-nameservers 8.8.8.8 8.8.4.4
명령이나 스크립트를 실행하려면 post-up과 pre-up을 사용할 수 있습니다:

bash
코드 복사
post-up <command>
pre-up <command>
인터페이스를 비활성화하기 전에 명령을 실행하려면 pre-down을 사용하고, 비활성화한 후에는 post-down을 사용합니다:

bash
코드 복사
pre-down <command>
post-down <command>
4.2. 동적 구성
네트워크 인터페이스를 동적으로 구성하려면 /etc/network/interfaces 파일에 다음 두 줄을 추가합니다:

bash
코드 복사
auto eth0
iface eth0 inet dhcp
4.3. 정적 구성
정적 IP 주소를 설정하려면 다음과 같이 합니다:

bash
코드 복사
iface eth0 inet static
address 192.168.1.100
netmask 255.255.255.0
gateway 192.168.1.1
4.4. 네트워크 인터페이스 활성화 및 비활성화
네트워크 인터페이스를 수동으로 활성화하거나 비활성화하려면 ifup/ifdown 명령을 사용합니다. 예를 들어, eth0 인터페이스를 활성화하려면:

bash
코드 복사
$ sudo ifup eth0
비활성화하려면:

bash
코드 복사
$ sudo ifdown eth0
4.5. 전체 예제 구성
정적 구
4.5 전체 예제 구성
정적 구성을 단계별로 살펴보겠습니다.

먼저 텍스트 편집기를 사용하여 /etc/network/interfaces 파일을 엽니다:

bash
코드 복사
$ sudo vi /etc/network/interfaces
다음으로, 부팅 시 네트워크 인터페이스 eth0를 활성화하도록 설정합니다:

bash
코드 복사
auto eth0
eth0 인터페이스에 정적 IP 주소를 할당합니다. IP 주소, 네트워크 마스크, 게이트웨이를 설정합니다:

bash
코드 복사
iface eth0 inet static
address 192.168.1.100
netmask 255.255.255.0
gateway 192.168.1.1
DNS 서버를 추가합니다:

bash
코드 복사
dns-nameservers 8.8.8.8 8.8.4.4
인터페이스가 활성화되기 전에 실행할 스크립트를 추가합니다:

bash
코드 복사
pre-up /usr/local/sbin/start-iptables.sh
인터페이스가 비활성화된 후에 실행할 스크립트를 추가합니다:

bash
코드 복사
post-down /usr/local/sbin/backup-log.sh
전체 구성 예제는 다음과 같습니다:

bash
코드 복사
auto eth0
iface eth0 inet static
address 192.168.1.100
netmask 255.255.255.0
gateway 192.168.1.1
dns-nameservers 8.8.8.8 8.8.4.4
pre-up /usr/local/sbin/start-iptables.sh
post-down /usr/local/sbin/backup-log.sh
구성을 적용하려면 다음 명령어를 실행합니다:

bash
코드 복사
sudo ifdown eth0; sudo ifup eth0 5. /etc/network/interfaces 파일이 비어있는 이유
앞서 언급한 것처럼 리눅스 시스템에서는 네트워크 인터페이스를 구성하는 여러 가지 방법이 있습니다. 만약 /etc/network/interfaces 파일이 비어 있다면, 이는 시스템이 다른 도구를 사용해 네트워크를 관리하고 있음을 의미할 수 있습니다.

많은 배포판, 특히 데스크톱 설치의 경우, 네트워크 관리자가 네트워크를 관리합니다. 이 경우 구성 파일은 비어 있을 수 있습니다.

이러한 경우, /etc/network/interfaces 파일이 네트워크 관리자와 충돌하지 않도록 네트워크 관리자를 비활성화해야 합니다:

bash
코드 복사
$ sudo systemctl stop NetworkManager.service
$ sudo systemctl disable NetworkManager.service 6. 결론
이 문서에서는 네트워크 인터페이스가 무엇인지, 그 유형에 대해 알아보았습니다. 또한, 리눅스 시스템에서 /etc/network/interfaces 파일을 사용하여 네트워크를 설정하는 방법을 살펴보았습니다. 구문을 이해하고 동적 및 정적 설정을 구성하는 방법을 배웠으며, 완전한 예제를 통해 실제 설정 방법을 보았습니다. 다양한 네트워크 구성 방법이 있지만, 여기서는 하나의 방법을 중점적으로 다루었습니다.
