 resource "proxmox_virtual_environment_container" "kuznia" {
   node_name = "proxmox-worker"
   vm_id     = 200

   initialization {
     hostname = "kuznia"

     ip_config {
       ipv4 {
         address = "10.0.20.50/24"
         gateway = "10.0.20.1"
       }
     }

     user_account {
       keys = [var.ssh_key] # Używamy Twojego klucza z variables.tf
     }
   }

   network_interface {
     name    = "eth0"
     bridge  = "vmbr0"
     vlan_id = 20
   }

   cpu {
     cores = 4 # Moc pod buildy Dockera
   }

   memory {
     dedicated = 4096
     swap      = 512
   }

   disk {
     # System plików LXC trzymamy lokalnie na workerze dla szybkości (IOPS)
     datastore_id = "local-lvm"
     size         = 30
   }

   operating_system {
     template_file_id = "shared-sata:vztmpl/debian-13-standard_13.1-2_amd64.tar.zst"
     type             = "debian"
   }

   # Fundament pod Docker-in-LXC
   features {
     nesting = true
   }

   unprivileged = true
 }

 output "kuznia_ip" {
   value = "10.0.20.50"
   description = "Adres IP Kuźni (GitHub Runner + Local Registry)"
 }
