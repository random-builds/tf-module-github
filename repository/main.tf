resource "github_repository" "repository" {
  name        = var.name
  description = var.description
  #checkov:skip=CKV_GIT_1: allow public repos
  visibility             = var.visibility
  is_template            = var.is_template
  delete_branch_on_merge = var.delete_branch_on_merge

  has_issues      = var.has_issues
  has_discussions = var.has_discussions
  has_projects    = var.has_projects
  has_wiki        = var.has_wiki

  allow_auto_merge    = var.allow_auto_merge
  allow_merge_commit  = var.allow_merge_commit
  allow_rebase_merge  = var.allow_rebase_merge
  allow_squash_merge  = var.allow_squash_merge
  allow_update_branch = var.allow_update_branch

  auto_init          = var.auto_init
  license_template   = var.license_template
  archive_on_destroy = var.archive_on_destroy

  dynamic "template" {
    for_each = var.template == null ? [] : [var.template]
    content {
      owner      = var.template.owner
      repository = var.template.repository
    }
  }

  security_and_analysis {
    secret_scanning {
      status = "enabled"
    }
    secret_scanning_push_protection {
      status = "enabled"
    }
  }

  vulnerability_alerts = true
}

resource "github_branch_protection" "branch_protection" {
  repository_id = github_repository.repository.id
  pattern       = "main"

  allows_force_pushes             = false
  allows_deletions                = false
  require_conversation_resolution = true
  require_signed_commits          = true

  required_status_checks {
    strict = true
  }

  restrict_pushes {
    push_allowances = var.bypass_teams
  }

  required_pull_request_reviews {
    dismiss_stale_reviews      = true
    require_code_owner_reviews = true
    require_last_push_approval = true
    #checkov:skip=CKV_GIT_5: only one approval should suffice
    required_approving_review_count = 1
    pull_request_bypassers          = var.bypass_teams
    restrict_dismissals             = true
    dismissal_restrictions          = var.bypass_teams
  }
}

resource "github_repository_dependabot_security_updates" "this" {
  enabled    = true
  repository = github_repository.repository.name
}
