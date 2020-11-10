terraform {
  backend "gcs" {
    bucket = "symbiont-ji"
    prefix = "tf/services-dev"
  }
}
