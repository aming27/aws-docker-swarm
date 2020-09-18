data "template_file" "tools" {
  template = "${ file( "${ path.module }/tools.sh" )}"

  vars = {
    ROLE="${var.role}"
    SWARM_DISCOVERY_BUCKET="${var.discovery-bucket}"
  }
}
