nslookup to kubernetes service return nxdomian error

발생내용
nslookup nginx-service 이름으로 수행하려고 했지만 nsdomain오류가 수신되었다

발생이유
도메인 분석요청이 dns로 전송되고 Ip 주소에 대한 요청이 해결될 수 없는 경우 nsdomain 오류가 발생합니다
nsdomain 오류 메시지는 도메인이 존재하지 않음을 의미합니다

해결 방법
DNS Services 이 (가) 올바르게 구성되었으며 다음 dig 명령을 사용하여 가상 서버 인스턴스 내에서 161.26.0.7 및 161.26.0.8 에 대한 액세스를 사용할 수 있는지 확인하십시오. $ dig @161.26.0.7 yourzone.com.
요청을 전송 중인 서버가 다음 DNS 분석기 중 하나를 사용하도록 구성되었는지 확인하십시오. 161.26.0.7 또는 161.26.0.8.
요청을 전송 중인 서버가 허용된 네트워크로 DNS 영역에 추가된 VPC의 일부인지 확인하십시오.
이름 분석이 시도된 FQDN에 DNS 구역의 리소스 레코드가 있는지 확인하십시오.
DNS 요청이 조회에 올바른 자원 레코드 유형을 사용하고 있는지 확인하십시오.

Route 53을 DNS 서비스로 사용하는 경우 NXDOMAIN 응답 문제를 해결하려면 어떻게 해야 하나요?

해결 방법
도메인이 활성 상태인지 일시 중지 상태인지 확인

1.  도메인에 대해 whois 쿼리를 실행합니다.
    whois가 설치되어 있는지 확인한 후 다음 명령을 실행합니다.

Windows의 경우: Windows 명령 프롬프트를 연 다음 whois -v example.com을 입력합니다.
Linux의 경우:\*\*\*\*SSH 클라이언트를 엽니다. 명령 프롬프트에서 whois example.com을 입력합니다.

참고: 도메인이 Amazon 등록 기관에 등록된 경우 Amazon Registrar whois 조회 도구를 사용할 수 있습니다.

2.  도메인의 상태를 확인합니다. 도메인 상태의 값이 clientHold인 경우 도메인이 일시 중지된 것입니다.

whois 출력 예:

whois example.com
Domain Name: EXAMPLE.COM
Registry Domain ID: 87023946_DOMAIN_COM-VRSN
Registrar WHOIS Server: whois.godaddy.com
Registrar URL: http://www.godaddy.com
Updated Date: 2020-05-08T10:05:49Z
Creation Date: 2002-05-28T18:22:16Z
Registry Expiry Date: 2021-05-28T18:22:16Z
Registrar: GoDaddy.com, LLC
Registrar IANA ID: 146
Registrar Abuse Contact Email: abuse@godaddy.com
Registrar Abuse Contact Phone: 480-624-2505
Domain Status: clientDeleteProhibited https://icann.org/epp#clientDeleteProhibited
Domain Status: clientHold https://icann.org/epp#clientHold  
 Domain Status: clientTransferProhibited https://icann.org/epp#clientTransferProhibited
Domain Status: clientUpdateProhibited https://icann.org/epp#clientUpdateProhibited
Name Server: ns-1470.awsdns-55.org.
Name Server: ns-1969.awsdns-54.co.uk.
Name Server: ns-736.awsdns-28.net.
Name Server: ns-316.awsdns-39.com.

도메인을 인터넷에서 다시 사용할 수 있게 하려면 이를 일시 중지 상태에서 제거하세요. 도메인이 일시 중지될 수 있는 가장 일반적인 이유는 다음과 같습니다.

새 도메인을 등록했지만 확인 이메일에 있는 링크를 클릭하지 않았습니다.
도메인의 자동 갱신을 해제한 후 도메인이 만료되었습니다.
등록 기관 연락처의 이메일 주소를 변경했지만 새 이메일 주소가 유효한지 검증하지 않았습니다.
자세한 내용은 내 도메인이 일시 중지됨(상태: ClientHold)을 참조하세요.

도메인 등록 기관에 올바른 이름 서버가 구성되어 있는지 확인

1.  whois 출력에서 도메인에 대한 권한이 있는 이름 서버를 기록해 둡니다. 예를 보려면 이전의 whois 출력을 참조하세요.

dig 유틸리티를 사용하여 구성된 이름 서버를 확인할 수도 있습니다.

dig +trace 출력 예:

dig +trace example.com

