#resource "null_resource" "ecs_account_setting" {
#  for_each = var.ecs_account_settings
#  provisioner "local-exec" {
#    command = templatefile("${path.module}/templates/account-settings.sh.tftpl",
#      {
#        name  = each.key,
#        value = each.value
#      }
#    )
#  }
#}
