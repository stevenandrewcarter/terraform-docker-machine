provider "docker" {
  alias = "swarm_manager"
  host = "${data.terraform_remote_state.docker_swarm_manager.swarm_manager_host_ip}"
  cert_path = "${pathexpand("~/.docker/machine/machines/${data.terraform_remote_state.docker_swarm_manager.swarm_manager_name}")}"
}