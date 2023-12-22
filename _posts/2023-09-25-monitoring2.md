---
layout: post
title: 모니터링 알람과 자동화#2
date: 2023-09-25 11:11:11 +0800
categories: [Blogging]
tags:
---

datadog을 활용해서

alert
모니터링 하는 특정 metric의 이상 현상을 알림으로 받기 위한 기능
예를들어 급격히 증가하는 HTTP 400/500 Error와 db cpu metric 값을 올라갔을때 엮어 상황 유추 가능
특정 조건을 걸어 단일 alert으로 생성 여러 단일 alert으로 복합 조건인 alert을 생성 가능
어떤 상황이 발생했는지를 알림 채널(email, slack, pageduty등)을 통해 알림을 받음
이를 통해 예외 상황 대응을 빠르게 할 수 있음

incident
서비스 장애나 인프라 장애가 발생했을때 단순히 문제를 해결하는 것이 다가 아님
다시 발생하지 않도록 예방책과 왜 문제가 일어났는지에 대한 분석이 필요
monitor, slo, metrics들을 종합적으로 분석
이를 incident화 시켜서 관리
incident가 발생 시, 필요한 인원에 대한 slack channel, alert 생성
당시 상황에 해당하는 metric 그래프, warning과 monitor의 alert을 시간 순으로 나열
postmoterm(부검,회고)으로 이어지는 구조로 구성

slo
sli를 이용해 목표로 하는 서비스 수준 목표(SLO)까지 지킬 수 있도록 지정
SLO는 SRE의 핵심 같은 수준의 서비스를 사용자에게 제공하기 위한 목표값
앞선 모니터 기반 SLO와 메트릭 기반 SLO, Error Budget, Burn Rate를 설정
SLO설정을 통해서는 Metric으로 사용가능 Dashboard로 사용
이를 하나의 Metric으로 Monitor를 활용해 설정한 값 중 특정 조건이 해당되면 Alert를 발생

monitor 알람 slack으로 받기
