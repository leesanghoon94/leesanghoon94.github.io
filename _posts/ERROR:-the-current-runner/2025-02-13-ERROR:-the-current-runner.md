---
layout: post
title: "ERROR: the current runner"
date: 2025-02-13 18:20:20 +0900
categories: []
tags: []
---


# ERROR: the current runner

2025년에 쓴글을 모와서 git push을 보냈더니 workflow가 에러가 떴다.
에러 로그를 보니 

```console
Error: The current runner (ubuntu-24.04-x64) was detected as self-hosted because the platform does not match a GitHub-hosted runner image (or that image is deprecated and no longer supported).
In such a case, you should install Ruby in the $RUNNER_TOOL_CACHE yourself, for example using https://github.com/rbenv/ruby-build
You can take inspiration from this workflow for more details: https://github.com/ruby/ruby-builder/blob/master/.github/workflows/build.yml
$ ruby-build 3.1.4 /opt/hostedtoolcache/Ruby/3.1.4/x64
Once that completes successfully, mark it as complete with:
$ touch /opt/hostedtoolcache/Ruby/3.1.4/x64.complete
It is your responsibility to ensure installing Ruby like that is not done in parallel.
```

이 오류는 **GitHub Actions에서 Ruby 환경을 설정할 때 발생한 문제**입니다.  
주된 원인은 **현재 실행 중인 러너(ubuntu-24.04-x64)가 GitHub에서 공식 지원하는 환경이 아니거나, 사용 중인 이미지가 더 이상 지원되지 않기 때문**입니다.

---

##  문제 원인 분석
1. GitHub Actions에서 `ruby/setup-ruby` 액션을 실행했는데, 현재 사용 중인 **러너가 GitHub 공식 환경이 아님**으로 감지됨.
    - 공식 GitHub 호스팅 러너는 Ubuntu 22.04까지 지원되며, **Ubuntu 24.04는 아직 공식 지원되지 않을 가능성이 큼**.
    - 또는, `ubuntu-24.04`가 self-hosted 러너로 감지됨.

2. **GitHub Actions의 `setup-ruby`가 Ruby를 자동으로 설치하지 못함.**
    - 보통 공식 지원 환경이면 Ruby를 자동으로 설치해 주지만, 현재 러너에서는 **직접 설치해야 함**.

---

##  해결 방법
### **1️⃣ `ubuntu-latest` 또는 `ubuntu-22.04`로 변경**
GitHub Actions에서 기본 러너를 `ubuntu-latest` (현재는 `ubuntu-22.04`)로 변경하면 해결될 가능성이 큼.

#### **workflow 수정 (`.github/workflows/your-workflow.yml`)**
```yaml
jobs:
  build:
    runs-on: ubuntu-latest  # 또는 ubuntu-22.04로 변경
    steps:
      - uses: actions/checkout@v4
      - uses: ruby/setup-ruby@v1
        with:
          ruby-version: 3.1
          bundler-cache: true
```
✅ **이 방법이 가장 간단한 해결책**입니다.

---

### **2️⃣ Ruby를 수동으로 설치 (self-hosted 러너 사용 시)**
만약 self-hosted 러너를 사용 중이라면 Ruby를 직접 설치해야 합니다.

#### **🔹 Ruby 설치 스크립트 추가**
GitHub Actions의 `setup-ruby`가 실패할 경우, `rbenv`를 사용해 직접 Ruby를 설치하는 방식입니다.

```yaml
jobs:
  build:
    runs-on: self-hosted  # self-hosted 러너 사용 시
    steps:
      - uses: actions/checkout@v4
      - name: Install Ruby with rbenv
        run: |
          git clone https://github.com/rbenv/rbenv.git ~/.rbenv
          echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
          echo 'eval "$(rbenv init - bash)"' >> ~/.bashrc
          source ~/.bashrc
          git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
          ~/.rbenv/bin/rbenv install 3.1.4
          ~/.rbenv/bin/rbenv global 3.1.4
      - name: Verify Ruby Version
        run: ruby -v
```
✅ 이 방법을 사용하면 GitHub Actions에서 Ruby 3.1.4를 직접 설치하여 사용할 수 있습니다.

---

### **3️⃣ `setup-ruby` 액션에서 캐시 비활성화**
`setup-ruby`에서 `cache-version: 0` 옵션이 문제가 될 가능성이 있으므로, `cache-version`을 제거하거나 `cache: false`로 변경할 수도 있습니다.

```yaml
- uses: ruby/setup-ruby@v1
  with:
    ruby-version: 3.1
    bundler-cache: false  # 캐시 기능 비활성화
```

---

## ✅ 결론 (추천 해결 방법)
1. **가능하면 `runs-on: ubuntu-latest` 또는 `ubuntu-22.04`로 변경**.
2. **self-hosted 러너라면 rbenv를 사용해 직접 설치**.
3. `cache-version` 옵션을 제거하거나 `bundler-cache: false` 설정 시도.

어떤 환경에서 실행 중인지에 따라 적절한 방법을 선택하면 됩니다!  
