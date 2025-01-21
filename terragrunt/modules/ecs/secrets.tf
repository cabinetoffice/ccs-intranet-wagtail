resource "random_string" "admin_password" {
  length  = 20
  special = true
}

resource "random_string" "django_secret" {
  length  = 50
  special = true
}

resource "aws_secretsmanager_secret" "app_credentials" {
  name = "${var.environment}-app-credentials"
}

# Store the generated credentials in the secret
resource "aws_secretsmanager_secret_version" "app_credentials_version" {
  secret_id = aws_secretsmanager_secret.app_credentials.id
  secret_string = jsonencode({
    ADMIN_USERNAME = "admin",
    ADMIN_PASSWORD = random_string.admin_password.result,
    DJANGO_SECRET  = random_string.django_secret.result
  })
}
