provider "aws" {
  region = "eu-west-1"
}

provider "datadog" {
  api_key = "xxx"
  app_key = "xxx"
}

variable "datadog_aws_integration_external_id" {
default = "xxx"   #check that Terraform updates this correctly: check trust relationship for role in AWS console 
description = ""
}

data "aws_iam_policy_document" "datadog_aws_integration_assume_role" {
statement {
actions = ["sts:AssumeRole"]

principals {
  type = "AWS"
  identifiers = ["arn:aws:iam::464622532012:root"]
}
condition {
  test = "StringEquals"
  variable = "sts:ExternalId"

  values = [
    "${var.datadog_aws_integration_external_id}"
  ]
}
}
}

data "aws_iam_policy_document" "datadog_aws_integration" {
statement {

actions = [
                "apigateway:GET",
                "autoscaling:Describe*",
                "budgets:ViewBudget",
                "cloudfront:GetDistributionConfig",
                "cloudfront:ListDistributions",
                "cloudtrail:DescribeTrails",
                "cloudtrail:GetTrailStatus",
                "cloudwatch:Describe*",
                "cloudwatch:Get*",
                "cloudwatch:List*",
                "codedeploy:List*",
                "codedeploy:BatchGet*",
                "directconnect:Describe*",
                "dynamodb:List*",
                "dynamodb:Describe*",
                "ec2:Describe*",
                "ecs:Describe*",
                "ecs:List*",
                "elasticache:Describe*",
                "elasticache:List*",
                "elasticfilesystem:DescribeFileSystems",
                "elasticfilesystem:DescribeTags",
                "elasticloadbalancing:Describe*",
                "elasticmapreduce:List*",
                "elasticmapreduce:Describe*",
                "es:ListTags",
                "es:ListDomainNames",
                "es:DescribeElasticsearchDomains",
                "health:DescribeEvents",
                "health:DescribeEventDetails",
                "health:DescribeAffectedEntities",
                "kinesis:List*",
                "kinesis:Describe*",
                "lambda:AddPermission",
                "lambda:GetPolicy",
                "lambda:List*",
                "lambda:RemovePermission",
                "logs:TestMetricFilter",
                "logs:PutSubscriptionFilter",
                "logs:DeleteSubscriptionFilter",
                "logs:DescribeSubscriptionFilters",
                "rds:Describe*",
                "rds:List*",
                "redshift:DescribeClusters",
                "redshift:DescribeLoggingStatus",
                "route53:List*",
                "s3:GetBucketLogging",
                "s3:GetBucketLocation",
                "s3:GetBucketNotification",
                "s3:GetBucketTagging",
                "s3:ListAllMyBuckets",
                "s3:PutBucketNotification",
                "ses:Get*",
                "sns:List*",
                "sns:Publish",
                "sqs:ListQueues",
                "states:ListStateMachines",
                "states:DescribeStateMachine",
                "support:*",
                "tag:GetResources",
                "tag:GetTagKeys",
                "tag:GetTagValues",
                "xray:BatchGetTraces",
                "xray:GetTraceSummaries",
            ]

resources = ["*"]
}
}

resource "aws_iam_policy" "datadog_aws_integration" {
name = "DatadogAWSIntegrationPolicy-ap"
policy = "${data.aws_iam_policy_document.datadog_aws_integration.json}"
}

resource "aws_iam_role" "datadog_aws_integration" {
name = "DatadogAWSIntegrationRole-ap"
description = "Role for Datadog AWS Integration"
assume_role_policy = "${data.aws_iam_policy_document.datadog_aws_integration_assume_role.json}"
}

resource "aws_iam_role_policy_attachment" "datadog_aws_integration" {
role = "${aws_iam_role.datadog_aws_integration.name}"
policy_arn = "${aws_iam_policy.datadog_aws_integration.arn}"
}

# Create a new Datadog - Amazon Web Services integration
resource "datadog_integration_aws" "sandbox-account" {
    account_id = "xxx"
    role_name = "DatadogAWSIntegrationRole-ap"
    #filter_tags = ["region:eu-west-1"]
    host_tags = ["terraform:tf1"]
    account_specific_namespace_rules = {
        auto_scaling = false
        opsworks = false
    }
}