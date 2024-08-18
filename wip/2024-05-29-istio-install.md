---
layout: post
title:
date:
categories:
tags:
---

controlplane $ export ISTIO_VERSION=1.14.4
controlplane $ curl -L https://istio.io/downloadIstio | TARGET_ARCH=x86_64 sh -
% Total % Received % Xferd Average Speed Time Time Time Current
Dload Upload Total Spent Left Speed
100 102 0 102 0 0 566 0 --:--:-- --:--:-- --:--:-- 563
100 4899 100 4899 0 0 7978 0 --:--:-- --:--:-- --:--:-- 7978

Downloading istio-1.14.4 from https://github.com/istio/istio/releases/download/1.14.4/istio-1.14.4-linux-amd64.tar.gz ...

Istio 1.14.4 Download Complete!

Istio has been successfully downloaded into the istio-1.14.4 folder on your system.

Next Steps:
See https://istio.io/latest/docs/setup/install/ to add Istio to your Kubernetes cluster.

To configure the istioctl client tool for your workstation,
add the /root/istio-1.14.4/bin directory to your environment path variable with:
export PATH="$PATH:/root/istio-1.14.4/bin"

Begin the Istio pre-installation check by running:
istioctl x precheck

Need more information? Visit https://istio.io/latest/docs/setup/install/
controlplane $ echo "export PATH=/root/istio-${ISTIO_VERSION}/bin:\$PATH" >> .bashrc
controlplane $ export PATH=/root/istio-${ISTIO_VERSION}/bin:$PATH
controlplane $ mv /tmp/demo.yaml /root/istio-${ISTIO_VERSION}/manifests/profiles/
controlplane $ istioctl install --set profile=demo -y --manifests=/root/istio-${ISTIO_VERSION}/manifests
✔ Istio core installed  
✔ Istiod installed  
✔ Egress gateways installed  
✔ Ingress gateways installed  
✔ Installation complete Making this installation the default for injection and validation.

Thank you for installing Istio 1.14. Please take a few minutes to tell us about your install/upgrade experience! https://forms.gle/yEtCbt45FZ3VoDT5A

Istio has been installed like described here.

https://istio.io/latest/docs/setup/getting-started
