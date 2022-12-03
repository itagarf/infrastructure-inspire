output "vpc_id" {
  description = "The ID of the VPC"
  value       = concat(aws_vpc.inspire.*.id, [""])[0]
}