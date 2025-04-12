resource "github_membership" "members" {
  for_each = var.members
  username = each.key
  role     = each.value.role
}

resource "github_team" "team" {
  for_each    = var.teams
  name        = each.key
  description = each.value.description
  privacy     = each.value.privacy
}

resource "github_team_membership" "team_membership" {
  for_each = merge([for k, v in var.members : { for team in v.teams : "${k}-${team}" => { username : k, team : team } }]...)
  team_id  = github_team.team[each.value.team].id
  username = each.value.username
}