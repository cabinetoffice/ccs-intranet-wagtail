resource "aws_wafv2_web_acl" "cabinet_office" {
  name        = "${var.environment}-cabinetoffice-acl"
  description = "Controling access levele to the ${var.environment} eub environmnet"
  scope       = "REGIONAL"

  tags = merge(
    { Name = "${var.environment}-cabinetoffice-vpn" },
    var.tags
  )

  custom_response_body {
    key          = "vpn_restricted"
    content      = "Access denied"
    content_type = "TEXT_PLAIN"
  }

  default_action {
    block {
      custom_response {
        custom_response_body_key = "vpn_restricted"
        response_code            = 403
      }
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${title(var.environment)}Waf2"
    sampled_requests_enabled   = true
  }

  rule {
    name     = "allow-from-vpn-to-${var.environment}"
    priority = 20

    action {
      allow {
      }
    }

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.allowed.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "${title(var.environment)}Waf2FromVPN"
      sampled_requests_enabled   = true
    }
  }

  dynamic "rule" {
    for_each = var.environment == "prod" ? ["lets-grant-access-to-the-front-end"] : []
    content {
      name     = "allow-from-public-to-front-end-${var.environment}"
      priority = 0

      action {
        allow {
        }
      }

      statement {
        not_statement {
          statement {
            regex_pattern_set_reference_statement {
              arn = aws_wafv2_regex_pattern_set.admin_path_regex.arn
              field_to_match {
                uri_path {}
              }
              text_transformation {
                priority = 0
                type     = "NONE"
              }
            }
          }
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                = "${title(var.environment)}Waf2ToFrontEnd"
        sampled_requests_enabled   = true
      }
    }
  }
}

resource "aws_wafv2_ip_set" "allowed" {
  name               = "${var.environment}-cabinetoffice-vpn"
  description        = "Allowed IP ranges, associated with trusted VPNs"
  scope              = "REGIONAL"
  ip_address_version = "IPV4"
  addresses          = var.allowed_ip_ranges

  tags = merge(
    { Name = "${var.environment}-cabinetoffice-vpn" },
    var.tags
  )
}

resource "aws_wafv2_regex_pattern_set" "admin_path_regex" {
  name  = "${var.environment}-admin-path"
  scope = "REGIONAL"

  regular_expression {
    regex_string = "/admin.*"
  }
}
