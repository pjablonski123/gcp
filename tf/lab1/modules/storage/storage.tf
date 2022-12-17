resource "google_storage_bucket" "bucket" {
  name = "tf-bucket-830313"
  location = "US"
  force_destroy = true

  #uniform_bucket_level_access = true

}
