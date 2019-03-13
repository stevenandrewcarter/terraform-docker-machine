output "swarm_manager_name" {  
  depends_on = ["${data.local_file.swarm_manager_ip}"]
  value = "${chomp(var.swarm_manager)}"
}

output "swarm_manager_host_ip" {  
  depends_on = ["${data.local_file.swarm_manager_ip}"]
  value = "${chomp(data.local_file.swarm_manager_ip.0.content)}"
}