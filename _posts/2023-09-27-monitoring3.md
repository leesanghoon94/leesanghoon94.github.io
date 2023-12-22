---
layout: post
title: 모니터링 알람과 자동화#3
date: 2023-09-27 11:11:11 +0800
categories: [Blogging]
tags:
---

Datadog Metric Query
metrics Explorer를 통해 Dashborad나 Widget을 만들기 전, metric을 조회해 볼 수 있는 기능이 있음
Metric Summary 탭에서 지원하는 Metric 조회 가능
시간 단위, 찾는 Metric 조건, 집계 함수 등을 수정하면서 Metric 확인
APM Based Metric, Log Based Metric, Custom Metric도 조회

Datadog API
datadog에서 지원하는 대부분의 기능을 API로 제공
java, python, typescript 등 언어에 대한 SDK를 공식적으로 지원해줌
Datadog에서 발급하는 API Key, APP Key를 활용하여 API 사용
짧은 주기로 호출 하는 경우, Rate limit이 걸릴 수 있음 API 별로 다름

Slack으로 Datadog Metric 조회
![image]()
