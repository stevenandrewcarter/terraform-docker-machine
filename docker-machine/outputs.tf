output "swarm_manager_host_url" {  
  value = "${chomp(data.external.swarm_manager_ip.result["url"])}"  
}

output "machine_ips" {
  value = "${data.external.docker_machine_ips.*.result}"
}