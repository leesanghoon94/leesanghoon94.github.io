---
layout: post
title: "podtermination정책의이해"
date: 2024-07-16 17:23:44 +0900
categories: []
tags: []
---

pod termination 정책의 이해
termination 정책의 필요성
운영환경에서는 필수적인 제로타임 배포
deployment rolling update > maxUnavailable 파라미터로 다운타임 최소화
하지만 Alb 에서 draingin 되는 pod에서 5xx 에러 발생 가능성
따라서 eks 제로 다운타임 배포환경을 구현하기 위한 추가 설정

무중단 구현을 위한 설정들
maxSurge/ maxUnavailable
ReadinessGates
ReadinessProbe,LivenessProbe
Hook(preStop, preStart)
terminationGracePeriodSeconds
minReadySeconds

pod의 life cycle

1. container termination 시작
2. preStop hook 시작
3. term signal
4. kill signal

---

all time answer 느ㄴ 없는법
spot ec2리소스 풀 사용률 증가의 경우, 스팟가격 상승의 경우 ec2종료가능성
