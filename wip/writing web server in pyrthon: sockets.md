writing web server in pyrthon: sockets

Python으로 간단한 웹 서버를 작성하는 방법에 대해 진행 중인 시리즈입니다. 얕은 튜토리얼은 아니지만, 컴퓨터가 네트워크를 통해 통신하는 방법과 서버가 일반적으로 요청(프로세스, 스레드, asyncio)을 처리하는 방법을 설명하기 위해 실습을 통해 학습합니다.

web server 란?
우선, 이것은 서버입니다(말장난 의도 없음). 서버는 클라이언트에게 서비스를 제공하는 프로세스입니다. 놀랍게도 서버는 하드웨어와 아무 관련이 없습니다.
이는 운영 체제에서 실행되는 일반적인 소프트웨어일 뿐입니다. 대부분의 다른 프로그램과 마찬가지로 서버는 입력에서 일부 데이터를 얻고 일부 비즈니스 논리에 따라 데이터를 변환한 다음 일부 출력 데이터를 생성합니다. 웹 서버의 경우 입력과 출력은 HTTP(Hypertext Transfer Protocol)를 통해 네트워크를 통해 발생합니다. 웹 서버의 경우 입력은 클라이언트(웹 브라우저, 모바일 애플리케이션, IoT 장치 또는 기타 웹 서비스)의 HTTP 요청으로 구성됩니다. 그리고 출력은 종종 HTML 페이지 형식의 HTTP 응답으로 구성되지만 다른 형식도 지원됩니다.

이 하이퍼텍스트 전송 프로토콜이란 무엇입니까? 글쎄, 이 시점에서는 이를 텍스트 기반(즉, 사람이 읽을 수 있는) 데이터 교환 프로토콜로 생각하면 충분합니다. 그리고 프로토콜이라는 단어는 데이터 전송 형식 및 규칙에 대한 둘 이상의 당사자 간의 일종의 관례로 설명될 수 있습니다. 걱정하지 마십시오. 나중에 HTTP에 대한 세부 사항을 다루는 기사가 있을 예정이며, 이 기사의 나머지 부분에서는 컴퓨터가 네트워크를 통해 임의의 데이터를 보내는 방법에 중점을 둘 것입니다.
Unix 계열 운영 체제에서는 I/O 장치를 파일로 취급하는 것이 매우 일반적입니다. 디스크의 일반 파일과 마찬가지로 컴퓨터 마우스, 프린터, 모뎀 등을 열고, 읽고/쓴 다음 닫을 수 있습니다.

열려 있는 모든 파일에 대해 운영 체제는 소위 파일 설명자를 생성합니다. 조금 단순화하면 파일 설명자는 프로세스 내 파일의 고유한 정수 식별자일 뿐입니다. 운영 체제는 파일 설명자를 인수로 받아들이는 파일을 조작하기 위해 일련의 함수 시스템 호출을 제공합니다. 다음은 read() 및 write() 작업에 대한 표준 예입니다.

```
// C-ish pseudocode

int fd = open("/path/to/my/file", ...);

char buffer[2048];
read(fd, buffer, 2048);
write(fd, "some data", 10);

close(fd);
```

네트워크 통신도 I/O의 한 형태이기 때문에 결국 파일 작업으로 귀결될 것으로 예상하는 것이 합리적입니다. 그리고 실제로 소켓이라고 불리는 특별한 종류의 파일이 있습니다.
소켓은 운영 체제에서 제공하는 또 다른 추상화 부분입니다. 컴퓨터 추상화에서 흔히 발생하는 것처럼 이 개념은 현실 세계, 특히 AC 전원 소켓에서 차용되었습니다. 한 쌍의 소켓을 사용하면 두 프로세스가 서로 통신할 수 있습니다. 특히 네트워크를 통해. 소켓을 열 수 있고, 소켓에 데이터를 쓰거나 소켓에서 읽을 수 있습니다. 물론 소켓이 더 이상 필요하지 않으면 닫아야 합니다.

