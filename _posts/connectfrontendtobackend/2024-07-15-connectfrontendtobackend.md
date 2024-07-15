---
layout: post
title: "서비스를 사용하여 프런트엔드를 백엔드에 연결"
date: 2024-07-15 23:13:05 +0900
categories: []
tags: []
---

이 작업에서는 프론트엔트 및 벡엔드 마이크로 서비스를 생성하는 방법을 보여줍니다.
벡엔드 마이크로 서비스는 hello greeter.
프론트엔드는 nginx 및 kubernetes service 개체를 사용하여 백엔드를 노출합니다.

objectives
deploymnet 객체를 사용하여 샘플 hello 백엔드 마이크로서비스를 생성하고 실행합니다.
서비스 객체를 사용하여 백엔드 마이크로서비스의 여러 복제본으로 트래픽을 보냅니다.
deploymnet 개체를 사용하여 nginx 프런트엔드 마이크로서비스를 생성하고 실행합니다.
백엔드 마이크로서비스로 트래픽을 보내도록 프런트엔드 마이크로서비스를 구성합니다. 유형=LoadBalancer의 서비스 객체를 사용하여 클러스터 외부에 프런트엔드 마이크로서비스를 노출합니다.

This task uses Services with external load balancers, which require a supported environment. If your environment does not support this, you can use a Service of type NodePort instead.

Creating the backend using a Deployment
The backend is a simple hello greeter microservice. Here is the configuration file for the backend Deployment:

````yaml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: backend
spec:
  selector:
    matchLabels:
      app: hello
      tier: backend
      track: stable
  replicas: 3
  template:
    metadata:
      labels:
        app: hello
        tier: backend
        track: stable
    spec:
      containers:
        - name: hello
          image: "gcr.io/google-samples/hello-go-gke:1.0"
          ports:
            - name: http
              containerPort: 80
...```

````

Creating the hello Service object
The key to sending requests from a frontend to a backend is the backend Service. A Service creates a persistent IP address and DNS name entry so that the backend microservice can always be reached. A Service uses selectors to find the Pods that it routes traffic to.

First, explore the Service configuration file:

```yaml
---
apiVersion: v1
kind: Service
metadata:
  name: hello
spec:
  selector:
    app: hello
    tier: backend
  ports:
    - protocol: TCP
      port: 80
      targetPort: http
```

Creating the frontend
Now that you have your backend running, you can create a frontend that is accessible outside the cluster, and connects to the backend by proxying requests to it.

The frontend sends requests to the backend worker Pods by using the DNS name given to the backend Service. The DNS name is hello, which is the value of the name field in the examples/service/access/backend-service.yaml configuration file.

The Pods in the frontend Deployment run a nginx image that is configured to proxy requests to the hello backend Service. Here is the nginx configuration file:

```yaml
    # The identifier Backend is internal to nginx, and used to name this specific upstream
    upstream Backend {
        # hello is the internal DNS name used by the backend Service inside Kubernetes
        server hello;
    }
    server {
    listen 80;
    location / {
        # The following statement will proxy traffic to the upstream named Backend
        proxy_pass http://Backend;
    }
    }
```
