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
  }))
}