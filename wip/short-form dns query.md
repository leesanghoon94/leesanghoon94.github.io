short-form dns query nslookup **kubernetes.default** not working

kube-dns 행동:

1. kube-dns pod's /etc/resolv.conf 는 일반적으로 호스트와 동일하다.
2. kubedns는 알 수 없는 도메인을 resolv.conf의 이름 서버로 전달합니다.
   참고: kubernetes.default와 같은 짧은 형식 쿼리는 kubedns에 알려지지 않았습니다.
3. kubedns는 첫 번째 네임서버만 사용하는 것 같습니다.
   edit: https://github.com/skynetservices/skydns/blob/f694f5637b31e2b9c9871fb396773d5d18b9309e/server/exchange.go#L29에서 NSRotate를 수행하지 않습니다. NSRotate가 없으면 항상 첫 번째 이름 서버를 먼저 사용하고 연결 오류가 있을 때만 재시도합니다. 애플리케이션 오류의 경우 업스트림 오류 코드를 직접 전달합니다.

따라서 짧은 형식 쿼리는 다음과 같이 작동합니다.

1. 클라이언트는 kube-dns에 짧은 형식의 쿼리를 보냅니다.
2. kube-dns는 이에 대해 아무것도 모르고 resolv.conf의 외부 네임서버로 전달합니다.
3. 외부 이름 서버가 kube-dns에 ERROR를 반환합니다.
4. kube-dns가 클라이언트로 전달 실패;
5. 클라이언트는 resolv.conf에 검색 도메인을 추가하고 1로 이동하여 재시도합니다.

클라이언트 행동:
5의 경우 다른 클라이언트는 3과 다른 오류와 관련하여 다른 동작을 보이는 것 같습니다.
busybox의 경우 NXDOMAIN에 대한 검색만 추가되고 REFUSED에 대한 검색은 추가되지 않는 것 같습니다.
alpine 및 tutum/dnsutils의 경우 NXDOMAIN 및 REFUSED에 대한 검색을 추가합니다.

그래서 나는 이상한 행동을 취했습니다.
kube-dns가 NXDOMAIN 노드에 있으면 busybox nslookup 테스트가 작동합니다.
kube-dns가 REFUSED 노드에 있으면 busybox nslookup 테스트가 실패합니다.
alpine/tutum/dnsutils는 항상 kube-dns가 있는 노드와 관련하여 작동합니다.

따라서 kube-dns를 배포할 때 호스트 /etc/resolv.conf의 첫 번째 네임서버가 예상대로 작동하는지 확인해야 합니다.

================ 아래는 원래 질문입니다 ===============================
온프레미스 k8s 클러스터에 대해 RBAC를 활성화했지만 네임스페이스 간 DNS 쿼리가 비RBAC와 다른 것을 발견했습니다.
이 동작에 대한 문서를 찾지 못했기 때문에 이 문제입니다.

RBAC가 없는 경우:
svc1.ns1을 사용하여 ns2에서 ns1의 서비스에 대한 네임스페이스 간 DNS 쿼리를 수행할 수 있습니다.
네임스페이스가 있는 svc1.ns1을 사용하여 동일한 네임스페이스의 서비스를 쿼리할 수 있습니다.
하지만 RBAC에서는 FQDN을 사용해야 합니다.

ns2에서 svc1.ns1을 사용하여 네임스페이스 간 쿼리를 수행할 수 없습니다.
네임스페이스가 있는 svc1.ns1을 사용하여 동일한 네임스페이스에서 서비스를 쿼리할 수 없습니다.
기본 네임스페이스의 busybox에서 다음과 같은 출력을 얻었습니다.
