output "public_ip"{
 value = aws_instance.myos1[*].public_ip
}
