---
layout: post
title: 모니터링 알람과 자동화#1
categories: [Blogging]
tags:
---

대부분의 모니터링 솔루션에는 Alert 기능이 존재
모니터링 대상에서 일어나는 여러 사건을 매번 확인할수없음
따라서 이를 rule 혹은 policy로 만들어서 사용
즉, 특정 조건에 만족하게 되면 어떤 현상이 일어난 것으로 인지
대응할 수 있도록 알람
Email, SMS, SNS 등을 활용
![image]()

cloudwatch는 모니터링이 되는 대부분 서비스에 대해 알람 제공
lb나 ec2 status, billing 등 다양한 지표를 알람 지표로 제공
복합 조건에 대한 알람도 제공
발생한 알람은 sns의 특정 topic으로 publish 이를 가져가서 사용하는 곳에서 보낼 대상으로 구현이 필요

grafan와 연결된 모둔 data source에 대해 알람 지표로 제공
연결된 데이터 소스에 따라 지표를 다르게 평가 prometheus는 PromQL, MySQLdms SQL 등으로 지표를 평가
외부의 AlertManager를 Datasource로 사용 모니터링 및 Alert 발생을 한곳에서 관리
최근에는 Enterprise 버전에서만 제공되는 기능도 추가

모니터링 대상이 되는 Application에 Rule을 적용해서 알람제공
preset으로 제공되는 rule에 대해서만 가능 발생한 alarm을 Db에 저장
알람 대상은 기본적으로 email과 sms(interface제공), webhook 사용가능
다른 모니터링 tool에 비해 많은 기능을 지원하지 않음
