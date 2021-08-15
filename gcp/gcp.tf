// google provider declaration
provider "google" {
  project = var.project_id
  region  = var.region
}

// create vpc
resource "google_compute_network" "vpc" {
  name                    = "${var.name}-vpc"
  project                 = var.project_id
  auto_create_subnetworks = "false"
}

// create subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.name}-subnet"
  project       = var.project_id
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.10.0.0/24"
}

// create gke cluster
resource "google_container_cluster" "primary" {
  name       = "${var.name}-cluster"
  location   = var.zone
  project    = var.project_id
  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  node_pool {
    name               = "${var.name}-node-pool"
    initial_node_count = 1
    autoscaling {
      min_node_count = var.min_node_count
      max_node_count = var.max_node_count
    }
    node_config {
      oauth_scopes = [
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring",
      ]
      disk_size_gb = var.disk_size_gb
      machine_type = var.machine_type
      image_type   = var.image_type
      preemptible  = true
      tags         = ["gke-node", "${var.project_id}-gke"]
      labels = {
        env = var.project_id
      }
      metadata = {
        disable-legacy-endpoints = "true"
      }
    }
  }

  network_policy {
    enabled = true // this enables Calico in the cluster, disabling traffic between Coder workspace pods
  }
}
