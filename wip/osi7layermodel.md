## osi 7 layer model

컴퓨네트워크 및ㅌ옷니을 7개의 레어계층으

application
presentaintion
session
tansport
network
datalink
physical

장치를 연결하기 위한 매체의 물리적인 사항을 정의 전압주기시간전선의규격거리등두요단위 bits
wofo
bluetooth
광섬유

hub
physical layer단위에
데이터

physical layer에서 해결하지 못하는문제
충돌
broadcast만가능 대상을지정해서 전달

data link layer
물리적인 통신ㅇ르 제어하여 디바이스와 디바이스간의 통신 및 전송을 안정화 하기위한 프로토콜
주요단위 FRAME
주요 구성요소
MAC ADdress switch
w주요특징
csma/cd 방식을 활용해서 각디바이스간

mac(media access control) address
mac address
네트워크 인터페이스에 부여된 고유의 주소
데이터가 지정한 대상에게 잘 전달 될 수 있도록 대상 식별에 사용
2개의 hexadecimal단위로 6rofmf skduf 48bits=6bytes
두파트로 구분
처 3개의 bytes는 oui 제조사에 부여된 고유 ㅣㄱ별자
나머지 3개의 bye는 nic 네트워크 인터페이스 별 고유 번호
네트워크 인터페이스의 MAcaddress는 고유의 값이며 변하지 않음
Ip는 변동

switch(l2)
ㅇ
data link layer 해결하지 못한문제
외부통신이 안됨
로컬 네트워크 외부로 통신 불가능

---

network layer해결하지 못한 문제
한번에 하나의 통신만 가능

---

local network
network layer
여러노드의 경로를 찾고 올바르게 전달할수이는수단을 정의
주요단위 패킷
주요구성요소
router,ip,arp
주요특징
서로 떨어진 local network간의 통신응ㄹ 지원
network간의 -> INTER NETWORK -> INTERNET
중간중간 노드를 걸처 목적지까지 도달할수있는 방법을 지원

---

ip internet protocol address
internet protocol 상에서 통신을 주체를 식별하기 위한 아이디
ipv4 32 bitys 2^32 약 43억개
아이피를 최대로 활용하기 위해 사설아이피와 공인 아이피로 분류
ipv6 128bits 2^128
따라서 사설아이피 개념이 불필요함

mac address

classless inter domain routing cidr
classless inter domain routing
ip는 주소의 영역을 여러 네트워크 영격으로 나누기 위해 ip를 묶는 방식
여러개의 사설망을 구축하기 위해 망을 나누는 방법
cidr notation
ip주소의 집합
네트워크 주소와 호스트 주소로 구성
각호스트 주소 숫자 만큼의 아이피를 가진 네트워크 망형성가능
a.b.c.d./e 형식
10.0.1.0/24
172.16.0.0/12
198.168.0.0/16
네트워크 주소+호스트 주소 표시
0~32 네트워크 주소가 몇bits인지 표시
cidr block
호스트 주소 비트만큼 ip 주소를 보유 가능
192.168.2.0/24
네트워크 비트 24
호스트 주소 32-24 =8
즉 2^8 256개의 주소 보유
192.168.2.0 ~ 192.168.2.255

---

서브넷마스크
어느부분이 호스트비트인지,어느부분이 네트워크비트인지 구분해주는 마슽크
and연산을 활용해 네트ㅋ워크 주소를 필터링
adn연산 두비트중 둘다 1일때만 1
1 and 1 = 1 , 0and 1 =0, 1and=0
네트워크 비트 수만큼 1을 보유한 마스크를 ip에 적용하면 네트워크 비트만 추출 가능

---

라우터
네트ㅝ크간에 패킷을 주고 받는 layer 3장치
ip대역별 최적경로를수집및 관리
어떤 경로의 노드를 경유해야 가장 효율적으로 대상에 도착하는지 알고있음 라우터 테이블
이경로를 바탕으로 특정 ip 주소가 대상인 패킷의 전달을 요청받을때 해당경로로 요청
로컬네트워크는 자신의 로컬 네트워크가 주소가 아니라면 라우터로 전달
확인방법 네트워크 주소가 같은지 확인 서브넷마스크등
이후 라우터는 패킷을 frame안에 넣어서 최적 경로에 따른 다른 라우터로 전달
ip주소에따른 맥어드레스확인방법 arp

---

arp address rosolution protocol
아이프로 맥어드레스를 찾는 프로토콜
순서
broadcast(mac address ff:ff:ff:ff:ff:ff)로 ip 요청
응답받은 ip mac address를 기반으로 mac확정 후 테이블에 저장

---

network layer해결하지못한문제
한번에 하나의 통신만가능
즉여러 에플리케이션이 동시에 통신 불가능
패킷등의 순서보장 /유실에 대한 보장 x