소켓은 매우 다양하며 프로세스 간 통신에 소켓을 사용하는 방법도 많습니다. 예를 들어, 두 프로세스가 서로 다른 시스템에 있을 때 네트워크 소켓을 활용할 수 있습니다. 로컬 프로세스의 경우 Unix 도메인 소켓이 더 나은 선택일 수 있습니다. 하지만 이 두 종류의 소켓도 데이터그램(또는 UDP), 스트림(또는 TCP), 원시 소켓 등 서로 다른 유형일 수 있습니다. 이 다양성은 처음에는 복잡해 보일 수 있지만 운 좋게도 방법에 대한 다소 일반적인 접근 방식이 있습니다. 코드에서 모든 종류의 소켓을 사용합니다. 이러한 소켓 유형 중 하나를 프로그래밍하는 방법을 배우면 해당 지식을 다른 사람에게 추론할 수 있는 능력이 제공됩니다.

```C

int fd = socket(SOCK_TYPE_TCP);

sockaddr serv_addr = { /_ ... _/ };
connect(fd, serv_addr);

char buffer[2048];
read(fd, buffer, 2048);
write(fd, "some data", 10);

close(fd);
```

이 기사에서는 TCP/IP 프로토콜 스택을 사용하여 네트워크 소켓을 통한 클라이언트-서버 통신 형태에 중점을 둘 것입니다. 분명히 이것은 특히 브라우저가 웹 사이트에 액세스하는 데 사용하기 때문에 오늘날 가장 널리 사용되는 형식입니다.

프로그램이 네트워크를 통해 통신하는 방법
네트워크를 통해 비교적 긴 텍스트를 전송하려는 애플리케이션이 있다고 상상해 보십시오. 소켓이 이미 열려 있고 프로그램이 이 데이터를 소켓에 쓰려고(또는 네트워킹 용어로 전송하려고) 한다고 가정해 보겠습니다. 이 데이터는 어떻게 전송되나요?

컴퓨터는 별개의 세계에 살고 있습니다. 네트워크 인터페이스 카드(NIC)는 한 번에 수백 바이트의 작은 부분으로 데이터를 전송합니다. 동시에 일반적으로 프로그램이 전송하려는 데이터의 크기는 제한이 없으며 수백 기가바이트를 초과할 수 있습니다. 네트워크를 통해 임의의 큰 데이터 조각을 전송하려면 데이터를 청크로 나누어 모든 청크를 별도로 전송해야 합니다. 논리적으로 청크 최대 크기는 네트워크 어댑터의 제한을 초과해서는 안 됩니다.

각 청크는 제어 정보와 페이로드라는 두 부분으로 구성됩니다. 제어 정보에는 소스 및 대상 주소, 청크 크기, 체크섬 등이 포함됩니다. 페이로드는 프로그램이 전송하려는 실제 데이터입니다.

대개 네트워크의 컴퓨터에 주소를 지정하기 위해 소위 IP 주소가 할당됩니다. IP라는 약어는 인터넷 프로토콜(Internet Protocol)의 약자로, 인터넷을 탄생시키면서 네트워크의 상호 연결을 가능하게 한 유명한 프로토콜입니다. 인터넷 프로토콜은 주로 다음 세 가지를 담당합니다.

호스트 인터페이스 주소 지정;
페이로드 데이터를 패킷으로 캡슐화하는 것(즉, 앞서 언급한 청킹);
하나 이상의 IP 네트워크를 통해 소스에서 대상으로 패킷을 라우팅합니다.

    청킹 문제의 의도적인 단순화에 대한 면책조항.
    IP는 소위 인터넷 프로토콜 제품군의 레이어 3 프로토콜입니다. 제품군의 프로토콜은 모든 상위 계층 프로토콜이 그 아래 프로토콜을 기반으로 하는 스택을 형성합니다. 즉. IP의 경우 레이어 2 또는 링크 레이어 프로토콜(예: 이더넷 또는 느슨하게 말하면 Wi-Fi)이 있어야 합니다. 링크 계층 프로토콜은 하위 수준 데이터 전송 세부 사항에 중점을 두고 해당 범위는 근거리 통신망(LAN) 통신(즉, 라우팅 인식 없음)에 의해 제한됩니다. 사실 청킹(또는 네트워킹 용어로 프레이밍)은 해당 수준에서도 발생합니다. IP는 이러한 제한 사항을 인식하고 있으므로 패킷을 레이어 2 프레임에 맞을 만큼 작게 만듭니다. 왜냐하면 결국 전송 단위는 IP 패킷 자체가 아닌 프레임이 되기 때문입니다. 중요하기는 하지만 이러한 세부 사항은 이 기사와 관련이 없습니다.

