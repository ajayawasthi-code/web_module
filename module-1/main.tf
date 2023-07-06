resource "aws_instance" "ec2_module_1" {
  ami=var.ami_id
  instance_type=var.web_instance_type
  vpc_security_group_ids=[aws_security_group.main.id]

  user_data=<<-EOF
      #!/bin/sh
      sudo yum update -y
      sudo yum install -y httpd
      sudo systemctl status httpd
      sudo systemctl start httpd
      sudo chown -R $USER:$USER /var/www/html
      sudo echo "<html><body><h1>Hello this is module1 </h1></body></html>" > /var/www/html/index.html
      EOF
}
resource "aws_security_group" "main" {
   name="EC2-webserver-SG-1"
   description="Webserver for EC2 Instances"

ingress {

description="Allow inbound from"
from_port=22
to_port=22
protocol="tcp"
cidr_blocks=["0.0.0.0/0"]
}

ingress {

from_port=80
to_port=80
protocol="tcp"
cidr_blocks=["0.0.0.0/0"]

}

egress {
from_port=0
to_port=0
protocol="-1"
cidr_blocks=["0.0.0.0/0"]


}
}



