variable "frontdoor_rules_engines" {
  description = <<EOT
Map of frontdoor_rules_engines, attributes below
Required:
    - frontdoor_name
    - name
    - resource_group_name
Optional:
    - enabled
    - rule (block):
        - action (optional, block):
            - request_header (optional, block):
                - header_action_type (optional)
                - header_name (optional)
                - value (optional)
            - response_header (optional, block):
                - header_action_type (optional)
                - header_name (optional)
                - value (optional)
        - match_condition (optional, block):
            - negate_condition (optional)
            - operator (required)
            - selector (optional)
            - transform (optional)
            - value (optional)
            - variable (optional)
        - name (required)
        - priority (required)
EOT

  type = map(object({
    frontdoor_name      = string
    name                = string
    resource_group_name = string
    enabled             = optional(bool, true)
    rule = optional(list(object({
      action = optional(object({
        request_header = optional(list(object({
          header_action_type = optional(string)
          header_name        = optional(string)
          value              = optional(string)
        })))
        response_header = optional(list(object({
          header_action_type = optional(string)
          header_name        = optional(string)
          value              = optional(string)
        })))
      }))
      match_condition = optional(list(object({
        negate_condition = optional(bool, false)
        operator         = string
        selector         = optional(string)
        transform        = optional(list(string))
        value            = optional(list(string))
        variable         = optional(string)
      })))
      name     = string
      priority = number
    })))
  }))
  validation {
    condition = alltrue([
      for k, v in var.frontdoor_rules_engines : (
        v.rule == null || (length(v.rule) <= 100)
      )
    ])
    error_message = "Each rule list must contain at most 100 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.frontdoor_rules_engines : (
        v.rule == null || alltrue([for item in v.rule : (item.action.request_header == null || (length(item.action.request_header) <= 100))])
      )
    ])
    error_message = "Each request_header list must contain at most 100 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.frontdoor_rules_engines : (
        v.rule == null || alltrue([for item in v.rule : (item.action.response_header == null || (length(item.action.response_header) <= 100))])
      )
    ])
    error_message = "Each response_header list must contain at most 100 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.frontdoor_rules_engines : (
        v.rule == null || alltrue([for item in v.rule : (item.match_condition == null || (length(item.match_condition) <= 100))])
      )
    ])
    error_message = "Each match_condition list must contain at most 100 items"
  }
}

