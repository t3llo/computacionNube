output "webserver_url" {
  description = "webserver URL"
  value       = "http://${aws_instance.webServer.public_ip}"
}
