provider "datadog" {
  api_key = "xxx"
  app_key = "xxx"
}

# Create a new Datadog monitor
resource "datadog_monitor" "MonitorA" {
  name               = "Monitor CPU Usage"
  type               = "metric alert"
  message            = "Monitor triggered. Notify: @slack-channel"
  escalation_message = "Escalation message @pagerduty"

  query = "avg(last_1h):avg:aws.ec2.cpuutilization{host:i-0f6e8236d9f946361} by {host} > 80"

  thresholds = {
    ok                = 0
    warning           = 60
    warning_recovery  = 55
    critical          = 80
    critical_recovery = 75
  }

  notify_no_data    = false
  renotify_interval = 60

  notify_audit = false
  timeout_h    = 60
  include_tags = true

  # ignore any changes in silenced value; using silenced is deprecated in favor of downtimes
  lifecycle {
    ignore_changes = [silenced]
  }

  tags = ["env:prod", "user:Alan"]
}

resource "datadog_monitor" "MonitorB" {
  name               = "Monitor CPU Usage B"
  type               = "metric alert"
  message            = "Monitor triggered. Notify: @slack-channel"
  escalation_message = "Escalation message @pagerduty"

  query = "avg(last_1h):avg:aws.ec2.cpuutilization{host:i-0f6e8236d9f946361} by {host} > 80"

  thresholds = {
    ok                = 0
    warning           = 60
    warning_recovery  = 55
    critical          = 80
    critical_recovery = 75
  }

  notify_no_data    = false
  renotify_interval = 60

  notify_audit = false
  timeout_h    = 60
  include_tags = true

  # ignore any changes in silenced value; using silenced is deprecated in favor of downtimes
  lifecycle {
    ignore_changes = [silenced]
  }

  tags = ["env:prod", "user:Alan"]
}
