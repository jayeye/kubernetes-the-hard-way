gcp_project                  = "services-dev-cbb1"
gcp_region                   = "us-central1"
gcp_zone_suffix              = "c"
gcp_vpc_name                 = "kubernetes-the-hard-way"
gcp_subnet_name              = "kubernetes"
gcp_subnet_cidr              = "10.240.0.0/24"
gcp_pod_cidr                 = "10.200.0.0/16"
num_controllers              = 3
num_workers                  = 3
gcp_machine_type_controller  = "e2-standard-2"
gcp_machine_type_worker      = "e2-standard-2"
gcp_image_family             = "ubuntu-2004-lts"
gcp_image_project            = "ubuntu-os-cloud"
gcp_scopes                   = [
                                 "compute-rw",
                                 "storage-ro",
                                 "service-management",
                                 "service-control",
                                 "logging-write",
                                 "monitoring"
                               ]
