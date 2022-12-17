resource "google_compute_instance" "tf-instance-1" {
  name         = "tf-instance-1"
  machine_type = "n1-standard"

  boot_disk {
    initialize_params {
      image = ""
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

resource "google_compute_instance" "tf-instance-2" {
  name         = "tf-instance-2"
  machine_type = "n1-standard"

  boot_disk {
    initialize_params {
      image = ""
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
