variable gcp_project {}
variable gcp_region {
  default = "us-west1"
}
variable gcp_zone_suffix {
  default = "c"
}
variable gcp_vpc_name {
  default = "kubernetes-the-hard-way"
}
variable gcp_subnet_name {
  default = "kubernetes"
}
variable gcp_subnet_cidr {
  default = "10.240.0.0/24"
}
variable gcp_pod_cidr {
  default = "10.200.0.0/16"
}
variable num_controllers {
  default = 3
}
variable num_workers {
  default = 3
}
variable gcp_machine_type_controller {
  default = "e2-standard-2"
}
variable gcp_machine_type_worker {
  default = "e2-standard-2"
}
variable gcp_image_project {
  default = "ubuntu-os-cloud"
}
variable gcp_image_family {
  default =  "ubuntu-2004-lts"
}
variable gcp_scopes {
  default =  [
    "compute-rw",
    "storage-ro",
    "service-management",
    "service-control",
    "logging-write",
    "monitoring",
  ]
}
