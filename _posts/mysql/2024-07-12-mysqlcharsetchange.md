---
layout: post
title: "mysql character set 변경"
date: 2024-07-12 16:17:39 +0900
categories: []
tags: []
---

### mysql character set 수정하는법

MySQL 클라이언트 실행 시 옵션 추가하기:  
mysql --default-character-set utf8mb4

이미 실행 중인 MySQL 클라이언트에서 변경하기:
SET NAMES 'utf8mb4';  
개별 변수 설정하기:  
show variables like 'char%';  
SET character_set_client = utf8mb4;  
SET character_set_connection = utf8mb4;  
SET character_set_results = utf8mb4;

#### 출처

- https://dev.mysql.com/doc/refman/8.4/en/charset.html
