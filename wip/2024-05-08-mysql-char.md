---
layout: post
title:
date:
categories:
tags:
---

수정  
컬럼에 현재 타임스탬프 자동으로 설정

Automatic Initialization and Updating for TIMESTAMP and DATETIME

CREATE TABLE t1 (
ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
dt DATETIME DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE table_name
MODIFY COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
MODIFY COLUMN updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

수정  
MySQL 클라이언트 실행 시 옵션 추가하기:  
mysql --default-character-set utf8mb4

이미 실행 중인 MySQL 클라이언트에서 변경하기:
SET NAMES 'utf8mb4';  
개별 변수 설정하기:  
show variables like 'char%';  
SET character_set_client = utf8mb4;  
SET character_set_connection = utf8mb4;  
SET character_set_results = utf8mb4;

> 참고
> https://dev.mysql.com/doc/refman/8.0/en/timestamp-initialization.html
