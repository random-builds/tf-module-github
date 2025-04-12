variable "name" {
  type = string
}
variable "description" {
  type = optional(string)
}
variable "visibility" {
  type = optional(string, "public")
  validation {
    condition = contains(["public", "private", "internal"], var.visibility)
    error_message = "Visibility must be one of: public, private, internal."
  }
}
variable "has_issues" {
  type = optional(bool, true)
}
variable "has_discussions" {
  type = optional(bool, true)
}
variable "has_projects" {
  type = optional(bool, true)
}
variable "has_wiki" {
  type = optional(bool, true)
}
variable "allow_merge_commit" {
  type = optional(bool, true)
}
variable "allow_squash_merge" {
  type = optional(bool, true)
}
variable "allow_rebase_merge" {
  type = optional(bool, true)
}
variable "allow_auto_merge" {
  type = optional(bool, true)
}
variable "allow_update_branch" {
  type = optional(bool, true)
}
variable "delete_branch_on_merge" {
  type = optional(bool, true)
}
variable "auto_init" {
  type = optional(bool, true)
}
variable "archive_on_destroy" {
  type = optional(bool, true)
}
variable "is_template" {
  type = optional(bool, false)
}
variable "license_template" {
  type = optional(string, "AGPL-3.0")
}
variable "template" {
  type = optional(object({
    owner      = string
    repository = string
  }))
}