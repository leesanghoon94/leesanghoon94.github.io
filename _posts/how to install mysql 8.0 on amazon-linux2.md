how to install mysql 8.0 on amazon-linux2

epel (extra package)

EPEL이란 무엇인가?

리눅스에 smokeping이라던가, RANCID 같은 내가 원하는 도구를 설치하려고 할 때 `epel` 이라는걸 먼저 설치해야한다는 문구가 뜬적이 있다. 그 당시에는 설치가 급급하여 그냥 매뉴얼에 나와있는 그대로 따라서만 했는데, SRE/DevOps로 직군이 바뀐 지금 업무를 하기 위해서 알아야 할 가장 기본 중에 기본인것 같아서 정리해보려고 한다.

EPEL (Extra Packages for Enterprise Linux)

약자를 풀어써보니 개념이 명확해진다. ‘기업용 리눅스를 위한 추가 패키지’

근데 찾아보니 단순하게 EPEL이라고 부르기 보다는 [EPEL 저장소] 라고 부르는 것 같다.

그럼 왜 이런 추가 패키지 저장소가 필요한걸까?

RHEL 이나 CentOS에 기본적으로 탑재되어있지 않는 패키지를 제공하기 위해 이런 패키지 저장소가 필요하다.

즉, 내가 서두에서 언급했던 smokeping, RANCID 설치에 필요한 패키지들은 RHEL/CentOS에서 기본적으로 제공하는 패키지가 아니었기 때문에 EPEL을 통해 설치가 필요했던 것이다.

EPEL 설치는 아래 명령어로 간단하게 가능하다.



`amazon-linux-extras: command not found` 오류가 발생하면 인스턴스가 Amazon Linux 2 AMI로 실행되지 않은 것입니다(Amazon Linux AMI를 사용하고 있는 것일 수 있음). 다음 명령을 사용하여 Amazon Linux 버전을 볼 수 있습니다.

cat /etc/system-release

