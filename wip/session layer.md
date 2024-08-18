session layer
토ㅇ신 주체끼리 연결이 유지 할 수 있는 방법을 정의
예ㄴ의 컴퓨팅 환경에서 layer 1,2,3,4,이외의 차원에서 지속적인 연결이 수립될수있는 방법을 제공
예: mac address(2)와 ip(3)주소와 포트 (4)동일한 상황에서 어떻게 유저를 구분할 것인가?
현대에서도 마찬가지로 layer 4 이상의 추가적인 차원에서 지속적인 연결(세션)을 수립할 수 있는 방법을 포함
예: http cookie 정보를 모와서 브라우저와 유저가 주고받는 정보
몇몇 프로토콜의 경우 session layer 자체를 구현하지 않음
예: ftp 프로토콜

presentation layer
받은 데이터를 해석하는 방법을 정의
파싱압축해제 복호화등 application layer에서 사용할수있는 형식으로 변경

application layer
실제 받은 데이터를 어떻게 처리할지 방법을 정의
말그래도 데이터를 가지고 무엇을 어떻게 처리할지에 관한 레이어
예: http의 경우
method(get//post/put/delete/head/option/patch)
status code
header
host
user-agent
authoriztions
accept-encoding
content-type

---

dns란?
dns 주요 개념
dns domain name service 사람이 읽을수 있는 문자열과 internet protocol 기반 정보를 매칭 시켜주는 시스템
internet corporation for assigned names and numbers(icann)에서 관리
도메인 대상의 ip주소등의 정보와 맵핑되는 사람이 알아볼 수 있는 문자열
서브 도메인: 도메인 중 스트링 앞에 추가 문자열이 붙은 도메인
예: text.example.com
APEX 도메인 (Zone Apex,Root Domain): 도메인 중 앞에 추가 문자열이 없는 순수한 최상위 도메인
예: example.com
레코드(DNS Record): 도메인이 어떤 방식으로 데이터와 매칭되는지 정의하는 기록
다양한 레코드 종류가 있으면 각각 다른 정보와 매칭
예: A레코드는 IPv4주소ㅓ, MX 레코드는 메일 서버

dns 주요개념
domain zone : 도메인의 정보를 담은 레코드의 집합
zone file: domain zone 정보를 저장한 텍스트 파일
dns query: 주어진 도메인에 해당하는 정보를 요청하는 쿼리
name Server(NS): DNS query 를 zone file 기반으로 응답할수있는 서버
authoritative: dns 원본을 가지고 있는 가장 최상위 ns server
none-authoritaative: authoriataive ns 서버를 조회하여 정보를 보관 하고 있거나 응답하는 서버(캐쉬)
dns resolver: 사용자와 ns 서버 사이에 위치한 서버로 실제 유저의 요청에 따라 ip주소 등의 정보를 확보하는 서버
유저의 클라이언트가 제일 먼저 쿼리를 요청하는 대상이며 보통 isp가 관리

    dns의 규모
    2024 7월 현재 약 3억 6천만개의 도메인 존재
    그리고 거의 모든 http통신에 매번 활용
    매우 큰규모이며 이를 호스팅하기 위한 서버 구조에 큰 고민 필요

    dns의 구성
    dns는 계층 구조
        즉 초상위 도메인부터 차례대로 계층구조로 구성되어 있음
        실제 레코드는 가장 마지막 계층에서 보관 및 처리

        도메인의구조
        one.two.kr.{}
        1.{} dns root
        2. kr top level domain
        3. two domain
        4. one subdomain

    DNS ROOT
    dns 계층 구조의 최상위 레벨
    즉 dns query 수행 시 최초로 조회하는 거점
    다음 단계인 tlds(top level domain)의 zone file을 가진 ns 서버의 주소 정보 보유
    iana(internet assigned numbers authority)에서 조율하는 13개의 주체에서 관리
    a~m까지 각 관리 주체별로 다른 서버 주소
    root hints file
    dns root 의 주소를 담은 파일
    각 dns resolver에 하드 코딩

            top level domains
            dns 계층 구조의 두번째 레벨
            실질적으로 정보를 가지고 있는 최상위 레벨
            예: .com , .org, .net, .info
            종류:
                country code tlds: 각 나라에 할당된 두 자리 코드
                    예: .kr, .jp, .uk, .ai
                sporsored tlds: 사설 조직이나 기관에 할당된 tlds
                    예: .edu, .gov, .mil 등
                new generic tlds: 기타 다양한 tlds
                    예: .app, .tech, .xyz ,.blog

            관리 주체 : tlds registry (각ㄱ 회사.나라등)
                예: .com/ .net -> verisign
                    .org -> public interest registry
                    .kr -> korea internet $ security agency (KISA)
            실제 도메인의 레코드를 관리하는 ns서버의 주소정보를 담은 zonefile 보유


    ns서버
    실제 도메인의 레코드를 가지고 있는 서버
        이 ns서버의 주소를 tlds에 등록해두면 클라이언트에서 dns 쿼리에 따라 이쪽으로 도착
        해당 도메인 및 서브도메인들이 어떤 프로토콜의 어떤 주소로 맵핑되는지 레코드에 관한 zonefile 보유
        여기서 최종으로 맵핑된 주소확보

도메인 등록
도메인등록대행을 통해 등록
도메인등록대행 icann에게 인증받고 tlds registry와 협의하여 도메인 등록의 권한을 가진 주체
예: 가비아, godaddy, cafe24, aws route53등
등록할때 tlds registry 에 자신이 원하는 ns 서버 주소를 등록
읽종의 남은 슬롯에 자신의 ns 서버를 예치하는 개념
ns서버는 자신의 개인 ns서버를 사용하거나, dns hosting service업체에서 대여 가능
dns hosting service : dns 기능을 제공하는 주체
예: 가비아, aws route53 등
거의 대부분 registerar는 도메인 등록대행 dns hosting service를 같이 제공
