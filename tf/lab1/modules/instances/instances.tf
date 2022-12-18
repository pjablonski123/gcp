resource "google_compute_instance" "tf-instance-1" {
  name         = "tf-instance-1"
  machine_type = "n1-standard-1"

  boot_disk {
    initialize_params {
      image = ""
    }
  }

  network_interface {
    network = "default"
    #network = "VPC Name"
    #subnetwork = "subnet-01"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata_startup_script = <<-EOT
      #!/bin/bash
    EOT

  allow_stopping_for_update = true

}

resource "google_compute_instance" "tf-instance-2" {
  name         = "tf-instance-2"
  machine_type = "n1-standard-1"

  boot_disk {
    initialize_params {
      image = ""
    }
  }

  network_interface {
    network = "default"
    #network = "VPC Name"
    #subnetwork = "subnet-01"
    
    access_config {
      // Ephemeral public IP
    }
  }

  metadata_startup_script = <<-EOT
      #!/bin/bash
    EOT

  allow_stopping_for_update = true
}
/*
resource "google_compute_instance" "tf-instance-3" {
  name         = "tf-instance-qwerty"
  machine_type = "n1-standard-2"

  boot_disk {
    initialize_params {
      image  = "https://www.googleapis.com/compute/v1/projects/debian-cloud/global/images/debian-10-buster-v20221206"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata_startup_script = <<-EOT
      #!/bin/bash
    EOT

  allow_stopping_for_update = true

}
*/
