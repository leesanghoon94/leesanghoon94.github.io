the strace command in linux

1. 개요
   이 기사에서는 Linux의 도구 strace를 살펴보겠습니다. 간단한 소개부터 시작한 다음 strace의 몇 가지 사용법을 따르겠습니다.

2. strace
   strace는 Linux의 진단 도구입니다. 명령으로 생성된 모든 시스템 호출을 가로채서 기록합니다. 또한 프로세스로 전송된 모든 Linux 신호도 기록합니다. 그런 다음 이 정보를 사용하여 프로그램을 디버깅하거나 진단할 수 있습니다. 명령의 소스 코드를 쉽게 사용할 수 없는 경우 특히 유용합니다.

3. 설치
   Ubuntu와 같은 Debian 기반 Linux에서는 apt-get을 사용하여 strace를 설치할 수 있습니다.

$ apt-get 설치 -y strace

반면에 CentOS와 같은 RHEL 기반 Linux의 경우 yum을 사용하여 strace를 설치합니다.

$ 냠 설치 -y strace

4. 기본 사용법
   가장 간단한 형태로, 추적하려는 명령 뒤에 strace를 호출할 수 있습니다.

$ strace pwd
execve("/usr/bin/pwd", ["pwd"], 0x7fffcb3aa770 /_ 9 변수 _/) = 0
brk(NULL) = 0x5631e77f6000
Arch*prctl(0x3001 /\* ARCH*??? \*/, 0x7ffdb256c5e0) = -1 EINVAL(잘못된 인수)
access("/etc/ld.so.preload", R_OK) = -1 ENOENT (해당 파일이나 디렉터리 없음)
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
...(후속 출력이 잘림)
복사
위의 예에서 strace는 pwd 명령을 실행합니다. 그 후 strace는 pwd가 수행한 모든 syscall을 가로채서 기록합니다. 마지막으로 명령이 반환되면 기록된 syscall과 신호가 콘솔에 표시됩니다.

첫째, 출력의 각 줄은 명령에 의해 생성된 하나의 syscall을 나타냅니다. 이 예에서 첫 번째 줄은 명령 시작 시 execve syscall이 호출된다는 것을 보여줍니다. execve는 첫 번째 인수가 참조하는 프로그램을 실행하는 시스템 호출입니다.

그러면 우리는 strace는 syscall과 관련된 정확한 인수도 표시한다는 것을 알 수 있습니다. 특히 syscall은 /usr/bin/pwd 경로에서 바이너리를 실행하고 'pwd'를 첫 번째 인수로 전달합니다. 또한 syscall의 종료 코드는 등호 옆에 표시됩니다. 이 경우 syscall은 성공을 나타내는 종료 코드 0을 반환합니다.

마찬가지로 오류가 발생하는 syscall에는 오류 종료 코드와 설명이 표시됩니다.

access("/etc/ld.so.preload", R_OK) = -1 ENOENT (해당 파일이나 디렉터리 없음)

5. 실행 중인 프로세스에 strace 연결
   실행 중인 프로세스에 strace를 연결하려면 -p 플래그 뒤에 PID를 사용하면 됩니다.

sh -c 'echo $$; exec sleep 60'

strace -p PID

6. 환경 변수 목록 변경
   strace를 사용하면 추적 중인 프로세스에 의해 상속된 환경 변수 목록을 변경할 수 있습니다. 추가 환경 변수를 프로세스에 전달하려면 -E 플래그를 사용할 수 있습니다.

$ strace -E var1=val1 비밀번호
복사
위의 예에서 환경 변수 var1은 val1로 설정됩니다. 그런 다음 이 환경 변수는 프로세스 pwd에 전달됩니다.

마찬가지로 동일한 플래그를 사용하여 프로세스가 환경 변수를 상속하는 것을 방지할 수 있습니다.
strace -E var1 비밀번호
복사
값을 지정하지 않으면 환경 변수가 프로세스에 의해 상속되지 않습니다.

7. 특정 사용자로 명령 실행
   다른 사용자로서 프로그램을 실행하고 추적하려면 -u 플래그와 사용자 이름을 차례로 사용할 수 있습니다. 이 옵션의 전제 조건 중 하나는 루트 사용자로 strace를 실행해야 한다는 것입니다.

