resource "null_resource" "ca_certificates" {
  depends_on = [
    "null_resource.swarm-workers"]
  provisioner "local-exec" {
    command = "./generate.sh ${var.ca_pass}"
    working_dir = "scripts"
  }
  provisioner "local-exec" {
    when = "destroy"
    command = "./clean.sh"
    working_dir = "scripts"
  }
}

resource "null_resource" "certificates" {
  count = 3
  depends_on = [
    "null_resource.ca_certificates"]
  provisioner "local-exec" {
    command = "./install.sh ${element(var.hosts, count.index)} ${var.ca_pass}"
    working_dir = "scripts"
  }
  provisioner "local-exec" {
    when = "destroy"
    command = "./clean.sh ${element(var.hosts, count.index)}"
    working_dir = "scripts"
  }
}