IP 패킷은 출발지에서 목적지로 이동하는 동안 일반적으로 소수의 중간 호스트를 통과합니다. 이 일련의 호스트가 경로를 구성합니다. 임의의(출발지, 목적지) 쌍에 대해 둘 이상의 경로가 있을 수 있으며 일반적으로 그렇습니다. 그리고 여러 경로가 동시에 가능하기 때문에 동일한(원본, 대상) 쌍을 가진 IP 패킷이 다른 경로를 사용하는 것은 전혀 문제가 없습니다. 네트워크를 통해 긴 텍스트를 보내는 문제로 돌아가면, 텍스트가 분할된 IP 패킷과 같은 청크가 대상 호스트로 가는 도중에 다른 경로를 택하는 일이 발생할 수 있습니다. 그러나 노선에 따라 지연 시간이 다를 수 있습니다. 게다가 중간 호스트나 링크 모두 완전히 신뢰할 수 없기 때문에 항상 패킷 손실 가능성이 있습니다. 따라서 IP 패킷은 변경된 순서로 대상에 도착할 수 있습니다.

일반적으로 모든 사용 사례에 엄격한 패킷 순서가 필요한 것은 아닙니다. 예를 들어, 음성 및 비디오 트래픽은 패킷 재전송으로 인해 허용할 수 없는 대기 시간 증가가 발생하므로 어느 정도의 패킷 손실을 허용하도록 설계되었습니다. 그러나 브라우저가 HTTP를 사용하여 웹 페이지를 로드할 때 페이지의 문자와 단어는 페이지 작성자가 의도한 것과 정확히 같은 방식으로 정렬될 것으로 예상됩니다. 이것이 바로 신뢰할 수 있고 순서가 있으며 오류가 확인된 패킷 전달 메커니즘에 대한 필요성이 대두되는 이유입니다.

이미 알고 있듯이 네트워킹 도메인의 문제는 점점 더 많은 프로토콜을 도입함으로써 해결되는 경향이 있습니다. 실제로 전송 제어 프로토콜(Transmission Control Protocol) 또는 간단히 TCP라고 하는 또 다른 유명한 인터넷 프로토콜이 있습니다.

TCP는 기본 프로토콜인 IP를 기반으로 합니다. TCP의 주요 목표는 애플리케이션 간에 바이트 스트림을 안정적이고 순서대로 전달하는 것입니다. 따라서 (인코딩된) 텍스트를 한 시스템의 TCP 소켓에 공급하면 대상 시스템의 소켓에서 변경 없이 읽을 수 있습니다. 패킷 전달 문제를 걱정하지 않기 위해 HTTP는 TCP의 기능에 의존합니다.

순서대로 신뢰할 수 있는 전달을 달성하기 위해 TCP는 자동 증가 시퀀스 번호와 체크섬을 사용하여 모든 청크의 제어 정보를 늘립니다. 수신 측에서는 패킷 도착 순서가 아닌 TCP 시퀀스 번호를 기반으로 데이터 재조립이 발생합니다. 또한 체크섬은 도착하는 청크의 내용을 검증하는 데 사용됩니다. 잘못된 청크는 단순히 거부되고 승인되지 않습니다. 송신 측은 확인되지 않은 청크를 재전송할 것으로 예상됩니다. 분명히 이를 구현하려면 양쪽에 일종의 버퍼링이 필요합니다.

특정 시간에 단일 시스템에는 TCP 소켓을 통해 통신하는 많은 프로세스가 있을 수 있습니다. 따라서 통신 세션 수만큼 독립적인 시퀀스 번호와 버퍼가 있어야 합니다. 이를 해결하기 위해 TCP는 연결이라는 개념을 도입합니다. 조금 단순화하면 TCP 연결은 초기 시퀀스 번호와 송신측과 수신측 간의 일종의 합의입니다. 현재 전송 상태입니다. 연결이 설정되어야 하고(처음에 몇 개의 제어 패킷을 교환함으로써, 소위 핸드셰이크를 통해), 유지되어야 합니다(일부 패킷은 양방향으로 전송되어야 합니다. 그렇지 않으면 연결 시간이 초과될 수 있습니다(소위 연결 유지라고 함)). 연결이 더 이상 필요하지 않으면 연결을 닫아야 합니다(몇 가지 다른 제어 패킷을 교환하여).

