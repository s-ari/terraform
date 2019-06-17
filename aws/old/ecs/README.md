# Terraform v0.9.9

## Crate AWS ECS Cluster

* Set up resources
  * ECS instance iam role
  * VPC (vpc/subnet/gateway/route table)
  * ECS instance (put userdata)
  * ECS (cluster/task/service)

* Edit ecs cluster name in ecs_config.sh.

```
user_data/ecs_config.sh

#!/bin/bash
echo ECS_CLUSTER=<CLUSTER NAME> >> /etc/ecs/ecs.config

```

* Edit image regitry in service.json .

```
[
  {
    "name": "web",
    "image": "<REGISTRY>",
    "cpu": 1024,
    "memory": 128,
    "essential": true,
    "command": ["tail","-f","/dev/null"],
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ]
  }
]

```

```
terraform apply
```
