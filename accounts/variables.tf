variable "members" {
  type = map(object({
    role  = optional(string, "member")
    teams = optional(set(string), [])
  }))
}

variable "teams" {
  type = map(object({
    description = optional(string, "")
    privacy     = optional(string, "secret")
    members     = optional(list(string), [])
    maintainers = optional(list(string), [])
  }))
}

variable "GITHUB_ORGANIZATION" {
  type = string
}

variable "APP_ID" {
  type = string
}

variable "APP_INSTALLATION_ID" {
  type = string
}

variable "APP_PEM_FILE" {
  type = string
}