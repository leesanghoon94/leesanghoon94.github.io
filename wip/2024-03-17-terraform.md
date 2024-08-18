---
layout: post
title:
date:
categories:
tags:
---

## module

함께 사용되는 여러개의 리소스에 대한 컨테이너
디렉토리 안에 여러개의 파일로 구성된
리소스 설정을 패키징하거나 재사용하기 위한 주요 방법 중 하나
모든 terraform 설정은 적어도 하나의 module로 구성된다
child module root module 내의 다른 module
public/private registery를 통해서 선언한 module을 publish or load 할 수 있다

source
필수 argument
설정 파일 이 포함된 local directory path 또는 download 가능한 remote module
module block 이 추가/수정/삭제되면 무조건 terraform init을 실행
version
설치하고자할 module version

## variable

코드 수업 없이 module 에 영향을 줄 수 있는 요소(변수)

## local

표현식을 위한 이름
표현시글 여러번 반복할때 사용

## output

terraform 설정에 대한 정보를 노출하기 위한 요소

## 값 참조 방식

- Resource : <resource type>.<name>
- data: data.<data type>.<name>

## string templates

interpolation: ${...}
directive: %{...}

## 조건문(condition)

기본 문법 삼항연산자
조건문 사용시 return되는 값의 타입을 주의
for문 필터링
