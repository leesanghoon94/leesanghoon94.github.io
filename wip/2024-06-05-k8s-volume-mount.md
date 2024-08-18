---
layout: post
title:
date:
categories:
tags:
---

k8s 볼륨(Volume)과 볼륨 마운트(VolumeMount)
볼륨(Volume)
쿠버네티스에서 볼륨은 파드 내 컨테이너들이 데이터를 공유하고 영구적으로 저장할 수 있는 디렉터리입니다. 볼륨은 파드의 수명주기와 별개로 존재하며, 다양한 유형의 볼륨이 있습니다.
emptyDir: 임시 데이터를 저장하는 빈 디렉터리로, 파드가 삭제되면 데이터도 삭제됩니다.
hostPath: 노드의 특정 경로를 파드 내부에 마운트합니다.
nfs: NFS 공유 볼륨을 마운트합니다.
gcePersistentDisk, awsElasticBlockStore: 클라우드 공급자의 영구 스토리지를 마운트합니다.
볼륨은 spec.volumes 섹션에서 정의합니다.
yaml
volumes:

- name: data
  emptyDir: {}

볼륨 마운트(VolumeMount)
볼륨 마운트는 파드 내 컨테이너에서 볼륨을 사용할 수 있도록 마운트하는 방법입니다. spec.containers.volumeMounts 섹션에서 정의합니다.
yaml
volumeMounts:

- name: data
  mountPath: /data

name: 마운트할 볼륨의 이름입니다.
mountPath: 컨테이너 내부에서 볼륨이 마운트될 경로입니다.
예시
yaml
apiVersion: v1
kind: Pod
metadata:
name: myapp
spec:
containers:

- name: myapp
  image: myapp:v1
  volumeMounts:
  - name: data
    mountPath: /data
    volumes:
- name: data
  hostPath:
  path: /var/data

이 예시에서는 /var/data 호스트 경로를 파드 내 /data 경로에 마운트합니다. 컨테이너는 /data 경로를 통해 호스트의 데이터에 접근할 수 있습니다.
볼륨과 볼륨 마운트를 사용하면 파드 내 컨테이너들이 데이터를 공유하고 영구적으로 저장할 수 있습니다. 이는 상태 저장 애플리케이션을 구축하는 데 필수적입니다.

---

볼륨 (Volume)
yaml
volumes:

- name: vol
  hostPath:
  path: /configurator

volumes 섹션에서 vol이라는 이름의 볼륨을 정의합니다.
이 볼륨의 유형은 hostPath입니다. 이는 호스트 노드의 특정 경로를 파드 내부에 마운트하는 방식입니다.
path: /configurator는 호스트 노드의 /configurator 경로를 파드 내부에 마운트할 것임을 의미합니다.
볼륨 마운트 (VolumeMount)
yaml
volumeMounts:

- name: vol
  mountPath: /mount

volumeMounts 섹션에서 앞서 정의한 vol 볼륨을 컨테이너 내부의 /mount 경로에 마운트합니다.
즉, 호스트 노드의 /configurator 경로는 파드 내부의 /mount 경로에 마운트됩니다.
이렇게 함으로써 파드 내부의 컨테이너는 호스트 노드의 /configurator 경로에 접근할 수 있게 됩니다. 이 예시에서는 echo aba997ac-1c89-4d64 > /mount/config 명령을 통해 /configurator/config 파일에 특정 값을 쓰게 됩니다.
볼륨 마운트는 파드와 호스트 노드 간의 데이터 공유를 가능하게 하며, 특히 DaemonSet의 경우 모든 노드에 동일한 구성을 적용하는 데 유용합니다.
