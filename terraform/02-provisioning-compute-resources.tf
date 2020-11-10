# Provisioning Compute Resources

## Networking

### Virtual Private Cloud Network

resource "google_compute_network" "this" {
  name = var.gcp_vpc_name
  auto_create_subnetworks = false
  routing_mode = "REGIONAL"
}

resource "google_compute_subnetwork" "this" {
  network = google_compute_network.this.self_link
  name = var.gcp_subnet_name
  ip_cidr_range = var.gcp_subnet_cidr
}

### Firewall Rules

resource "google_compute_firewall" "internal" {
  name = "${var.gcp_vpc_name}-internal"
  network = google_compute_network.this.self_link
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }
  source_ranges = [
    var.gcp_subnet_cidr,
    var.gcp_pod_cidr
  ]
}

resource "google_compute_firewall" "external" {
  name = "${var.gcp_vpc_name}-external"
  network = google_compute_network.this.self_link
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports = [ "22", "6443" ]
  }
  source_ranges = [
    "0.0.0.0/0"
  ]
}

### Kubernetes Public IP Address

resource "google_compute_address" "this" {
  name = var.gcp_vpc_name
  address_type = "EXTERNAL"
}

## Compute Instances

data "google_compute_image" "this" {
  family = var.gcp_image_family
  project = var.gcp_image_project
}

### Kubernetes Controllers

resource "google_compute_instance" "controller" {
  count = var.num_controllers
  name = "controller-${count.index}"
  machine_type = var.gcp_machine_type_controller
  zone = "${var.gcp_region}-${var.gcp_zone_suffix}"
  network_interface {
    subnetwork = google_compute_subnetwork.this.self_link
    network_ip = cidrhost(var.gcp_subnet_cidr, 10 + count.index)
    access_config {
    }
  }
  can_ip_forward = true
  boot_disk {
    auto_delete = true
    initialize_params {
      image = data.google_compute_image.this.self_link
      size = 200
    }
  }
  service_account {
    scopes = var.gcp_scopes
  }
  tags = [
    var.gcp_vpc_name,
    "controller"
  ]
}

### Kubernetes Workers

resource "google_compute_instance" "worker" {
  count = var.num_workers
  name = "worker-${count.index}"
  machine_type = var.gcp_machine_type_worker
  zone = "${var.gcp_region}-${var.gcp_zone_suffix}"
  network_interface {
    subnetwork = google_compute_subnetwork.this.self_link
    network_ip = cidrhost(var.gcp_subnet_cidr, 20 + count.index)
    access_config {
    }
  }
  can_ip_forward = true
  boot_disk {
    auto_delete = true
    initialize_params {
      image = data.google_compute_image.this.self_link
      size = 200
    }
  }
  service_account {
    scopes = var.gcp_scopes
  }
  metadata = {
    pod-cidr = cidrsubnet(var.gcp_pod_cidr, 8, count.index)
  }
  tags = [
    var.gcp_vpc_name,
    "worker"
  ]
}
