# AWS-EIC

Example/test of using AWS [EC2 Instance Connect Endpoint (EIC)](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/connect-with-ec2-instance-connect-endpoint.html)

Based on articles:
- [June 2023 Blog post](https://aws.amazon.com/fr/blogs/compute/secure-connectivity-from-public-to-private-introducing-ec2-instance-connect-endpoint-june-13-2023/)

Goal is to test if it's possible to access a private db (redis elasicache in this case) from a local workstation using EIC.

## Conclusion

EIC is designed to access an EC2 only. And for us, it's not so usefull because if the instance has the ssm-agent installed we can use it to connect.
