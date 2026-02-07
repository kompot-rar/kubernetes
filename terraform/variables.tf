variable "ssh_key" {
  type        = string
  description = "publiczny klucz ssh"

}
variable "proxmox_api_token_id" {
  type      = string
  sensitive = true
}

variable "proxmox_api_token_secret" {
  type      = string
  sensitive = true
}



variable "proxmox_host" {
  type    = string
  default = "proxmox" # Nazwa węzła w klastrze 
}

variable "template_name" {
  type    = number
  default = 9000 # Złoty Obraz (ID 9000)
}

variable "nodes" {
  type = map(object({
    id          = number
    target_node = string
    storage     = string
    ip          = string
  }))
  default = {
    "k3s-master-0" = {
      id          = 201,
      target_node = "proxmox",
      storage     = "local-lvm", # Standardowe storage dla dysków VM (LVM-Thin) - szybsze i wspiera snapshoty
      ip          = "10.0.20.21"
    }
    "k3s-worker-1" = {
      id          = 202,
      target_node = "proxmox-worker",
      storage     = "local-lvm", # Standardowe storage dla dysków VM (LVM-Thin)
      ip          = "10.0.20.22"
    }
    "k3s-worker-2" = {
      id          = 203,
      target_node = "proxmox-worker-2",
      storage     = "local-lvm", # Standardowe storage dla dysków VM (LVM-Thin)
      ip          = "10.0.20.23"
    }
  }
}
