---
layout: post
title:
date:
categories:
tags:
---

## terraform 장점

## terraform 단점

aws 설정을 terraform 으로 한번에 migration 하기 어려움
배포전략이 제한적
blue/green 배포를 구현할 수 있음
러닝 커브
hcl문법
plan과 apply 명령어 차이

## hcl문법

기본 문법 .tf
json 문법 .tf.json
convention indent = 2 space
arguments attribute
식별자 argument name = 값 argument value

blocks 컨텐츠의 묶음
최상위 block type
resource input output data module

## formatter

indent, code style 정령해주는 명령어
vs code plugin

## resource, data

resource
가상 네트워크나 인스턴스 같은 객체를 표현
resource type은 provider에 따라 다름

data
terraform 외부에서 정의된 정보
(기본 ami id , iam policy id ..)

local-only-data
terraform 내에서만 작동하는 Data source
rendering templates
reading local files
rendering aws iam policies
