provider "datadog" {
  api_key = "xxx"
  app_key = "xxx"
}
resource "datadog_synthetics_test" "test_api" {
  type = "api"
  subtype = "http"
  request = {
    method = "GET"
    url = "https://www.example.org"
  }
  request_headers = {
    Content-Type = "application/json"
    Authentication = "Token: 1234566789"
  }
  assertions = [
    {
      type = "statusCode"
      operator = "is"
      target = "200"
    }
  ]
  locations = [ "aws:eu-central-1" ]
  options = {
    tick_every = 900
  }
  name = "An API test on example.org"
  message = "Notify @pagerduty"
  tags = ["user:alan", "env:test"]

  status = "live"
}