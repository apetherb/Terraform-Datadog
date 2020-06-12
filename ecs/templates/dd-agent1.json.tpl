[
    {
      "name": "datadog-agent",
      "image": "xxx.dkr.ecr.eu-west-1.amazonaws.com/datadog/agent:latest",
      "cpu": 10,
      "memory": 256,
      "essential": true,
      "environment"                   : [
      {
        "name" : "DD_API_KEY",
        "value" : "xxx"
      },
      {
        "name" : "DD_SITE",
        "value" : "datadoghq.com"
      },
      {
        "name" : "DD_HOSTNAME",
        "value" : "datadog-agent"
      },
      {
        "name" : "DD_TAGS",
        "value" : "name:TF"
      },
            {
        "name" : "DD_LOGS_ENABLED",
        "value" : "true"
      },
                 {
        "name" : "DD_APM_ENABLED",
        "value" : "true"
      },
                 {
        "name" : "DD_APM_NON_LOCAL_TRAFFIC",
        "value" : "true"
      },
            {
        "name" : "DD_LOGS_CONFIG_CONTAINER_COLLECT_ALL",
        "value" : "true"
      },
      {
        "name": "DD_ECS_COLLECT_RESOURCE_TAGS_EC2",
        "value": "true"
      }
    ],
      "portMappings": [
        {
          "containerPort": 8126,
          "hostPort": 8126
        },
        {
          "containerPort": 8125,
          "hostPort": 8125,
          "protocol": "udp"
        }
      ],
      "mountPoints": [
        {
          "containerPath": "/var/run/docker.sock",
          "sourceVolume": "docker_sock",
          "readOnly": true
        },
        {
          "containerPath": "/host/sys/fs/cgroup",
          "sourceVolume": "cgroup",
          "readOnly": true
        },
        {
          "containerPath": "/host/proc",
          "sourceVolume": "proc",
          "readOnly": true
        }
      ]
   }
]
