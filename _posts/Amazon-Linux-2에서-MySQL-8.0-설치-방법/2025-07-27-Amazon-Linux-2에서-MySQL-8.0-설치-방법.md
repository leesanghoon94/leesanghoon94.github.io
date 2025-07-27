---
layout: post
title: "Amazon Linux 2에서 MySQL 8.0 설치 방법"
date: 2025-07-27 16:46:48 +0900
categories: []
tags: []
---

# Amazon Linux 2에서 MySQL 8.0 설치 방법

## EPEL(Extra Packages for Enterprise Linux) 소개

리눅스에서 smokeping, RANCID 등 일부 도구를 설치하려고 할 때 `epel` 저장소를 먼저 설치하라는 안내를 본 적이 있을 것입니다. 당시에는 매뉴얼을 그대로 따라 했지만, SRE/DevOps 업무를 하면서 EPEL의 개념을 정확히 이해하는 것이 중요하다고 느껴 정리합니다.

**EPEL**은 "Extra Packages for Enterprise Linux"의 약자로, RHEL(Red Hat Enterprise Linux)이나 CentOS 등에서 기본적으로 제공하지 않는 추가 패키지를 설치할 수 있도록 해주는 저장소입니다.  
즉, smokeping, RANCID 등과 같이 기본 저장소에 없는 패키지들은 EPEL 저장소를 통해 설치할 수 있습니다.

## EPEL 저장소 설치 방법

아래 명령어로 EPEL 저장소를 설치할 수 있습니다.

```bash
sudo amazon-linux-extras install epel -y
```

> 만약 `amazon-linux-extras: command not found` 오류가 발생한다면, 현재 인스턴스가 Amazon Linux 2가 아닐 수 있습니다.  
> Amazon Linux 버전은 아래 명령어로 확인할 수 있습니다.

```bash
cat /etc/system-release
```

---

## Amazon Linux 2에서 MySQL 8.0 설치

1. **MySQL 8.0 저장소 추가**

```bash
sudo rpm -Uvh https://repo.mysql.com/mysql80-community-release-el7-3.noarch.rpm
```

2. **MySQL 8.0 설치**

```bash
sudo yum install -y mysql-community-server
```

3. **MySQL 서비스 시작 및 부팅 시 자동 시작 설정**

```bash
sudo systemctl start mysqld
sudo systemctl enable mysqld
```

4. **MySQL 초기 비밀번호 확인**

```bash
sudo grep 'temporary password' /var/log/mysqld.log
```

5. **MySQL 접속 및 초기 설정**

```bash
mysql -u root -p
```
(위에서 확인한 임시 비밀번호 입력)

6. **비밀번호 변경 및 보안 설정**

```sql
ALTER USER 'root'@'localhost' IDENTIFIED BY '새로운_비밀번호!';
```

---

## 참고

- Amazon Linux 2 공식 문서: https://docs.aws.amazon.com/ko_kr/AWSEC2/latest/UserGuide/amazon-linux-2.html
- MySQL 공식 설치 가이드: https://dev.mysql.com/doc/mysql-yum-repo-quick-guide/en/


