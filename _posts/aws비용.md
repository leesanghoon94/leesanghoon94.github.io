aws 모든 리소스를 clean up 을 했는데 요금이 나왓다
![image](/assets/img/screenshot/스크린샷%202024-02-10%20오후%205.24.15.png)

Ebs ecr에서 리소스를 삭제 하지 않아서 계속 요금이 나왔다

## AWS Budgets

```
  + AWS에서 발생한 비용과 사용량을 추적하고 대응하는 서비스
  + 사용자가 지정한 비용 이상으로 비용이 발생시 대응 가능
    + SNS수신 가능 = Lambda를 활용해 다양한 대응 가능
    + 대응(Action): 비용 이벤트에 따라 EC2/RDS정지, IAM 정책 활성화 등 가능
  + Lambda에 다양한 커스텀 로직 가능
    + RDS, SageMaker 등 기타 AWS 서비스들에 대한 중지 혹은 아카이빙 처리
    + Slack등에 알람 보내기
```
