locals {
  scope = "project:aws-sre-portfolio"

  # Choose your own thresholds and explain them in the README.
  host_monitors = {
    cpu = {
      name  = "High CPU on {{host.name}}"
      query = "avg(last_5m):avg:system.cpu.user{${local.scope}} by {host} > 85"
    }
    disk = {
      name  = "Disk above 85% on {{host.name}}"
      query = "max(last_5m):max:system.disk.in_use{${local.scope}} by {host,device} > 0.85"
    }
  }
}

resource "datadog_monitor" "host" {
  for_each = local.host_monitors
  name     = each.value.name
  type     = "metric alert"
  query    = each.value.query
  message  = "Investigate on the SRE Portfolio dashboard. Runbook: docs/runbook.md ${var.notify}"
  tags     = [local.scope, "managed-by:terraform"]
}

# TODO
# - service check monitor: "datadog.agent.up".over("project:aws-sre-portfolio").by("host").last(2).count_by_status()
# - apache.can_connect on role:web hosts
# - running containers per host below 3 (docker.containers.running)