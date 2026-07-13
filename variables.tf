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
  # --- Unconfirmed validation candidates, derived from azurerm_frontdoor_rules_engine's provider source ---
  # Not auto-enabled: either a bespoke provider validator we can't safely translate,
  # or a path that crosses a list-typed block (needs its own for_each wrapping).
  # Review, translate into a real validation{} block above, and delete once confirmed.
  # path: frontdoor_name
  #   source:    azValidate.FrontDoorName: no recognizable `if ... { errors = append(...) }` pattern - read it by hand
  # path: resource_group_name
  #   condition: length(value) <= 90
  #   message:   [from resourcegroups.ValidateName: invalid when len(value) > 90]
  #   source:    [from resourcegroups.ValidateName: invalid when len(value) > 90]
  # path: resource_group_name
  #   condition: !endswith(value, ".")
  #   message:   [from resourcegroups.ValidateName: must not end with "."]
  #   source:    [from resourcegroups.ValidateName: must not end with "."]
  # path: resource_group_name
  #   condition: length(value) != 0
  #   message:   [from resourcegroups.ValidateName: invalid when len(value) == 0]
  #   source:    [from resourcegroups.ValidateName: invalid when len(value) == 0]
  # path: resource_group_name
  #   source:    [from resourcegroups.ValidateName] !matched
  # path: rule.name
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: rule.match_condition.variable
  #   condition: contains(["IsMobile", "RemoteAddr", "RequestMethod", "QueryString", "PostArgs", "RequestUri", "RequestPath", "RequestFilename", "RequestFilenameExtension", "RequestHeader", "RequestBody", "RequestScheme"], value)
  #   message:   must be one of: IsMobile, RemoteAddr, RequestMethod, QueryString, PostArgs, RequestUri, RequestPath, RequestFilename, RequestFilenameExtension, RequestHeader, RequestBody, RequestScheme
  # path: rule.match_condition.selector
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: rule.match_condition.operator
  #   condition: contains(["Any", "IPMatch", "GeoMatch", "Equal", "Contains", "LessThan", "GreaterThan", "LessThanOrEqual", "GreaterThanOrEqual", "BeginsWith", "EndsWith"], value)
  #   message:   must be one of: Any, IPMatch, GeoMatch, Equal, Contains, LessThan, GreaterThan, LessThanOrEqual, GreaterThanOrEqual, BeginsWith, EndsWith
  # path: rule.match_condition.transform[*]
  #   condition: contains(["Lowercase", "RemoveNulls", "Trim", "Uppercase", "UrlDecode", "UrlEncode"], value)
  #   message:   must be one of: Lowercase, RemoveNulls, Trim, Uppercase, UrlDecode, UrlEncode
  # path: rule.match_condition.value[*]
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: rule.action.request_header.header_action_type
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: rule.action.request_header.header_name
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: rule.action.request_header.value
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: rule.action.response_header.header_action_type
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: rule.action.response_header.header_name
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: rule.action.response_header.value
  #   condition: length(value) > 0
  #   message:   must not be empty
}

