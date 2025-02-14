## Linux 사용자 관리의 기초

Linux 시스템에서 사용자 관리는 시스템 보안과 접근 제어의 핵심입니다. 이 글에서는 Linux의 사용자 유형, 관련 파일, 그리고 사용자 관리 명령어에 대해 알아보겠습니다.

### 1. Linux 사용자의 유형

Linux에는 세 가지 주요 사용자 유형이 있습니다:

- 표준 사용자
- 관리자 권한을 가진 사용자
- 루트 사용자

관리자 권한을 가진 사용자와 루트 사용자는 비슷해 보이지만, 관리자 권한 사용자의 기능은 제한될 수 있습니다.

### 2. 사용자 정보 확인

현재 로그인한 사용자 정보를 확인하는 방법:


>whoami  
>id


다른 사용자의 정보를 확인하려면:

```bash
id [username]
```

### 3. UID와 GID

- UID (User IDentifier): 사용자를 식별하는 고유 번호
- GID (Group IDentifier): 그룹을 식별하는 고유 번호

UID 할당 기준:

- 0: 루트 사용자
- 1-99: 시스템 정의 계정
- 100-999: 시스템 및 관리 계정
- 1000 이상: 일반 사용자

GID 할당 기준:

- 0: 루트 그룹
- 1-99: 시스템 및 애플리케이션 그룹
- 100 이상: 사용자 그룹

### 4. 사용자 관련 주요 파일

1. `/etc/passwd`: 사용자 계정 정보

   - 형식: `username:password:UID:GID:comment:home_directory:shell`

2. `/etc/shadow`: 암호화된 비밀번호 및 계정 정보

   - 보안상의 이유로 비밀번호는 여기에 저장됩니다.

3. `/etc/group`: 그룹 정보

   - 형식: `group_name:password:GID:user_list`

4. `/etc/gshadow`: 그룹 비밀번호 정보 (거의 사용되지 않음)

### 5. 사용자 생성

두 가지 명령어: `useradd`와 `adduser`

- `useradd`: 저수준 유틸리티, 기본 설정만 제공
- `adduser`: `useradd`를 기반으로 한 대화형 스크립트, 더 많은 정보 입력 가능

예시:

```bash
sudo useradd testuser1
sudo adduser testuser2
```

### 6. 사용자 수정

1. 비밀번호 변경:

   ```bash
   sudo passwd [username]
   ```

2. 사용자 속성 변경 (`usermod` 명령어 사용):
   - 기본 그룹 변경: `sudo usermod -g [group] [username]`
   - 보조 그룹 추가: `sudo usermod -aG [group] [username]`
   - 홈 디렉토리 변경: `sudo usermod -d [new_home] -m [username]`
   - 셸 변경: `sudo usermod -s [new_shell] [username]`

### 7. 사용자 삭제

```bash
sudo userdel [username]
```

- 홈 디렉토리와 메일 스풀도 삭제하려면: `sudo userdel -r [username]`

### 주의사항

- 사용자 관리 작업은 신중히 수행해야 합니다.
- 변경 사항을 적용하기 전에 항상 백업을 만들고 변경 사항을 확인하세요.
- 루트 권한으로 작업할 때는 특히 주의가 필요합니다.