사용자 "baeldung"으로 실행하려면 -u 플래그와 사용자 이름을 차례로 사용할 수 있습니다.

# strace -u baeldung whoami

복사
위의 예에서 strace는 사용자 baeldung으로 whoami 명령을 실행합니다.

8. 타이밍 정보 얻기 strace를 사용하여 일부 타이밍 및 지속 시간 정보를 얻을 수도 있습니다.  
   예를 들어, 플래그 -t를 사용하여 각 시스템 호출의 타임스탬프를 표시할 수 있습니다.  
   $ strace -t 누가미 06:02:38 execve("/usr/bin/whoami", ["누가미"], 0x7ffdc4811038 /_ 12 변수 _/) = 0 -TRUNCATED- 복사  
    또한 플래그 -tt를 사용하여 마이크로초 단위의 타임스탬프도 얻을 수 있습니다.899089 execve("/usr/bin/whoami", ["whoami"], 0x7fff396d2898 /_ 12 vars _/) = 0 -TRUNCATED- Copy  
   마지막으로, 플래그 -T를 사용하여 각 시스템 호출의 지속 시간을 표시할 수 있습니다:  
   $ strace -T whoami execve("/usr/bin/whoami", ["whoami"], 0x7fff0493d078 /_ 12 vars _/) = 0 <0.000274> -TRUNCATED- 복사 -T 플래그를 사용하면 종료 코드 옆에 시스템 호출 지속 시간(초)을 추가하는 스트레이스가 표시됩니다. 위의 예에서는 명령이 0.000274초 동안 syscall 실행에 소요되었습니다.

9. 통계보고
   강력한 진단 도구인 strace는 추적한 프로그램에 대한 일부 통계를 계산하고 보고할 수 있습니다.
   To get a summary of the command, we can use the flag -c:

```
strace -c whoami
baeldung
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 18.62    0.000264          26        10           close
 15.16    0.000215          16        13           mmap
 12.27    0.000174          29         6           openat
-TRUNCATED-
  0.00    0.000000           0         1         1 access
  0.00    0.000000           0         1           execve
  0.00    0.000000           0         2         1 arch_prctl
------ ----------- ----------- --------- --------- ----------------
100.00    0.001418                    68         4 total
```

-c 플래그를 사용하면 strace는 각 syscall 및 신호 대신 실행된 명령의 요약을 표시합니다.

출력에서 볼 수 있듯이 요약은 결과를 syscall별로 그룹화합니다.

왼쪽부터 시작하여 첫 번째 열에는 이 syscall에 소요된 시간이 백분율로 표시됩니다. 그런 다음 두 번째 열에서는 동일한 측정값을 초 단위로 설명합니다. usecs/call 열의 값은 각 호출에 소비된 평균 마이크로초를 나타냅니다. 마지막으로 네 번째 열과 다섯 번째 열은 각각 총 호출 수와 오류 수를 보고합니다.

참고로 -c 플래그는 실행된 명령어의 요약만 표시합니다. 일반 출력과 요약을 표시하려면 대신 -C 플래그를 사용할 수 있습니다.
9.2. 결과를 열별로 정렬
-S 플래그를 사용하여 다른 열을 기준으로 요약 결과를 정렬할 수 있습니다. 예를 들어 오류 수를 기준으로 결과를 내림차순으로 정렬할 수 있습니다.

```
strace -c -S errors whoami
baeldung
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
  2.37    0.000055          27         2         2 connect
  1.68    0.000039          39         1         1 access
  3.49    0.000081          40         2         1 arch_prctl
-TRUNCATED-
  8.30    0.000193         193         1           execve
  1.46    0.000034          34         1           geteuid
  8.56    0.000199          33         6           openat
------ ----------- ----------- --------- --------- ----------------
100.00    0.002324                    68         4 total
```

10. 추적 표현
    strace는 strace의 여러 측면을 변경할 수 있는 풍부한 표현식 세트를 지원합니다. 예를 들어 표현식을 사용하면 syscall 이름과 종료 코드를 기준으로 출력을 필터링할 수 있습니다. 또한 원하지 않는 텍스트를 줄이기 위해 출력 형식을 지정할 수 있습니다. 마지막으로, 이 표현은 결함 주입과 지연 주입을 통한 syscall 간섭도 지원합니다.

