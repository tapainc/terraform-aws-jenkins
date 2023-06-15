# --------------------------
# Launch Config
# --------------------------
resource "aws_launch_template" "jenkins" {
  name_prefix = "jenkins-lc-"

  image_id      = var.ami
  instance_type = var.instance_type

  key_name               = var.key_name
  vpc_security_group_ids = var.security_groups

  iam_instance_profile {
    name = var.iam_instance_profile
  }

  monitoring {
    enabled = var.enable_monitoring
  }

  user_data = var.custom_userdata != "" ? var.custom_userdata : base64encode(templatefile("${path.module}/userdata.sh", {
    appliedhostname         = var.hostname_prefix
    domain_name             = var.domain_name
    environment             = var.environment
    efs_dnsname             = aws_efs_file_system.this.dns_name
    preliminary_user_data   = var.preliminary_user_data
    supplementary_user_data = var.supplementary_user_data
    TIMEZONE                = var.timezone
  }))

  lifecycle {
    create_before_destroy = true
  }

}