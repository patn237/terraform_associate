variable "location" {
  type = string
  default = "eastus"
}

variable "ssh_key" {
  type = string
  sensitive = true
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDQh2+1kuH9YbUuQeeGZ9bYpekOfsNXlyJqJvkH3+0R47rYKx/2zfNVlCRbUz+zpBmpLJJghZ0G2Rdmypx9SIpwzQpc1tne1bUwRa/cIBjVbZyimpaLn29kGjwVx9y+0yv7K7U7IGiREnA/053QyINlKcPXxu8z6Y4gxC9Q6LLkgpXA+16bxLom8/EMouEONz2jJSU/hwkyh1yZiecEQHQCpFF0+qjI0oQdkuAoXdPrulYCX6Q170KVzOU021ArZfr57YoTdQoUwe606vhPARoFKCi53XJ6Kzpm8zn/b1cRjH57/j228XxZScvGKph3SHa+eWXjBVoPcn3bcHj68diH vscode@c9eb19c5559c"
}