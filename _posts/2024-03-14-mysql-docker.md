---
layout: post
title: 도커컨테이너 로컬DB 연결
date:
categories: [Blogging]
tags:
---

### 로컬에서 서비스중인 MYSQL과 도커 컨테이너

---

Python의 SQLAlchemy를 사용하여 간단한 코드를 작성하고, 도커 컨테이너에서 호스트 머신에 접근하는 방법을 알아보겠습니다.

> SQLAlchemy를 이용한 연결 설정
> 먼저, Python 코드를 사용하여 MySQL과 연결하는 방법을 알아봅시다. 아래 코드를 참고하여 자신의 환경에 맞게 수정하세요.

```python
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# 로컬 MySQL 정보
DB_USER = 'your_username'
DB_PASSWORD = 'your_password'
DB_HOST = 'localhost'  # 대신 host.docker.internal
DB_PORT = 3306
DB_NAME = 'sample_db'

# 데이터베이스 URL 생성
DATABASE_URL = f'mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}'

# SQLAlchemy 엔진 생성
engine = create_engine(DATABASE_URL)

# 세션 생성
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Base 선언
Base = declarative_base()
```

위 코드에서 DB_USER, DB_PASSWORD, DB_HOST, DB_PORT, DB_NAME 등은 자신의 로컬 MySQL 데이터베이스 정보로 수정해주세요.

### 도커 컨테이너에서 연결

---

도커 컨테이너 내부에서 로컬 호스트에 연결하려면 host.docker.internal을 사용합니다.  
이는 도커 컨테이너 내에서 호스트 머신을 가리키는 주소입니다.

이제 이 코드를 사용하여 도커 컨테이너와 로컬 MySQL 데이터베이스를 연결하는 방법에 대해 알아보았습니다.

> 출처
>
> > https://shawn-dev.oopy.io/463a30bf-bf32-44e4-88be-8b4722e5549a  
> > https://marklee1117.tistory.com/93
