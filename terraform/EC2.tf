# I would strongly recommend generate new keys instead of using provided in GIT repo
# Create key-pair in AWS based on ../keys/homework_keys pair
resource "aws_key_pair" "ssh-key" {
    key_name = "aws-homework-key"
    public_key = file(var.public_key_location)  
}

# Put an instance in each subnet
resource "aws_instance" "wordpress-servers" {
  count                  = length(var.subnet_ids)
  ami                    = var.ami
  instance_type          = "t2.micro"
  iam_instance_profile   = "EC2Role"
  key_name               = aws_key_pair.ssh-key.key_name
  subnet_id              = var.subnet_ids[count.index]
  vpc_security_group_ids = var.security_group_id

  user_data = file("entry-script.sh")

  tags = {
    owner = var.tag_owner
    Name  = "aws-homework-${count.index}"
  }
  volume_tags = {
    owner = var.tag_owner
  }
}
