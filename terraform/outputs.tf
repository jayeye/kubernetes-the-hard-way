output "controllers" {
  value = google_compute_instance.controller
}
output "workers" {
  value = google_compute_instance.worker
}

output "public_address" {
  value = google_compute_address.this.address
}
