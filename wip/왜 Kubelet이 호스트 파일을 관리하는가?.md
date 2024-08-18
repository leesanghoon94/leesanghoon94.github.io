```
apiVersion: v1
kind: Pod
metadata:
  name: hostaliases-pod
spec:
  restartPolicy: Never
  hostAliases:
  - ip: "127.0.0.1"
    hostnames:
    - "foo.local"
    - "bar.local"
  - ip: "10.1.2.3"
    hostnames:
    - "foo.remote"
    - "bar.remote"
  containers:
  - name: cat-hosts
    image: busybox:1.28
    command:
    - cat
    args:
    - "/etc/hosts"
```

왜 Kubelet이 호스트 파일을 관리하는가?
컨테이너가 이미 시작되고 난 뒤에 컨테이너 런타임이 hosts 파일을 수정하는 것을 방지하기 위해, Kubelet이 파드의 각 컨테이너의 hosts 파일을 관리한다. 역사적으로, 쿠버네티스는 컨테이너 런타임으로 계속 도커 엔진을 사용해 왔으며, 각 컨테이너가 시작된 뒤에 도커 엔진이 /etc/hosts 파일을 수정할 수 있었다.

현재 쿠버네티스는 다양한 컨테이너 런타임을 사용할 수 있으며, kubelet이 각 컨테이너 내의 hosts 파일을 관리하므로 어떤 컨테이너 런타임을 사용하는지에 상관없이 동일한 결과를 얻을 수 있다.

주의:
컨테이너 내부의 호스트 파일을 수동으로 변경하면 안된다.

호스트 파일을 수동으로 변경하면, 컨테이너가 종료되면 변경 사항이 손실된다.
