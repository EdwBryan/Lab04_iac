variable "environment" {
  type        = string
  description = "Nombre del entorno (dev, qa)"
}

variable "web_port" {
  type        = number
  description = "Puerto externo para Frontend"
}

variable "api_port" {
  type        = number
  description = "Puerto externo para Backend"
}

variable "db_port" {
  type        = number
  description = "Puerto externo para la BD"
}

variable "dev_web_port" { default = 4001 }
variable "dev_api_port" { default = 4002 }
variable "dev_db_port"  { default = 4003 }

variable "qa_web_port"  { default = 5001 }
variable "qa_api_port"  { default = 5002 }
variable "qa_db_port"   { default = 5003 }