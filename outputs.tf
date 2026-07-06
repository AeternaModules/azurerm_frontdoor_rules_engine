output "frontdoor_rules_engines" {
  description = "All frontdoor_rules_engine resources"
  value       = azurerm_frontdoor_rules_engine.frontdoor_rules_engines
}
output "frontdoor_rules_engines_enabled" {
  description = "List of enabled values across all frontdoor_rules_engines"
  value       = [for k, v in azurerm_frontdoor_rules_engine.frontdoor_rules_engines : v.enabled]
}
output "frontdoor_rules_engines_frontdoor_name" {
  description = "List of frontdoor_name values across all frontdoor_rules_engines"
  value       = [for k, v in azurerm_frontdoor_rules_engine.frontdoor_rules_engines : v.frontdoor_name]
}
output "frontdoor_rules_engines_location" {
  description = "List of location values across all frontdoor_rules_engines"
  value       = [for k, v in azurerm_frontdoor_rules_engine.frontdoor_rules_engines : v.location]
}
output "frontdoor_rules_engines_name" {
  description = "List of name values across all frontdoor_rules_engines"
  value       = [for k, v in azurerm_frontdoor_rules_engine.frontdoor_rules_engines : v.name]
}
output "frontdoor_rules_engines_resource_group_name" {
  description = "List of resource_group_name values across all frontdoor_rules_engines"
  value       = [for k, v in azurerm_frontdoor_rules_engine.frontdoor_rules_engines : v.resource_group_name]
}
output "frontdoor_rules_engines_rule" {
  description = "List of rule values across all frontdoor_rules_engines"
  value       = [for k, v in azurerm_frontdoor_rules_engine.frontdoor_rules_engines : v.rule]
}

