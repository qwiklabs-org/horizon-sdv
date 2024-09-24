
variable "sdv_network" {
  description = "Define the name of the VPC network"
  type        = string
}

variable "sdv_project" {
  description = "Define the GCP project id"
  type        = string
}

variable "sdv_location" {
  description = "Define the default location for the project, should be the same as the region value"
  type        = string
}

variable "sdv_region" {
  description = "Define the default region for the project"
  type        = string
}

variable "sdv_zone" {
  description = "Define the default region zone for the project"
  type        = string
}

variable "sdv_subnetwork" {
  description = "Define the subnet name"
  type        = string
}

variable "sdv_default_computer_sa" {
  description = "The default Computer SA"
  type        = string
}

variable "sdv_cluster_name" {
  description = "Name of the cluster"
  type        = string
}

variable "sdv_cluster_node_pool_name" {
  description = "Name of the cluster node pool"
  type        = string
}

variable "sdv_cluster_node_pool_machine_type" {
  description = "Define the machine type of the node pool"
  type        = string
  default     = "n1-standard-4"
}

variable "sdv_cluster_node_pool_count" {
  description = "Define the number of nodes for the node pool"
  type        = number
  default     = 1
}

variable "sdv_bastion_host_name" {
  description = "Name of the bastion host server"
  type        = string
}

variable "sdv_bastion_host_members" {
  description = "List of members allowed to access the bastion server"
  type        = list(string)
}

variable "sdv_bastion_host_sa" {
  description = "SA used by the bastion host and allow IAP to the host"
  type        = string
}

variable "sdv_network_egress_router_name" {
  description = "Define the name of the egress router of the network"
  type        = string
}

variable "sdv_artifact_registry_repository_id" {
  description = "Define the name of the artifactory registry repository name"
  type        = string
}