마지막으로 중요한 것은... IP 주소는 네트워크 호스트를 전체적으로 정의합니다. 그러나 두 호스트 사이에는 동시 TCP 연결이 많이 있을 수 있습니다. 청크의 유일한 주소 지정 정보가 IP 주소라면 청크와 연결의 관계를 결정하는 것이 사실상 불가능합니다. 따라서 몇 가지 추가 주소 지정 정보가 필요합니다. 이를 위해 TCP는 포트 개념을 도입합니다. 모든 연결은 IP 쌍 사이의 TCP 연결을 고유하게 식별하는 포트 번호 쌍(발신자용 하나, 수신자용 하나)을 얻습니다. 따라서 모든 TCP 연결은 다음을 통해 완전히 식별될 수 있습니다. 다음 튜플: (소스 IP, 소스 포트, 대상 IP, 대상 포트)

간단한 tcp 서버 구현
tcp서버 파이썬으로 만들자.
standard library socket 모듈
초보자에게 소켓의 주요 합병증은 소켓이 작동하도록 준비하는 명백한 마법의 의식이 존재한다는 것입니다.
그러나 이 기사 시작 부분의 이론적 배경과 이 섹션의 실습 부분을 결합하면 마법이 의미 있는 일련의 동작으로 바뀔 것입니다.
TCP의 경우 서버측과 클라이언트측 소켓 워크플로가 다릅니다. 서버는 클라이언트가 연결될 때까지 수동적으로 기다립니다. 선험적으로 서버의 IP 주소와 TCP 포트는 모든 잠재 클라이언트에게 알려져 있습니다. 반대로, 서버는 클라이언트가 연결되는 순간까지 클라이언트의 주소를 알지 못합니다. 즉, 클라이언트는 서버에 적극적으로 연결하여 통신 개시자 역할을 합니다.

그러나 그것보다 더 많은 것이 있습니다. 서버 측에는 실제로 두 가지 유형의 소켓이 관련되어 있습니다. 앞서 언급한 연결을 기다리는 서버 소켓과 놀랍게도 클라이언트 소켓입니다! 설정된 모든 연결에 대해 서버 측에 클라이언트 측 대응과 대칭적인 소켓이 하나 더 생성됩니다. 따라서 N 연결된 클라이언트의 경우 서버 측에는 항상 N+1 소켓이 있습니다.

서버 TCP 소켓 생성
이제 서버 소켓을 만들어 보겠습니다.

```python

import socket

serv_sock = socket.socket(
    socket.AF_INET,      # set protocol family to 'Internet' (INET)
    socket.SOCK_STREAM,  # set socket type to 'stream' (i.e. TCP)
    proto=0              # set the default protocol (for TCP it's IP)
)

print(type(serv_sock))   # <class 'socket.socket'>
```

잠깐만요... 약속된 int fd = open("/path/to/my/socket")은 어디 있을까요? 사실 시스템 호출 open()은 프로토콜 패밀리, 소켓 유형 등과 같이 필요한 모든 매개변수를 전달할 수 없기 때문에 소켓 사용 사례에는 너무 제한적입니다. 따라서 소켓의 경우 전용 시스템 호출인 socket()이 도입되었습니다. open()과 마찬가지로 통신을 위한 엔드포인트를 생성한 후 해당 엔드포인트를 참조하는 파일 설명자를 반환합니다. 누락된 fd = ... 부분에서 알 수 있듯이 Python은 객체 지향 언어입니다. 함수 대신 클래스와 메서드를 사용하는 경향이 있습니다. 파이썬 표준 라이브러리의 소켓 모듈은 실제로 소켓 관련 호출 집합을 둘러싼 얇은 OO 래퍼입니다. 지나치게 단순화하면 이렇게 생각할 수 있습니다:

```
class socket:  # Yep, the name of the class starts from a lowercase letter...
    def __init__(self, sock_family, sock_type, proto):
        self._fd = system_socket(sock_family, sock_type, proto)

    def write(self, data):
        system_write(self._fd, data)

    def fileno(self):
        return self._fd
```

