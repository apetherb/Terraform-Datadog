provider "datadog" {
  api_key = "xxx"
  app_key = "xxx"
} 

# Create a new Datadog service level objective
resource "datadog_service_level_objective" "SLO_example" {
  name               = "Example Monitor SLO"
  type               = "monitor"
  description        = "My custom monitor SLO"
  monitor_ids = [9955994]

  thresholds {
    timeframe = "7d"
    target = 99.9
    warning = 99.99
  }

  thresholds {
    timeframe = "30d"
    target = 99.9
    warning = 99.99
  }

  tags = ["env:prod", "user:alan"]
}