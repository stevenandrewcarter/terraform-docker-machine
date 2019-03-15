output "swarm_manager_name" {  
  depends_on = ["${data.external.swarm_manager_ip}"]
  value = "${chomp(data.external.swarm_manager_ip.result)}"
}

output "swarm_manager_host_ip" {  
  value = "${chomp(data.external.swarm_manager_ip.result)}"
  depends_on = ["${data.external.swarm_manager_ip}"]
}

output "machine_ips" {
  value = "${data.external.docker_machine_ips.result}"
}