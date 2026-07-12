output "frontdoor_rules_engines_id" {
  description = "Map of id values across all frontdoor_rules_engines, keyed the same as var.frontdoor_rules_engines"
  value       = { for k, v in azurerm_frontdoor_rules_engine.frontdoor_rules_engines : k => v.id }
}
output "frontdoor_rules_engines_enabled" {
  description = "Map of enabled values across all frontdoor_rules_engines, keyed the same as var.frontdoor_rules_engines"
  value       = { for k, v in azurerm_frontdoor_rules_engine.frontdoor_rules_engines : k => v.enabled }
}
output "frontdoor_rules_engines_frontdoor_name" {
  description = "Map of frontdoor_name values across all frontdoor_rules_engines, keyed the same as var.frontdoor_rules_engines"
  value       = { for k, v in azurerm_frontdoor_rules_engine.frontdoor_rules_engines : k => v.frontdoor_name }
}
output "frontdoor_rules_engines_location" {
  description = "Map of location values across all frontdoor_rules_engines, keyed the same as var.frontdoor_rules_engines"
  value       = { for k, v in azurerm_frontdoor_rules_engine.frontdoor_rules_engines : k => v.location }
}
output "frontdoor_rules_engines_name" {
  description = "Map of name values across all frontdoor_rules_engines, keyed the same as var.frontdoor_rules_engines"
  value       = { for k, v in azurerm_frontdoor_rules_engine.frontdoor_rules_engines : k => v.name }
}
output "frontdoor_rules_engines_resource_group_name" {
  description = "Map of resource_group_name values across all frontdoor_rules_engines, keyed the same as var.frontdoor_rules_engines"
  value       = { for k, v in azurerm_frontdoor_rules_engine.frontdoor_rules_engines : k => v.resource_group_name }
}
output "frontdoor_rules_engines_rule" {
  description = "Map of rule values across all frontdoor_rules_engines, keyed the same as var.frontdoor_rules_engines"
  value       = { for k, v in azurerm_frontdoor_rules_engine.frontdoor_rules_engines : k => v.rule }
}

