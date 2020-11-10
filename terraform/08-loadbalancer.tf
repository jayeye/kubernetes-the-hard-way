## Kubernetes Frontend Load Balancer

resource "google_compute_firewall" "healthz" {
  name                     = "${var.gcp_vpc_name}-allow-health-check"
  network                  = google_compute_network.this.self_link
  allow {
    protocol               = "tcp"
  }
  source_ranges            = [
                               "35.191.0.0/16",
                               "209.85.152.0/22",
                               "209.85.204.0/22",
                             ]
}

resource "google_compute_http_health_check" "this" {
  name                     = "kubernetes"
  description              = "Kubernetes Health Check"
  host                     = "kubernetes.default.svc.cluster.local"
  request_path             = "/healthz"
}

resource "google_compute_target_pool" "this" {
  name                     = "kubernetes-target-pool"
  health_checks            = [
                               google_compute_http_health_check.this.self_link
                             ]
  instances                = google_compute_instance.controller.*.self_link
}

resource "google_compute_forwarding_rule" "this" {
  name                     = "kubernetes-forwarding-rule"
  ip_address               = google_compute_address.this.address
  target                   = google_compute_target_pool.this.self_link
  port_range               = "6443"
}
