output "webserver_url" {
  description = "webserver URL"
  value = "http://${aws_instance.webServer.public_ip}"
}

output "message" {
    description = "Custom message"
    value = "Esperar un momento a que se haga el bootstrap a la maquina"
}