; <<>> DiG 9.11.4-P2-RedHat-9.11.4-26.P2.amzn2.2 <<>> +trace example.com
;; global options: +cmd
. 518400 IN NS H.ROOT-SERVERS.NET.
. 518400 IN NS I.ROOT-SERVERS.NET.
. 518400 IN NS J.ROOT-SERVERS.NET.
. 518400 IN NS K.ROOT-SERVERS.NET.
;; Received 239 bytes from 10.0.0.2#53(10.0.0.2) in 0 ms

com. 172800 IN NS a.gtld-servers.net.
com. 172800 IN NS m.gtld-servers.net.
com. 172800 IN NS h.gtld-servers.net.
C41A5766
com. 86400 IN RRSIG DS 8 1 86400 20210329220000 20210316210000 42351 .
;; Received 1174 bytes from 192.112.36.4#53(G.ROOT-SERVERS.NET) in 104 ms

example.com. 172800 IN NS ns-1470.awsdns-55.org. ------>Name servers of interest.
example.com. 172800 IN NS ns-1969.awsdns-54.co.uk.
example.com. 172800 IN NS ns-736.awsdns-28.net.
example.com. 172800 IN NS ns-316.awsdns-39.com.

;; Received 732 bytes from 192.33.14.30#53(b.gtld-servers.net) in 91 ms

example.com. 3600 IN A 104.200.22.130
example.com. 3600 IN A 104.200.23.95
example.com. 3600 IN NS ns-1470.awsdns-55.org.
example.com. 3600 IN NS ns-1969.awsdns-54.co.uk.
example.com. 3600 IN NS ns-736.awsdns-28.net.
example.com. 3600 IN NS ns-316.awsdns-39.com.

;; Received 127 bytes from 173.201.72.25#53(ns-1470.awsdns-55.org) in 90 ms 2. Route 53 콘솔을 엽니다.

3.  탐색 창에서 호스팅 영역을 선택합니다.

4.  호스팅 영역 페이지에서 호스팅 영역의 라디오 버튼(이름 아님)을 선택합니다. 그런 다음 세부 정보 보기를 선택합니다.

5.  호스팅 영역에 대한 세부 정보 페이지에서 호스팅 영역 세부 정보를 선택합니다.

6.  호스팅 영역 세부 정보에 나열된 이름 서버가 whois 또는 dig +trace 출력의 이름 서버와 동일한지 확인합니다.

**중요:**이름 서버가 서로 동일하지 않은 경우 도메인 등록 기관에서 이를 업데이트하세요. 도메인이 Route 53에 등록된 경우, 도메인의 이름 서버 및 글루 레코드 추가 또는 변경를 참조하세요. 도메인이 서드 파티에 등록된 경우에는 이름 서버를 업데이트하는 방법에 관한 단계에 대한 제공업체 문서를 참조하세요.

요청된 레코드가 존재하는지 확인
도메인에 대한 호스팅 영역에 요청된 레코드가 포함되어 있는지 확인하세요. 예를 들어 www.example.com을 확인하려고 할 때 NXDOMAIN 응답을 받는 경우 example.com 호스팅 영역에서 www.example.com 레코드를 확인하세요. Route 53에서 레코드를 나열하는 방법에 대한 단계는 레코드 나열을 참조하세요.

다른 도메인 이름을 가리키는 CNAME 레코드가 있는 경우 표준 이름이 존재하고 확인 가능한지 확인하세요.

예시

example.com CNAME 레코드가 blog.example.com의 값으로 구성되어 있습니다. 이 경우 레코드 blog.example.com이 존재하며 확인 가능한지 검증하세요.

서브도메인 위임 문제 확인

1.  확인하려는 도메인 이름에 대한 이름 서버(NS) 레코드의 상위 호스팅 영역을 확인합니다. 서브도메인에 대한 NS 레코드가 있는 경우 도메인과 서브도메인에 대한 권한이 다른 영역에 위임됩니다. 예를 들어 www.example.com에 대한 NS 레코드가 있는 경우 www에 대한 권한이 NS 레코드의 이름 서버에 위임됩니다. 위임이 유효한 경우 example.com의 상위 영역이 아닌 위임된 영역에서 도메인에 대한 레코드를 생성해야 합니다.

2.  위임이 유효하지 않은 경우 도메인에 대한 NS 레코드를 삭제합니다. 상위 호스팅 영역(example.com)에 확인하려는 도메인 이름에 대한 레코드가 포함되어 있는지 확인합니다.

3.  QNAME 최소화를 구현하는 확인자는 각 쿼리에 확인 프로세스의 해당 단계에 필요한 최소한의 세부 정보를 포함합니다. 이로 인해 일부 확인자에서 NXDOMAIN 문제가 발생할 수 있습니다. 여러 수준의 서브도메인 위임을 구성할 때는 모든 수준에서 엄격한 위임을 따르세요. 자세한 내용은 서브도메인의 추가 수준에 대한 트래픽 라우팅을 참조하세요.

