### Policy Definition
resource "azurerm_policy_definition" "AZPLCYD00001" {
  name                  = "Deny-Storage-AnonymouseAccess"
  policy_type           = "Custom"
  mode                  = "Indexed"
  display_name          = "Deny-Storage-AnonymouseAccess"
  
  lifecycle {
	ignore_changes = [metadata]
  }
  
  metadata = file("../Policy/StorageDenyAnonymous/Metadata.json")
  
  policy_rule = file("../Policy/StorageDenyAnonymous/PolicyRule.json")

  parameters = file("../Policy/StorageDenyAnonymous/Parameters.json")
}

### Policy Assignment
resource "azurerm_policy_assignment" "AZPLCYA00001" {
  name                 = "Deny-Anonymous-PolicyAssignment-00001"
  scope                = var.cust_scope
  policy_definition_id =  azurerm_policy_definition.AZPLCYD00001.id
  display_name         = "Enforce Deny Anonymouse Access Policy for Storage Account"
  description          = "Enforce Deny Anonymouse Access Policy for Storage Account"

  parameters = <<PARAMETERS
  {
    "allowedLocations": {
      "value": "Deny"
    }
  }
  PARAMETERS
}