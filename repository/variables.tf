variable "repositories" {
  type = map(object({
    description            = string
    visibility             = optional(string, "public")
    has_issues             = optional(bool, true)
    has_discussions        = optional(bool, true)
    has_projects           = optional(bool, true)
    has_wiki               = optional(bool, true)
    is_template            = optional(bool, false)
    allow_merge_commit     = optional(bool, true)
    allow_squash_merge     = optional(bool, true)
    allow_rebase_merge     = optional(bool, true)
    allow_auto_merge       = optional(bool, true)
    allow_update_branch    = optional(bool, true)
    delete_branch_on_merge = optional(bool, true)
    auto_init              = optional(bool, true)
    license_template       = optional(string, "AGPL-3.0")
    archived               = optional(bool, false)
    archive_on_destroy     = optional(bool, true)
    template = optional(object({
      owner      = string
      repository = string
    }))
  }))
}