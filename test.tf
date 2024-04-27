# variable "names" {
#     default = ["docdb", "frontend"]
# }

# output "arns"{
#     value = [ for name in var.names: "arn:aws:ssm:us-east-1:123:parameter/dev.${name}.*"]
# }