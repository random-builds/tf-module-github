resource "github_repository" "repository" {
  for_each               = var.repositories
  name                   = each.key
  description            = each.value.description
  visibility             = each.value.visibility
  is_template            = each.value.is_template
  delete_branch_on_merge = each.value.delete_branch_on_merge

  has_issues      = each.value.has_issues
  has_discussions = each.value.has_discussions
  has_projects    = each.value.has_projects
  has_wiki        = each.value.has_wiki

  allow_auto_merge    = each.value.allow_auto_merge
  allow_merge_commit  = each.value.allow_merge_commit
  allow_rebase_merge  = each.value.allow_rebase_merge
  allow_squash_merge  = each.value.allow_squash_merge
  allow_update_branch = each.value.allow_update_branch

  auto_init          = each.value.auto_init
  license_template   = each.value.license_template
  archived           = each.value.archived
  archive_on_destroy = each.value.archive_on_destroy

  dynamic "template" {
    for_each = each.value.template == null ? [] : [each.value.template]
    content {
      owner      = each.value.template.owner
      repository = each.value.template.repository
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
}

resource "github_repository_tag_protection" "example" {
  for_each   = github_repository.repository
  repository = each.key
  pattern    = "v*"
}

resource "github_branch_protection" "branch_protection" {
  for_each = github_repository.repository
  repository_id = each.value.id
  pattern     = "main"

  require_conversation_resolution = true

  required_status_checks {
    strict = true
  }

  required_pull_request_reviews {
    dismiss_stale_reviews = true
    require_code_owner_reviews = true
    require_last_push_approval = true
    required_approving_review_count = 1
  }
}