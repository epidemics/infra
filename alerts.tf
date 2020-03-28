resource "google_monitoring_uptime_check_config" "production-check-index" {
  display_name = "epidemicforecasting-uptime-check-production"
  timeout      = "5s"
  period       = "60s"

  http_check {
    path = "/"
    port = "80"
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = "epidemics-270907"
      host       = "epidemicforecasting.org"
    }
  }

}
