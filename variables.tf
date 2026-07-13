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
    enabled             = optional(bool)
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
        negate_condition = optional(bool)
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
        v.rule == null || alltrue([for item in v.rule : (item.action == null || (item.action.request_header == null || (length(item.action.request_header) <= 100)))])
      )
    ])
    error_message = "Each request_header list must contain at most 100 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.frontdoor_rules_engines : (
        v.rule == null || alltrue([for item in v.rule : (item.action == null || (item.action.response_header == null || (length(item.action.response_header) <= 100)))])
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
  validation {
    condition = alltrue([
      for k, v in var.frontdoor_rules_engines : (
        length(v.resource_group_name) <= 90
      )
    ])
    error_message = "[from resourcegroups.ValidateName: invalid when len(value) > 90]"
  }
  validation {
    condition = alltrue([
      for k, v in var.frontdoor_rules_engines : (
        !endswith(v.resource_group_name, ".")
      )
    ])
    error_message = "[from resourcegroups.ValidateName: must not end with \".\"]"
  }
  validation {
    condition = alltrue([
      for k, v in var.frontdoor_rules_engines : (
        length(v.resource_group_name) != 0
      )
    ])
    error_message = "[from resourcegroups.ValidateName: invalid when len(value) == 0]"
  }
  validation {
    condition = alltrue([
      for k, v in var.frontdoor_rules_engines : (
        v.rule == null || alltrue([for item in v.rule : (length(item.name) > 0)])
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.frontdoor_rules_engines : (
        v.rule == null || alltrue([for item in v.rule : (item.match_condition == null || alltrue([for item in item.match_condition : (item.variable == null || (contains(["IsMobile", "RemoteAddr", "RequestMethod", "QueryString", "PostArgs", "RequestUri", "RequestPath", "RequestFilename", "RequestFilenameExtension", "RequestHeader", "RequestBody", "RequestScheme"], item.variable)))]))])
      )
    ])
    error_message = "must be one of: IsMobile, RemoteAddr, RequestMethod, QueryString, PostArgs, RequestUri, RequestPath, RequestFilename, RequestFilenameExtension, RequestHeader, RequestBody, RequestScheme"
  }
  validation {
    condition = alltrue([
      for k, v in var.frontdoor_rules_engines : (
        v.rule == null || alltrue([for item in v.rule : (item.match_condition == null || alltrue([for item in item.match_condition : (item.selector == null || (length(item.selector) > 0))]))])
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.frontdoor_rules_engines : (
        v.rule == null || alltrue([for item in v.rule : (item.match_condition == null || alltrue([for item in item.match_condition : (contains(["Any", "IPMatch", "GeoMatch", "Equal", "Contains", "LessThan", "GreaterThan", "LessThanOrEqual", "GreaterThanOrEqual", "BeginsWith", "EndsWith"], item.operator))]))])
      )
    ])
    error_message = "must be one of: Any, IPMatch, GeoMatch, Equal, Contains, LessThan, GreaterThan, LessThanOrEqual, GreaterThanOrEqual, BeginsWith, EndsWith"
  }
  validation {
    condition = alltrue([
      for k, v in var.frontdoor_rules_engines : (
        v.rule == null || alltrue([for item in v.rule : (item.match_condition == null || alltrue([for item in item.match_condition : (item.transform == null || (alltrue([for x in item.transform : contains(["Lowercase", "RemoveNulls", "Trim", "Uppercase", "UrlDecode", "UrlEncode"], x)])))]))])
      )
    ])
    error_message = "must be one of: Lowercase, RemoveNulls, Trim, Uppercase, UrlDecode, UrlEncode"
  }
  validation {
    condition = alltrue([
      for k, v in var.frontdoor_rules_engines : (
        v.rule == null || alltrue([for item in v.rule : (item.match_condition == null || alltrue([for item in item.match_condition : (item.value == null || (alltrue([for x in item.value : length(x) > 0])))]))])
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.frontdoor_rules_engines : (
        v.rule == null || alltrue([for item in v.rule : (item.action == null || (item.action.request_header == null || alltrue([for item in item.action.request_header : (item.header_name == null || (length(item.header_name) > 0))])))])
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.frontdoor_rules_engines : (
        v.rule == null || alltrue([for item in v.rule : (item.action == null || (item.action.request_header == null || alltrue([for item in item.action.request_header : (item.value == null || (length(item.value) > 0))])))])
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.frontdoor_rules_engines : (
        v.rule == null || alltrue([for item in v.rule : (item.action == null || (item.action.response_header == null || alltrue([for item in item.action.response_header : (item.header_name == null || (length(item.header_name) > 0))])))])
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.frontdoor_rules_engines : (
        v.rule == null || alltrue([for item in v.rule : (item.action == null || (item.action.response_header == null || alltrue([for item in item.action.response_header : (item.value == null || (length(item.value) > 0))])))])
      )
    ])
    error_message = "must not be empty"
  }
  # Note: 4 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

