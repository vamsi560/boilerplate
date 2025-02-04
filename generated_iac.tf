```
resource "aws_instance" "web" {
  ami           = "ami-0123456789abcdef0"

  tags = {
    Name = "web-instance"
  }
}
```