DNS 확인 문제가 VPC에만 존재하는지 확인

1.  클라이언트 운영 체제(OS)에 구성된 확인자 IP 주소를 확인합니다. Linux의 경우 /etc/resolv.conf 파일을 확인합니다. Windows의 경우 ipconfig /all 출력에서 DNS 서버를 확인합니다. 기본 Virtual Private Cloud(VPC) DNS 확인자(VPC CIDR+2)를 찾아봅니다. 예를 들어 VPC CIDR이 10.0.0.0/8인 경우 DNS 확인자 IP 주소는 10.0.0.2입니다. /etc/resolv.conf에 VPC DNS 확인자가 보이지 않는 경우 사용자 지정 DNS 확인자를 확인합니다.

2.  VPC DNS 확인자를 사용하는 경우 프라이빗 호스팅 영역과 Route 53 확인자 규칙을 확인합니다.

확인자 규칙 및 프라이빗 호스팅 영역을 사용하는 경우

확인자 규칙과 프라이빗 호스팅 영역 도메인 이름이 일치하는 경우 확인자 규칙이 우선합니다. 자세한 내용은 프라이빗 호스팅 영역틀 통한 작업 시 고려 사항을 참조하세요. 이 경우 DNS 쿼리는 확인자 규칙에서 대상으로 구성된 대상 IP 주소로 전송됩니다.

확인자 규칙이 없는 프라이빗 호스팅 영역을 사용하는 경우

VPC와 관련된 도메인 이름과 일치하는 프라이빗 호스팅 영역이 있는지 검증합니다. 예를 들어 VPC와 관련된 도메인에 대한 퍼블릭 호스팅 영역과 프라이빗 호스팅 영역이 있을 수 있습니다. 이는 스플릿 뷰 또는 스플릿 호라이즌 DNS입니다. 이 경우 VPC의 클라이언트가 퍼블릭 호스팅 영역에서 생성된 레코드를 확인할 수 없습니다. 레코드가 프라이빗 호스팅 영역에 없는 경우 VPC DNS가 퍼블릭 호스팅 영역으로 폴백되지 않습니다.

확인자 규칙만 사용하고 프라이빗 호스팅 영역은 사용하지 않는 경우

Route 53 확인자 규칙을 확인하세요. 도메인 이름과 일치하는 규칙이 있는 경우 도메인에 대한 쿼리가 구성된 대상 IP 주소로 라우팅됩니다. 즉, 쿼리가 기본 퍼블릭 확인자로 라우팅되지 않습니다.

문제가 네거티브 캐싱의 결과인지 확인
네거티브 캐싱은 신뢰할 수 있는 이름 서버의 부정적인 응답을 캐시에 저장하는 프로세스입니다. NXDOMAIN 응답은 부정적인 응답으로 간주됩니다. 다음의 예를 고려해 보세요.

neg.example.com 레코드가 존재하지 않으므로 클라이언트가 neg.example.com에 대한 DNS 쿼리를 만들고 NXDOMAIN이라는 응답 코드를 받습니다.

또한 이 사용자는 example.com을 소유하고 있으므로 neg.example.com에 대한 새 레코드를 생성합니다. 다른 네트워크의 사용자가 레코드를 성공적으로 확인할 수 있을 때 사용자는 계속해서 NXDOMAIN 응답을 받게 됩니다.

사용자가 새 레코드를 생성하기 전에 neg.example.com에 쿼리를 만들면 NXDOMAIN 응답을 받게 됩니다. 사용자가 확인자 설정에서 네거티브 캐싱을 설정한 경우 확인자가 이 응답을 캐시합니다. 사용자는 새 레코드를 생성한 후 쿼리를 다시 만듭니다. 확인자는 이전에 이 쿼리를 수신하여 캐시했으므로 캐시에서 응답을 반환했습니다.

부정적인 응답의 답변에서는 레코드가 반환되지 않으므로 긍정적인 응답과 비교할 때 TTL(Time to Live)값이 없습니다. 이 경우 확인자는 다음 중 가장 낮은 값을 사용합니다.

권한 시작(SOA) 레코드의 최소 TTL값.
NXDOMAIN 응답을 캐시하기 위한 SOA 레코드의 TTL값.
이 문제를 확인하려면 이름 서버에 직접 쿼리를 전송하여 응답을 받을 수 있는지 확인하세요. 예:

dig www.example.com @ns-1470.awsdns-55.org
