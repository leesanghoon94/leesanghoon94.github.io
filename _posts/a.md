---

environment_ec2.example: Still creating... [10m1s elapsed]
╷
│ Error: waiting for Cloud9 EC2 Environment (f41020137b8a4375a738aaf010ecbac7) create: timeout while waiting for state to become 'CREATED' (last state: 'CREATING', timeout: 10m0s)
│
│ with aws_cloud9_environment_ec2.example,
│ on cloud.tf line 1, in resource "aws_cloud9_environment_ec2" "example":
│ 1: resource "aws_cloud9_environment_ec2" "example" {
│
╵
╷
│ Error: creating Auto Scaling Group (terraform-20240307193304525000000003): ValidationError: Invalid launch template version: either '$Default', '$Latest', or a numeric version are allowed.
│ status code: 400, request id: 5588ddd7-07ad-40ec-bc38-951619afd152
│
│ with aws_autoscaling_group.name,
│ on ecs.tf line 20, in resource "aws_autoscaling_group" "name":
│ 20: resource "aws_autoscaling_group" "name" {
│
╵
╷
│ Error: creating ELBv2 application Load Balancer (elb): InvalidConfigurationRequest: Security group 'sg-0e279b358c04909fd' does not belong to VPC 'vpc-0bfd955765c048b63'
│ status code: 400, request id: 7c6a8da9-7bd4-4c00-997d-e66d389b0a80
│
│ with aws_lb.name,
│ on lb.tf line 1, in resource "aws_lb" "name":
│ 1: resource "aws_lb" "name" {
│
╵
╷
│ Error: creating ELBv2 Target Group (front-tg): ValidationError: 1 validation error detected: Value 'http' at 'protocol' failed to satisfy constraint: Member must satisfy enum value set: [UDP, TCP, TCP_UDP, HTTP, HTTPS, TLS]
│ status code: 400, request id: 46880d19-71f2-49a9-83cf-ed5d806d5fd7
│
│ with aws_lb_target_group.front,
│ on lb.tf line 15, in resource "aws_lb_target_group" "front":
│ 15: resource "aws_lb_target_group" "front" {
│
╵
╷
│ Error: creating ELBv2 Target Group (back-tg): ValidationError: 1 validation error detected: Value 'http' at 'protocol' failed to satisfy constraint: Member must satisfy enum value set: [UDP, TCP, TCP_UDP, HTTP, HTTPS, TLS]
│ status code: 400, request id: bcfd1a76-ae54-49b2-b821-fa54e646aa19
│
│ with aws_lb_target_group.back,
│ on lb.tf line 24, in resource "aws_lb_target_group" "back":
│ 24: resource "aws_lb_target_group" "back" {
│
╵
╷
│ Error: creating RDS DB Instance (terraform-20240307193317422200000008): InvalidParameterCombination: The DB instance and EC2 security group are in different VPCs. The DB instance is in vpc-0bfd955765c048b63 and the EC2 security group is in vpc-0d9359817d1e8e41e
│ status code: 400, request id: 2e2c68f9-ee85-424b-8c7c-a1e1e55eb879
│
│ with aws_db_instance.mydb,
│ on rds.tf line 1, in resource "aws_db_instance" "mydb":
│ 1: resource "aws_db_instance" "mydb" {
│
╵