10.1. 일반 구문
일반적으로 -e 플래그가 표현식 앞에 옵니다. 그런 다음 표현식은 키-값 쌍으로 지정됩니다.

-e 한정자=[!]값[,값]

값 앞에 느낌표를 지정하여 값을 부정할 수 있습니다. 또한 여러 값을 쉼표로 구분할 수 있습니다.

10.2. 예선
한정자는 추적, 상태, 신호, 자동, abbrev, verbose, 원시, 읽기, 쓰기, 오류 및 삽입 목록에서 나와야 합니다.

이러한 한정자는 해당 기능에 따라 다음 그룹으로 느슨하게 그룹화될 수 있습니다.

필터링(추적, 상태, 신호, 조용함)
출력 형식(abbrev, verbose, raw)
syscall 변조(오류, 주입)
파일 설명자 데이터 덤핑(읽기, 쓰기)
10.3. 가치
표현식의 값은 한정자 종속 값을 나타냅니다. 또한 단일 키에 대한 여러 값을 쉼표로 구분할 수 있습니다.

11. 표현식을 사용한 필터링
    11.1. Syscall 이름으로 출력 필터링

11.1. Syscall 이름으로 출력 필터링
필터링 한정자를 사용하면 strace의 출력을 줄일 수 있습니다. 예를 들어, fstat syscall만 출력할 수 있습니다:

```
strace -e trace=fstat whoami
fstat(3, {st_mode=S_IFREG|0644, st_size=9394, ...}) = 0
fstat(3, {st_mode=S_IFREG|0755, st_size=2029224, ...}) = 0
-TRUNCATED-
fstat(3, {st_mode=S_IFREG|0644, st_size=494, ...}) = 0
fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(0x88, 0x1), ...}) = 0
baeldung
+++ exited with 0 +++
```

11.2. 반품 상태별로 출력 필터링
상태 한정자를 사용하면 반환 상태를 기준으로 syscall을 필터링할 수 있습니다. 예를 들어, 성공하지 못한 syscall만 표시할 수 있습니다.
strace -e status=unfinished,unavailable whoami

11.3. 신호별 출력 필터링
syscall 외에도 strace는 프로세스에서 수신한 모든 신호도 기록합니다. 기본적으로 이러한 녹음된 신호는 syscall과 함께 출력에 표시됩니다. 한정자 신호를 사용하여 이러한 신호를 필터링할 수 있습니다. 예를 들어, SIGBUS 신호만 추적할 수 있습니다.

$ strace -e 신호=SIGBUS whoami
복사
신호 한정자의 유효한 값은 모두 표준 Linux 신호입니다.

11.4. 추가 정보 메시지 억제
syscall 및 신호 외에도 strace는 일부 정보 메시지도 표시합니다. 예를 들어 strace는 프로세스가 종료될 때마다 메시지를 인쇄합니다.

+++ 0으로 종료됨 +++
복사
이러한 메시지를 표시하지 않으려면 Quiet 한정자를 사용할 수 있습니다.

$ strace -e Quiet=Whoami 종료
복사
Attached, Exit, Path-Resolve, Personality, Thread-Execve, Superseded를 포함하여 이 한정자를 사용하여 메시지를 억제할 수 있습니다.

12. 출력 형식 지정
    12.1. Syscall 인수 역참조
    verbose 한정자를 사용하면 strace가 syscall 인수를 역참조된 형식으로 표시하도록 할 수 있습니다. 역참조된 형식으로 인수를 표시하는 것이 포인터 값보다 더 유용합니다. 이것이 모든 syscall 인수가 기본적으로 역참조되는 이유입니다. 즉, verbose 한정자의 기본값은 all입니다.

한정자가 작동하는 모습을 보려면 먼저 모든 syscall에 대해 자세한 표현을 비활성화하면 됩니다.

12.1. Syscall 인수 역참조
verbose 한정자를 사용하면 strace가 syscall 인수를 역참조된 형식으로 표시하도록 할 수 있습니다. 역참조된 형식으로 인수를 표시하는 것이 포인터 값보다 더 유용합니다. 이것이 모든 syscall 인수가 기본적으로 역참조되는 이유입니다. 즉, verbose 한정자의 기본값은 all입니다.

