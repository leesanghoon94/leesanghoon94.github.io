transport layer

network laterㅇ 해결하지 못한 문제
한번에 하나의 통신만 가능
즉여러 어플리케이션이 동시에 통신 불가능
패킷의 순서 보장 어렵다.유실에대한 대응불가능

그래서 transport Layer가 나옴

통신주체끼리 데이터 전달의 신뢰성을 확보하는 방법을 정의
주요단위 세그먼트
주요 구성요소 Tcp/udp
주요 특징
network layer로 성립된 통신 위에서 실질적인 활용을 위한 다양한 기능을 정의
패킷의 순서 보장 에러 처리 포트 기반 분할등

Transmission control protocol tcp
패킷의 전달 과정에서 순서를 보장하고 유실되지 않도록 보장할수있는 통신규약
패킷 안에 세그먼트를 담아 주고 받아서 로직을 처리
연결 지향
즉 지속적으로 채널을 수립하여 전달 여부를 확인하고 무결성을 확인
지속적으로 무결성을 확보하는 과정에서 비교적 느리고 복잡한 과정 필요
주요 사용사례
webpage http/https
email
파일 전송
ssh 등

tcp는 느림

세그머트 Segment
Tcp/udp의 데이터 전달 단위  
 tcp 세그먼트의 주요구성  
 Port source/destination  
 sequence/acknowledgement number 통신 주체끼리 데이터를 주고 받았는지 확인에 사용  
 flags segment의 목적 등을 정의 ack,syn,fin  
 window size 세그먼트를 만든 주체가 얼마나 많은 데이터를 받을지 전달  
 urgent pointer 세그먼트의 중요도를 설정 (먼저처리해야하는세그먼트등)
기타 checksum

tcp segment
tcp header port target port sequence number acknowle

port
ip프로토콜에서 패킷을 올바른 프로세스로 라우팅 하기위한 논리적 단위
Tcp port/udp port로 구분
각각 0~65535 까지 정수 범위
Wellknown port 주로 서버에서 사용하는 어플리케이션/프로토콜 별로 미리 지젖ㅇ된 포트
주요사용에 따라 표준으로 공통적으로 사용

ephemeral port 임시포트 클라이언트에서 사용하는 표트로 연결할때마다 임의로 지정

Tcp handshake
tcp protocol에서 통신을 수립하고 서로를 인식하는 첫 과정
synchronize 첫요청으로 사용할 첫 클라이언트 sequence number cs를 전달
syn-ack(synchronize-acknowledge) syn에 대한 응답으로 cs+1과 서버 sequence number ss를 전달
ack acknowledge 마지막 단계로 연결이 수립되엇음을 알려주며 cs+1과 ss+1를을 전달

user datagram protocol udp
빠르고 간단하게 데이터를 주고 받을 수 있는 방법을 정의
connectionless
연결지향과는 달리 데이터의 무결성, 순서, 전달 여부를 체크 하지 않음
즉 패킷이 순서댈 오지 않거나 중복디거나 아예 전달되지 않을 수 있음
빠르고 간단

udp segment
주요 프로토콜 tcp udp
tcp
http/https: tcp/80,443
ftp file transfer protocol tcp /20,21
ssh secure shell tcp /22
dns domain name system tcp/53
udp
dns domain name system uudp /53
dhcp dynamic host configuratioon protocol udp /67,68
voip voice over ip udp /5060
