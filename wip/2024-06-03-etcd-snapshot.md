---
layout: post
title:
date:
categories:
tags:
---

이 질문은 `etcd` 데이터베이스를 백업하고 복원하는 작업을 포함합니다. 아래 단계에 따라 `etcd` 데이터베이스를 백업하고, 복원하고, 복원 출력 로그를 저장할 수 있습니다.

### 1단계: 컨텍스트 설정

먼저, 주어진 컨텍스트로 전환합니다.

```bash
kubectl config use-context kubernetes-admin@kubernetes
```

### 2단계: 컨트롤 플레인 노드로 SSH 접속

컨트롤 플레인 노드에 SSH로 접속합니다.

```bash
ssh controlplane
```

### 3단계: etcd 데이터베이스 백업

`etcd` 데이터베이스를 백업하고 `/opt/cluster_backup.db`에 저장합니다. `etcd` 백업 명령어를 실행합니다.

```bash
ETCDCTL_API=3 etcdctl snapshot save /opt/cluster_backup.db \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt \
  --key=/etc/kubernetes/pki/etcd/healthcheck-client.key
```

위 명령어는 `etcd`의 백업을 `/opt/cluster_backup.db` 파일에 저장합니다.

### 4단계: etcd 데이터베이스 복원

`etcd` 데이터베이스를 복원하고 출력 로그를 `restore.txt` 파일에 저장합니다.

```bash
ETCDCTL_API=3 etcdctl snapshot restore /opt/cluster_backup.db \
  --data-dir=/root/default.etcd &> restore.txt
```

### 전체 프로세스 요약

1. **컨텍스트 설정**

   ```bash
   kubectl config use-context kubernetes-admin@kubernetes
   ```

2. **SSH 접속**

   ```bash
   ssh controlplane
   ```

3. **etcd 데이터베이스 백업**

   ```bash
   ETCDCTL_API=3 etcdctl snapshot save /opt/cluster_backup.db \
     --endpoints=https://127.0.0.1:2379 \
     --cacert=/etc/kubernetes/pki/etcd/ca.crt \
     --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt \
     --key=/etc/kubernetes/pki/etcd/healthcheck-client.key
   ```

4. **etcd 데이터베이스 복원 및 로그 저장**
   ```bash
   ETCDCTL_API=3 etcdctl snapshot restore /opt/cluster_backup.db \
     --data-dir=/root/default.etcd &> restore.txt
   ```

### 주요 포인트

- **`ETCDCTL_API=3`**: `etcdctl` 명령어를 API 버전 3로 설정합니다.
- **`snapshot save`**: `etcd` 스냅샷을 저장하는 명령어입니다.
- **`snapshot restore`**: `etcd` 스냅샷을 복원하는 명령어입니다.
- **`--data-dir`**: 복원된 데이터가 저장될 디렉토리를 지정합니다.
- **`&>`**: 명령어 출력을 파일로 리디렉션합니다.

이 명령어들을 순차적으로 실행하면 `etcd` 데이터베이스를 백업하고, 이를 복원하며, 복원 과정을 `restore.txt` 파일에 저장할 수 있습니다.