즉, 누군가 정말로 필요한 경우 정수 파일 설명은 다음과 같이 얻을 수 있습니다.
print(serv_sock.fileno()) # 3 or some other small integer

서버 소켓을 네트워크 인터페이스에 바인딩
일반적으로 단일 서버 시스템에는 둘 이상의 네트워크 어댑터가 있을 수 있으므로 이 인터페이스의 로컬 주소를 소켓에 할당하여 서버 소켓을 특정 인터페이스에 바인딩하는 방법이 있어야 합니다.

```
# Use '127.0.0.1' to bind to localhost
# Use '0.0.0.0' or '' to bind to ALL network interfaces simultaneously
# Use an actual IP of an interface to bind to a specific address.

serv_sock.bind(('127.0.0.1', 6543))
```

게다가, 바인딩()에는 포트를 지정해야 합니다. 서버는 기다리고 있거나 네트워킹 용어로 말하면 해당 포트에서 클라이언트 연결을 수신합니다.

클라이언트 연결을 기다립니다.
다음으로 소켓을 명시적으로 수신 대기 상태로 전환해야 합니다.

```
backlog = 10  # the max number of queued connections
serv_sock.listen(backlog)
```

이 호출 후에 운영 체제는 서버 소켓이 들어오는 연결을 수락할 수 있도록 준비합니다. 하지만 승인 부분으로 넘어가기 전에 백로그 매개변수에 대해 간단히 살펴보겠습니다.

우리가 이미 알고 있듯이 네트워크 통신은 개별 패킷 전송을 통해 이루어지지만 TCP는 설정된 스트림과 같은 연결에 의존합니다. 그렇다면 TCP 연결을 설정한다는 것은 실제로 무엇을 의미합니까? 이를 위해 클라이언트와 서버는 향후 연결 매개변수를 협상하는 몇 가지 제어(즉, 비즈니스 데이터 없이) 패킷을 교환해야 합니다. 이러한 매개변수를 준수하는 모든 향후 패킷은 동일한 논리 스트림, 즉 연결에 속하게 됩니다. 이 절차를 핸드셰이크라고 합니다.

우리 프로그램에서는 핸드셰이크와 같은 TCP 프로토콜의 하위 수준 세부 사항을 거의 다루지 않습니다. 대신, 우리는 일반적으로 이미 확립된 연결 측면에서 작동합니다. 그러나 0이 아닌 네트워크 지연으로 인해 핸드셰이크 절차는 상당히 비쌀 수 있습니다. 따라서 OS는 일반적으로 이를 최적화하려고 시도하며 프로그램이 현재 클라이언트에 서비스를 제공하는 동안 OS는 백그라운드에서 계속해서 새로운 수신 연결을 설정하여 일부 내부 데이터 구조에 대기시킵니다.

backlog 매개변수는 설정되었지만 아직 수락되지 않은 연결의 대기열 크기를 정의합니다. 연결되었지만 아직 서비스를 제공받지 못한 클라이언트 수가 백로그 크기보다 작아질 때까지 운영 체제는 백그라운드에서 새 연결을 설정합니다. 그러나 이러한 연결 수가 백로그 크기에 도달하면 모든 새로운 연결 시도가 명시적으로 거부되거나 암시적으로 무시됩니다(OS 구성에 따라 다름).

클라이언트 연결 수락
백로그 큐에서 설정된 연결을 얻으려면 다음을 수행해야 합니다.

client_sock, client_addr = serv_sock.accept()

그러나 설정된 연결의 대기열은 비어 있을 수 있습니다. 이러한 경우 accept() 호출은 다음 클라이언트가 연결될 때까지 프로그램 실행을 차단합니다(또는 프로그램이 신호에 의해 중단되지만 이 기사에서는 주제에서 벗어납니다).

첫 번째 클라이언트 연결을 수락하면 서버 측에 두 개의 소켓이 있게 됩니다. 이미 익숙한 LISTEN 상태의 serv_sock과 ESTABLISHED 상태의 새 client_sock입니다. 흥미롭게도 서버 측의 client_sock과 클라이언트 측의 해당 소켓은 소위 피어 엔드포인트입니다. 즉. 그들은 같은 종류이고, 데이터를 쓰거나 읽을 수 있으며, 둘 다 close() 호출을 사용하여 연결을 효율적으로 종료하여 닫을 수 있습니다. 이러한 작업 중 어느 것도 청취 serv_socket에 영향을 미치지 않습니다.

