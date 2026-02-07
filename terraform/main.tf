terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.66.0"
    }
  }
}

data "proxmox_virtual_environment_vm" "template" {
  node_name = var.proxmox_host
  vm_id     = var.template_name
}

resource "proxmox_virtual_environment_vm" "k3s_node" {
  for_each = var.nodes

  name      = each.key
  node_name = each.value.target_node
  vm_id     = each.value.id

  clone {
    vm_id     = data.proxmox_virtual_environment_vm.template.vm_id
    node_name = data.proxmox_virtual_environment_vm.template.node_name
    full      = true # Wymuszamy pełny klon (Full Clone), bo local-lvm jest lokalne dla każdego węzła
  }

  cpu {
    cores   = 2
    sockets = 1
    type    = "host"
  }

  memory {
    dedicated = 8192
  }

  # Konfiguracja głównego dysku systemowego
  disk {
    datastore_id = each.value.storage # Używamy zdefiniowanego 'local-lvm' (blokowe, szybkie)
    interface    = "scsi0"            # Interfejs SCSI dla lepszej wydajności z virtio-scsi
    size         = 20                 # Rozmiar dysku w GB
  }

  # Konfiguracja Cloud-Init do wstępnej konfiguracji maszyny
  initialization {
    datastore_id = each.value.storage # Obraz Cloud-Init też trzymamy na tym samym storage
    
    ip_config {
      ipv4 {
        address = "${each.value.ip}/24"
        gateway = "10.0.20.1"
      }
    }
    
    user_account {
      username = "ubuntu"
      keys     = [var.ssh_key]
    }
  }

  network_device {
    bridge  = "vmbr0"
    model   = "virtio"
    vlan_id = 20
  }

  boot_order = ["scsi0"]
  started    = true
}
