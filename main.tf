resource "azurerm_frontdoor_rules_engine" "frontdoor_rules_engines" {
  for_each = var.frontdoor_rules_engines

  frontdoor_name      = each.value.frontdoor_name
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  enabled             = each.value.enabled

  dynamic "rule" {
    for_each = each.value.rule != null ? each.value.rule : []
    content {
      dynamic "action" {
        for_each = rule.value.action != null ? [rule.value.action] : []
        content {
          dynamic "request_header" {
            for_each = action.value.request_header != null ? action.value.request_header : []
            content {
              header_action_type = request_header.value.header_action_type
              header_name        = request_header.value.header_name
              value              = request_header.value.value
            }
          }
          dynamic "response_header" {
            for_each = action.value.response_header != null ? action.value.response_header : []
            content {
              header_action_type = response_header.value.header_action_type
              header_name        = response_header.value.header_name
              value              = response_header.value.value
            }
          }
        }
      }
      dynamic "match_condition" {
        for_each = rule.value.match_condition != null ? rule.value.match_condition : []
        content {
          negate_condition = match_condition.value.negate_condition
          operator         = match_condition.value.operator
          selector         = match_condition.value.selector
          transform        = match_condition.value.transform
          value            = match_condition.value.value
          variable         = match_condition.value.variable
        }
      }
      name     = rule.value.name
      priority = rule.value.priority
    }
  }
}

