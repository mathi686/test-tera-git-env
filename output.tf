output "INS-ID" {
  value = aws_instance.public.id
}
output "IP" {
  value = aws_instance.public.public_ip
}