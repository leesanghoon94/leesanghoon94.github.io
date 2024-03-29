---
title: SaaS를 활용한 모니터링(Datadog)#1
date: 2023-8-22 11:33:00 +0800
categories: [Blogging, Demo]
tags: [getting started]
---

1 SaaS를 활용한 모니터링(Datadog)#1

오픈소스를 활용한 모니터링 콜렉터 에이전트를 직접 관리
SaaS를 이용한 모니터링이란?
사용자들은 별도의 관리 서버나 대시보드 없이 SaaS 솔루션의 Endpoint로 Agent를 통해 데이터를 전송만 하면 시각화

- 수집된 데이터이 보관주기를 지정해서 사용
- 대부분 host 당 요금제로 과금하는 형태가 많음
- 최근 클라우드 환경에서 인프라와 어플리케이션, 로그 , DB를 종합적으로 볼 수 있는 솔루션으이 상용이 대세
- 전통적인 서버 관련 모니터링 뿐만 아니라 UX 까지 모니터링 할수 있음

SaaS 모니터링 솔루션엔 뭐가 있을까?

- Datadog
- NewRelic
- Dynatrace
- Sumologic
- Splunk
- whatap(한국기업)

Datadog
서버, DB, 클라우드 서비스 등에 대한 다양한 모니터링을 제공하는 클라우드 모니터링 애플리케이션을 대표하는 SaaS

- 서버 상태, DB 쿼리 모니터링, 로그 모니터링
- UX, CI, Security 영역까지 확대
- 다양한 CSP(AWS, Azure, GCP 등) 지원
- Custom Metric과 다양한 형태의 Alert 지원

(Infrastructure)
네트워크나 Host, Container, Process 등 인프라와 관련된 모니터링 기능을 제공

- integration을 통해 특정 CSP와 연동하면 host 정보를 수집하여 Map 형태로 나타낼 수 있음.
- Serverless와 관련된 서비스에 대해서도 모니터링 가능(library import)
- 클라우드 비용에 대한 모니터링도 제공
  (APM) Application Performence Mornitoring
  어플리케이션에 특정 Library를 같이 올려서 어플리케이션에 대한 실행 메소드나 성능을 모니터링
- 실시간으로 서비스에 대한 요청, 응답시간, 메소드 실행 흐름 등을 모니터링
- Log, RUM(Realtime User Mornitoring) ui쪽 모니터링,
  synthetic tests(api 모니터링)와 (APM)Trace를 연동하여 특정 시점에 대한 모니터링이 쉬움
- Database monitoring 기능으로 사용하고 있는 DB의 Slow query, query plan 등
  모니터링 3-tier 아키텍처에서 병목지점을 빠르게 찾을 수 있음

(Logs)
Agent를 통해 어플리케이션의 Log를 수집해서 모니터링

- 단순 Log 모니터링부터 Log와 Trace를 엮어서 사용자에게 제공
- 이를 통해 서비스 장애 발생 시, 사용자는 해당 시점에 어떤 Log가 있었는지에 대해 분석하기가 쉬움
- Observalbilty Pipelines을 제공해서 수집된 데이터들은 다른 모니터링 대상으로 정보를 가공할 수 있는 기능도 제공

(UX)
사용자 앞단에서 특정 API를 호출했을때, UI로부터 시작되는 로직의 모니터링이나 사용자의 행동에 따른 세션 등을 모니터링

- Real Useer Monitoring을 통해 사용자가 어느 국가에서 들어왔는지, 혹은 어떤 페이지에 오래 머물렀는지 등 다양한 모니터링 지표를 js를 통해 수집
- 세션 리플레이 기능을 통해 UX를 고도화시킬 수 있음
- 다양한 테스트 기능 지원

(Monitors)
수집되는 데이터를 특정한 조건을 걸어 해당 조건이 된 경우, 알람을 발생시키는 기능

- 이를 활용해서 갑자기 값이 변하는 경우, 이상 징후 감지 기능을 할 수 있음
- 장애 발생 시, Incident에 대해 정리하기 용이
- SLI를 정해서 SLO를 지키기 위해 모니터링 기능
