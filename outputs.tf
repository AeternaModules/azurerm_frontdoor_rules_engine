output "frontdoor_rules_engines_id" {
  description = "Map of id values across all frontdoor_rules_engines, keyed the same as var.frontdoor_rules_engines"
  value       = { for k, v in azurerm_frontdoor_rules_engine.frontdoor_rules_engines : k => v.id if v.id != null && length(v.id) > 0 }
}
output "frontdoor_rules_engines_enabled" {
  description = "Map of enabled values across all frontdoor_rules_engines, keyed the same as var.frontdoor_rules_engines"
  value       = { for k, v in azurerm_frontdoor_rules_engine.frontdoor_rules_engines : k => v.enabled if v.enabled != null }
}
output "frontdoor_rules_engines_frontdoor_name" {
  description = "Map of frontdoor_name values across all frontdoor_rules_engines, keyed the same as var.frontdoor_rules_engines"
  value       = { for k, v in azurerm_frontdoor_rules_engine.frontdoor_rules_engines : k => v.frontdoor_name if v.frontdoor_name != null && length(v.frontdoor_name) > 0 }
}
output "frontdoor_rules_engines_location" {
  description = "Map of location values across all frontdoor_rules_engines, keyed the same as var.frontdoor_rules_engines"
  value       = { for k, v in azurerm_frontdoor_rules_engine.frontdoor_rules_engines : k => v.location if v.location != null && length(v.location) > 0 }
}
output "frontdoor_rules_engines_name" {
  description = "Map of name values across all frontdoor_rules_engines, keyed the same as var.frontdoor_rules_engines"
  value       = { for k, v in azurerm_frontdoor_rules_engine.frontdoor_rules_engines : k => v.name if v.name != null && length(v.name) > 0 }
}
output "frontdoor_rules_engines_resource_group_name" {
  description = "Map of resource_group_name values across all frontdoor_rules_engines, keyed the same as var.frontdoor_rules_engines"
  value       = { for k, v in azurerm_frontdoor_rules_engine.frontdoor_rules_engines : k => v.resource_group_name if v.resource_group_name != null && length(v.resource_group_name) > 0 }
}
output "frontdoor_rules_engines_rule" {
  description = "Map of rule values across all frontdoor_rules_engines, keyed the same as var.frontdoor_rules_engines"
  value       = { for k, v in azurerm_frontdoor_rules_engine.frontdoor_rules_engines : k => v.rule if v.rule != null && length(v.rule) > 0 }
}

