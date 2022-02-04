resource "google_storage_bucket" "function_storage_bucket" {
  name     = "function-storage-${var.name}"
  location = "EU"
}

resource "google_storage_bucket_object" "cloud_function_archive_object" {
  name   = "${filemd5("../archive.zip")}.zip"
  bucket = google_storage_bucket.function_storage_bucket.name
  source = "../archive.zip"
}

resource "google_cloudfunctions_function" "cloud_function" {
  name    = var.name
  runtime = "python39"

  source_archive_bucket = google_storage_bucket.function_storage_bucket.name
  source_archive_object = google_storage_bucket_object.cloud_function_archive_object.name


  trigger_http = var.trigger == "cron" ? true : null
  dynamic "event_trigger" {
    for_each = var.trigger == "storage" ? ["dummy"] : []
    content {
      event_type = "google.storage.object.finalize"
      resource   = var.storage_trigger_resource
    }
  }

  entry_point = "main"
}
