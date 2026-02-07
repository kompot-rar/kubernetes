provider "proxmox" {
  endpoint  = "https://10.0.10.11:8006/"
  api_token = "${var.proxmox_api_token_id}=${var.proxmox_api_token_secret}"
  insecure  = true
}

