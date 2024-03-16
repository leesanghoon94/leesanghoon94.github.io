---
layout: post
title:
date:
categories:
tags:
---

## 서비스 프레임워크란?

서버리스를 위한 배포 프레임 워크
서버리스 환경에서 사용할 기능을 만든후 환경설정 배포 디버깅

## serverless framework

serverless 서비스와 연결되는 서비스 aws eventbridge sns 를 구성하고

## 주요 요소

service
provider 구성하는 환경에 대한 설정 어떤 환경인지 어떤 언어오아 Runtime을 사용하는지 ,어떤 iam role을 사용 하는지등을 적어서 사용

plugin
serverless 기능을 확장할 때 많이 사용되는 기능

## serverless 설치

npm i -g serverless
aws configure
sls create

## serverless yaml reference

## go

## makefile

## 서버리스 프레임워크와 aws서비스

lambda real-time stream processing

iam
aws 클라우드 인프라 안에서 신분과 접속/접근을 관리하기 위한 서비스
그룹 사용자 역할 정책으로구성
aws 외부에서 접근하기 위한 idp로 사용가능

s3
object로 불리는 단위로 데이터를 저장하는 서비스
버킷 object 키 리전으로 구성
파일에 대해 가지고 있는

cloudformation
json또는 yaml 형식의 텍스트 파일로 구성되거나 gui로 구성된 template을 기반으로 aws iac

eventbridge
이벤트 소스로부터 발생한 이벤트를 감지하여 특정 패턴에 매칭
event target 으로

api gateway
규모에 상관없이 api 생성 유지 관리 모니터링과 보호를 할 수있게 되는 서비스
사용자가 설정한 라우팅 설정에 따라 프록시 역할
엔드포인트 서버에서 공통으로 필요한 인증/인가 사용량 제어 요청/응답 변조등의 다양한 기능을 플러그인 형태로 제공
httpapi rest api websocket api

lambda
이벤트가 발생했을때 코드 를 실행하고 컴퓨터 리소스를 관리
다양한 aws서비스왕 조합해서 사용
다양한 언어와 스펙에 따라 성능이 다르게 동장
별도의 상태저장을하지않는 statless

cloudwatch
aws 리소스와 aws에서 실시간으로 실행중인 애플리케이션을 모니터링 하는 서비스
지표를 감시해 알림을 보내거나 임계 값을 넘는 경우 모니터링 중인 리소스를 자동으로 변경하는 알림를 생성하거나 외부로 전달 가능
namspace dimension metric statistics로구성