한정자가 작동하는 모습을 보려면 먼저 모든 syscall에 대해 자세한 표현을 비활성화하면 됩니다.

```
strace -e verbose=none whoami
execve(0x7fff4e3efdc0, 0x7fff4e3f1100, 0x7fff4e3f1110) = 0
brk(0)                                  = 0x55970f3be000
arch_prctl(0x3001, 0x7fff2630af10)      = -1 EINVAL (Invalid argument)
-TRUNCATED-
```

12.2. Syscall을 줄여서
일부 syscall의 역참조된 인수는 매우 길어서 출력이 복잡해질 수 있습니다. 따라서 strace는 기본 동작으로 abbrev=all 표현식을 적용합니다. 예를 들어, abbrev에 대한 기본 표현식을 재정의하지 않으면 fstat syscall의 레코드가 축약됩니다.

```
strace -e whoami
-TRUNCATED-
fstat(3, {st_mode=S_IFREG|0644, st_size=971, ...}) = 0
-TRUNCATED-
```

12.3. 디코딩되지 않은 인수 표시
원시 한정자를 사용하면 strace는 기본 char 값 대신 syscall 인수 주소를 표시합니다.

기본적으로 모든 인수는 해당 문자 표현으로 디코딩됩니다.
$ 스트레이스 후아미
execve("/usr/bin/whoami", ["whoami"], 0x7ffd9bc11880 /_ 12 변수 _/) = 0
brk(NULL) = 0x5574c7e68000 -잘림-
복사
raw=execve 표현식을 설정해 보겠습니다.

$ strace -e raw=execve whoami
execve(0x7ffec1f3d6c0, 0x7ffec1f3ea00, 0x7ffec1f3ea10) = 0
brk(NULL) = 0x5574c7e68000 -잘림-
복사
관찰할 수 있듯이 execve syscall에 대한 인수 포인터는 실제 값 대신 표시됩니다.

13. 시스템콜 변조
    strace 표현의 가장 강력한 기능 중 하나는 주입 및 오류 한정자를 사용하여 syscall 동작을 변경하는 기능입니다. 이 기능은 단위 테스트에서 메서드를 조롱하는 것과 매우 유사합니다. 예를 들어, 명령에 의해 호출될 때마다 항상 오류를 반환하도록 syscall을 모의할 수 있습니다. syscall을 조작하는 기능은 다양한 조건에서 프로그램을 실험하는 데 유용합니다.

일반적으로 주입에 대한 표현식은 다음과 같이 표현될 수 있습니다.

--inject=syscall_set[:error=errno|:retval=값][:signal=sig][:syscall=syscall][:delay_enter=delay][:delay_exit=delay][:when=expr]
복사
error와 retval은 상호 배타적입니다. 즉, 일련의 syscall에 대해 오류를 주입하는 경우 동일한 syscall 세트에 대해 retval을 주입할 수 없습니다.

일반적인 표현에서 추론할 수 있듯이 주입 한정자는 매우 유연합니다. 특히, syscall이 시작될 때 약간의 지연을 삽입하거나 Delay_enter를 사용하여 종료할 수 있습니다. 지연 종료. 또한 when 하위 표현식을 통해 주입을 제어할 수 있습니다.

반면에 Qualifier Fault는 Qualifier Inject의 구체적인 경우입니다. 구체적으로 오류 한정자는 오류 주입에만 사용할 수 있습니다. 따라서 이 문서에서는 inject 한정자만 살펴보겠습니다.

13.1. Syscall에 오류 주입
fstat syscall에 오류를 삽입해 보겠습니다. 특히 fstat 호출을 EPERM 종료 코드로 대체합니다.

$ strace -e 주입=fstat:오류=EPERM whoami
execve("/usr/bin/whoami", ["whoami"], 0x7ffc481220a0 /_ 12 변수 _/) = 0 -잘림-
fstat(3, 0x7ffd9337e640) = -1 EPERM(작업이 허용되지 않음) (INJECTED) -잘림-
복사
fstat syscall이 항상 종료 상태 -1 EPERM으로 반환되는 방식에 유의하세요. 또한 strace는 오류가 삽입되었음을 명확하게 하기 위해 종료 상태에 텍스트(INJECTED)로 주석을 답니다.

