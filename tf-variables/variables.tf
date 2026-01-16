variable "aws_instance_type" {
    description = "What type of instance you want to create?"
    type = string
    validation {
      condition = var.aws_instance_type=="t3.small" || var.aws_instance_type=="t3.micro"
      error_message = "only t3.small and t3.micro is allowed"

    }
  
}

variable "ec2_config" {
    type = object({
      v_size = number
      v_type = string
    })

    default = {
      v_size = 30
      v_type = "gp2"
    }
  
}

variable "additional_tags" {
    type = map(string) #expecting key=value format
    default = {}
}