클라이언트 소켓 IP 및 포트 가져오기
서버와 클라이언트 피어 엔드포인트 주소를 살펴보겠습니다. 모든 TCP 소켓은 (로컬 IP, 로컬 포트)와 (원격 IP, 원격 포트)의 두 쌍의 숫자로 식별할 수 있습니다.

새로 연결된 클라이언트의 원격 IP와 포트를 알아내기 위해 서버는 성공적인 accept() 호출에서 반환된 client_addr 변수를 검사할 수 있습니다.
print(client_addr) # E.g. ('127.0.0.1', 54614)

또는 서버 측 피어 엔드포인트 client_sock의 소켓.getpeername() 메소드를 사용하여 연결된 클라이언트의 원격 주소를 학습할 수 있습니다. 그리고 서버 운영 체제가 서버 측 피어 끝점에 할당한 로컬 주소를 알아내려면 소켓.getsockname() 메서드를 사용할 수 있습니다.

우리 서버의 경우 다음과 같이 보일 수 있습니다.

serv_sock:
laddr (ip=<server_ip>, port=6543)
raddr (ip=0.0.0.0, port=\*)

client_sock: # peer
laddr (ip=<client_ip>, port=51573) # 51573 is a random port assigned by the OS
raddr (ip=<server_ip>, port=6543) # it's a server's listening port

소켓을 통해 데이터 보내기 및 받기
다음은 클라이언트로부터 일부 데이터를 수신한 다음 이를 다시 보내는 간단한 예입니다(소위 에코 서버).

```
    # echo-server

    data = client_sock.recv(2048)
    client_sock.send(data)
```

그렇다면 약속된 read() 및 write() 호출은 어디에 있습니까? 소켓() 시스템 호출과 마찬가지로 소켓 파일 설명자와 함께 이 두 호출을 사용할 수 있지만 잠재적으로 필요한 모든 옵션을 지정할 수는 없습니다. 따라서 소켓의 경우 send() 및 recv() 시스템 호출이 도입되었습니다. 남자 2로부터 다음을 보내세요:
send()와 write()의 유일한 차이점은 플래그가 있다는 것입니다. 플래그 인수가 0인 경우 send()는 write()와 동일합니다.

...그리고 남자 2 수신:

Recv()와 read()의 유일한 차이점은 플래그가 있다는 것입니다. 플래그 인수가 0인 경우, recv()는 일반적으로 read()와 동일합니다.

위 코드의 단순함 뒤에는 심각한 문제가 있습니다. recv() 및 send() 호출은 실제로 소위 네트워크 버퍼를 통해 작동합니다. Recv()에 대한 호출은 수신 측의 버퍼에 일부 데이터가 나타나는 즉시 반환됩니다. 물론 일부가 모든 것을 의미하는 경우는 거의 없습니다. 따라서 클라이언트가 1800바이트의 데이터를 전송하려는 경우 전송이 두 부분으로 나누어졌기 때문에 처음 1500바이트가 수신되자마자 recv()가 반환될 수 있습니다(이 예에서는 숫자는 임의적임).

send() 메소드에 대해서도 마찬가지입니다. 버퍼에 기록된 실제 바이트 수를 반환합니다. 그러나 버퍼에 시도한 데이터 조각보다 사용 가능한 공간이 적은 경우 해당 데이터의 일부만 기록됩니다. 따라서 나머지 데이터가 결국 전송될 것인지 확인하는 것은 보낸 사람의 몫입니다. 전송됩니다. 운 좋게도 Python은 내부적으로 전송 루프를 수행하는 편리한 소켓.sendall() 도우미를 제공합니다.

이는 실제로 TCP를 통한 데이터 교환을 설계할 때 흥미로운 고려 사항으로 이어집니다.

메시지는 길이가 고정되거나(으악), 구분되어 있거나(어깨를 으쓱), 길이를 표시하거나(훨씬 더 좋음), 연결을 종료하여 끝나야 합니다.

