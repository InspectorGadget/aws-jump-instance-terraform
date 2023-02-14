# Jump Instance Setup for Amazon EC2

This is a simple script to setup a jump instance for Amazon EC2. 


# Pre-requisites
- [AWS CLI](https://aws.amazon.com/cli/)
- [Terraform](https://www.terraform.io/)
- [Sshuttle](https://github.com/sshuttle/sshuttle)

# Usage
1. Clone this repository.
2. Create a key pair in AWS and download the private key.
3. Change the permission of the private key to 400. (`chmod 400 file.pem`)
4. Run `terraform init` to initialize terraform.
5. Run `terraform apply` to create the jump instance on the AWS Account.
6. Run `sshuttle -r ec2-user@jump-instance-ip 0.0.0.0/0 -vv --ssh-cmd 'ssh -i ssh-key-file.pem'` to create a VPN connection to the jump instance.