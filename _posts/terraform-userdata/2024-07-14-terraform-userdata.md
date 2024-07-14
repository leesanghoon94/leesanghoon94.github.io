---
layout: post
title: "terraform-userdata"
date: 2024-07-14 22:53:14 +0900
categories: []
tags: []
---

> - <mark>**NOTE**:</mark> For accounts created after May 31, 2023, the EC2 console only supports creating Auto Scaling groups with launch templates. Creating Auto Scaling groups with launch configurations is not recommended but still available via the CLI and API until December 31, 2023.

테라폼으로 오토스케일 만들었는데  
launch configurations가 더이상 추천되지 않는다고 해서  
launch template 으로 다시 만들었다

- **Error** creating EC2 Launch Template (acg_launch_template): InvalidUserData.Malformed: Invalid BASE64 encoding of user data.

```terraform
resource "aws_launch_template" "name" {
    name = "acg_launch_template"
    image_id = "ami-04599ab1182cd7961"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.inastance.id]
    key_name = local.key_name
    user_data = filebase64("userdata.sh")

    block_device_mappings {
        device_name =
            ebs {
            volume_size = 8
            }

        }
}
```

쉘스크립트로 만든 유저데이터파일을 file("userdata.sh") 넣어줬는데  
런치템플릿에서는 base64로 엔코딩을 해줘야되는것 같다  
file을 넣어주고 싶으면 **filebase64()**  
EOF (End Of File)

```
user_data = <<EOF
#! /bin/bash
sudo yum install -y httpd
sudo service httpd start
EOF
```