클라이언트 감지가 전송 완료됨(종료)
처음 세 가지 옵션은 여전히 서버 측의 소켓이 recv() 호출을 무한정 기다리는 상황을 초래할 수 있다는 점에 유의하세요. 서버는 클라이언트로부터 K개의 메시지를 수신하고 싶은데 클라이언트는 M개의 메시지만 보내고 싶어하는 경우(M < K), 따라서 통신 규칙을 결정하는 것은 상위 프로토콜 설계자의 몫입니다. 하지만 클라이언트의 전송이 끝났음을 나타내는 간단한 방법이 있습니다. 클라이언트 소켓은 SHUT_WR을 지정하여 연결을 종료(어떻게)할 수 있습니다. 그러면 서버 측에서 recv() 호출이 0 바이트를 반환하게 됩니다. 따라서 수신 코드를 다음과 같이 다시 작성할 수 있습니다:

```
chunks = []
while True:
    data = client_sock.recv(2048)
    if not data:
        break
    chunks.append(data)

```

소켓닫기
소켓 작업이 끝나면 소켓을 닫아야 합니다.
socket.close()
소켓을 명시적으로 닫으면 해당 버퍼가 플러시되고 연결이 정상적으로 종료됩니다.

간단한 TCP 서버 예
마지막으로 TCP 에코 서버의 전체 코드는 다음과 같습니다.

````python

import socket

# Create server socket.
serv_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM, proto=0)

# Bind server socket to loopback network interface.
serv_sock.bind(('127.0.0.1', 6543))

# Turn server socket into listening mode.
serv_sock.listen(10)

while True:
    # Accept new connections in an infinite loop.
    client_sock, client_addr = serv_sock.accept()
    print('New connection from', client_addr)

    chunks = []
    while True:
        # Keep reading while the client is writing.
        data = client_sock.recv(2048)
        if not data:
            # Client is done with sending.
            break
        chunks.append(data)

    client_sock.sendall(b''.join(chunks))
    client_sock.close()
```
server.py에 저장하고 python3 server.py를 통해 실행합니다.

간단한 TCP 클라이언트 구현
클라이언트 측에서는 상황이 훨씬 간단합니다. 클라이언트 측에는 청취 소켓과 같은 것이 없습니다. 데이터를 보내기 전에 단일 소켓 끝점을 만들고 이를 서버에 연결()하면 됩니다.


```python

import socket

# Create client socket.
client_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Connect to server (replace 127.0.0.1 with the real server IP).
client_sock.connect(('127.0.0.1', 6543))

# Send some data to server.
client_sock.sendall(b'Hello, world')
client_sock.shutdown(socket.SHUT_WR)

# Receive some data back.
chunks = []
while True:
    data = client_sock.recv(2048)
    if not data:
        break
    chunks.append(data)
print('Received', repr(b''.join(chunks)))

# Disconnect from server.
client_sock.close()

````

client.py에 저장하고 python3 client.py를 통해 실행합니다.

소켓 서버와 HTTP 서버
위에서 구현한 서버는 분명히 단순한 TCP 서버였습니다. 그러나 아직은 웹 서버가 아닙니다. (거의?) 모든 웹 서버는 TCP 서버이지만, 물론 모든 TCP 서버가 웹 서버는 아닙니다. 이 서버를 웹 서버로 바꾸려면 HTTP를 처리하는 방법을 가르쳐야 합니다. 즉. 소켓을 통해 전송되는 데이터는 Hypertext Transfer Protocol에서 정의한 규칙 집합에 따라 형식이 지정되어야 하며 코드는 이를 구문 분석하는 방법을 알아야 합니다.

마무리
내용을 이해하지 못한 채 암기하는 것은 개발자에게 좋지 않은 전략입니다. 소켓 프로그래밍은 이론적 배경 없이 코드를 보는 것이 부담스러울 수 있는 완벽한 예입니다. 그러나 일단 움직이는 부분과 제약 조건을 이해하면 소켓 API를 사용한 이러한 모든 마술적 조작이 의미 있는 작업 세트로 전환됩니다. 그리고 기본 사항에 시간을 보내는 것을 두려워하지 마십시오. 네트워크 프로그래밍은 기본 지식입니다. 고급 웹 서비스의 성공적인 개발과 문제 해결에 필수적입니다.

> https://iximiuz.com/en/posts/writing-web-server-in-python-sockets
