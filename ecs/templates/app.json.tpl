[
  {
    "essential": true,
    "memory": 256,
    "name": "myapp",
    "cpu": 256,
    "image": "${REPOSITORY_URL}:latest",
    "workingDirectory": "/app",
    "command": ["npm", "start"],
    "portMappings": [
        {
            "containerPort": 3000,
            "hostPort": 3000
        }
    ],
    "environment"                   : [
      {
        "name" : "DD_AGENT_HOST",
        "value" : "datadog-agent"
      },
      {
        "name" : "DD_TRACE_AGENT_PORT",
        "value" : "8126"
      }
    ]
  }
]