resource "google_compute_route" "this" {
  count = var.num_workers
  name = "${var.gcp_vpc_name}-route-10-200-${count.index}-0-24"
  network = google_compute_network.this.self_link
  dest_range = cidrsubnet(var.gcp_pod_cidr, 8, count.index)
  next_hop_ip = cidrhost(var.gcp_subnet_cidr, 20 + count.index)
}
