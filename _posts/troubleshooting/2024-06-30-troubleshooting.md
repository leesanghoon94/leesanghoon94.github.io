---
layout: post
title: "k8s"
date: 2024-06-30 05:07:15 +0900
categories: [k8s]
tags: [k8s]
---

E0629 20:08:07.418621   13891 memcache.go:265] couldn't get current server API group list: Get "https://172.30.1.2:644333/api?timeout=32s": dial tcp: address 644333: invalid port
Unable to connect to the server: dial tcp: address 644333: invalid port,
 kubectl typically communicates with the Kubernetes API server using the configuration specified in the .kube/config file. kubectl은 전형적으로 쿠버네티스 api와 통신한다 .kube/config를 사용해서 
crictl ps 로 kubeapiserver가 정상적으로 작동하고 있었고 주소가 33이 더붙어서 통신을 못하고 있었던것
Configuration file: By default, kubectl looks for a file named config in the $HOME/.kube directory. This file contains information about clusters, users, and contexts.
API server communication: The config file specifies the API server's address, authentication method, and other details needed for kubectl to communicate with the Kubernetes cluster.
Contexts: The config file can contain multiple contexts, each representing a different cluster or user. You can switch between these contexts using kubectl commands.
Authentication: The config file includes authentication information, such as client certificates, tokens, or username/password combinations, which kubectl uses to authenticate with the API server.
Server information: The cluster section in the config file specifies the API server's address and port, as well as the certificate authority data for secure communication.
Custom location: You can specify a different config file location using the --kubeconfig flag or by setting the KUBECONFIG environment variable.
In your case, the error message suggests there's an issue with the API server address or port in your kubeconfig file. The invalid port number (644333) indicates a misconfiguration in the server URL.
To resolve this, you should:
Check your ~/.kube/config file for any misconfigurations, especially in the cluster section where the server URL is specified.
Ensure the correct API server address and port are set (typically 6443 for the Kubernetes API server).
Verify that your kubeconfig file is properly formatted and doesn't contain any syntax errors.
If you're still having issues, you might need to regenerate your kubeconfig file or obtain a new one from your cluster administrator.