13.2. 결함이 언제 주입되는지 제어
호출할 때마다 오류를 주입하는 대신 when 하위 표현식을 사용하여 주입 발생을 추가로 제어할 수 있습니다. 예를 들어 fstat의 두 번째 호출에서만 오류 오류 EPERM을 삽입할 수 있습니다.

$ strace -e 주입=fstat:error=EPERM:when=2 whoami
복사
위의 예에서 strace는 fstat의 두 번째 호출에서만 오류를 주입합니다. 세 번째와 네 번째 호출이 있으면 오류가 주입되지 않습니다. 두 번째 호출 이후에 오류를 주입하려면 더하기 기호를 사용할 수 있습니다.

$ strace -e 주입=fstat:error=EPERM:when=2+ whoami
복사
마지막으로, 주입이 특정 단계 크기를 따르도록 할 수도 있습니다. 예를 들어, 두 번째 호출과 후속 호출에 2단계 크기로 오류를 주입할 수 있습니다. 구체적으로 두 번째, 네 번째, 여섯 번째 호출 등에 오류를 주입하고 싶습니다.

이를 위해 더하기 기호 뒤에 단계 크기를 2로 지정합니다.

$ strace -e 주입=fstat:error=EPERM:when=2+2 후아미

13.3. Syscalls의 지연 소개
Delay_enter 한정자를 사용하면 syscall 호출 전에 약간의 지연을 주입할 수 있습니다. 마찬가지로, 한정자 Delay_exit를 사용하여 syscall이 반환된 후 지연을 주입할 수 있습니다. 두 한정자 모두 마이크로초 단위의 시간 값을 허용합니다.

예를 들어, 명령이 fstat syscall을 호출하기 직전에 2초(2000000마이크로초) 지연을 유도할 수 있습니다.

$ strace -e 주입=fstat:delay_enter=2000000 whoami
복사
반면에, syscall 이후에 지연을 주입하기 위해 우리는 Delay_exit 표현식을 사용할 것입니다:

$ strace -e 주입=fstat:delay_exit=2000000 whoami
복사
두 예제 사이의 중요한 차이점은 지연 주입 순서입니다. 첫 번째 예에서는 fstat가 호출되기 전에 2초 지연이 도입되었습니다. 반대로 두 번째 예에서는 fstat 시스템 호출이 반환된 후 2초의 지연을 삽입합니다.

14. 파일 설명자 데이터 덤핑
    14.1. 모든 입력 활동에 대한 파일 설명자의 데이터 덤프
    한정자 읽기를 사용하여 다음을 수행할 수 있습니다. 모든 입력 활동에서 파일 설명자의 16진수 데이터를 덤프합니다. 파일 설명자 3에 입력 활동이 있을 때마다 데이터를 덤프해 보겠습니다.

$ strace -e read=3 whoami
복사
이제 파일 설명자 3에 읽기 syscall이 있을 때마다 출력에 16진수 데이터 블록이 포함됩니다.

14.2. 모든 출력 활동에서 파일 설명자의 데이터 덤프
write syscall이 호출될 때마다 파일 설명자에 데이터를 표시할 수 있습니다. 예를 들어, 모든 출력 활동에서 파일 설명자 5의 데이터를 덤프하려면 write=5 표현식을 사용합니다.

$ strace -e write=5 whoami
복사 15. 결론
이 글에서는 strace를 진단 도구로 살펴보았습니다. 우리는 strace에 대한 기본적인 소개부터 시작했습니다. 그런 다음 기사에서는 실행 중인 프로세스에 strace를 연결하고, 환경 변수를 수정하고, 통계를 가져오는 플래그를 시연했습니다.

## 다음 섹션에서는 strace 표현식을 철저하게 살펴보았습니다. 출력 필터링을 위한 표현식부터 시작했습니다. 그런 다음 출력 형식을 지정하는 표현식을 보여주었습니다. 그 외에도 syscall을 조작하는 표현도 살펴보았습니다. 마지막으로 파일 설명자의 데이터를 덤프하는 표현식을 도입했습니다.

> https://www.baeldung.com/linux/strace-command
