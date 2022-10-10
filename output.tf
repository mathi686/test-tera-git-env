output "INS-ID" {
  value = aws_instance.public.id
}
output "IP" {
  value = aws_instance.public.public_ip
}
output "vpcid" {
  value = aws_vpc.private-sub-testing.id
}
