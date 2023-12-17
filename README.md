# Terraform project
## Contents
- [Project Requirements](#project-requirements)
    - [VPV](#vpc)
    - [Smart Home Server](#Smart_Home_Server)
    - [Security](#security)
    - [Dynamo](#dynamo)
    - [Load Balancer](#loadbalancer)
    - [Autoscaling](#autoscaling)
- [Development and Production](#devlopment--production)
    - [Deployment](#deployment)
- [Credits](#credits)
- [Bugs](#bugs)
- [Acknowledgements](#acknowledgements)

![Project Infrastructure](./documentation/images/graph.png "Terraform Infrastructure")

## Project Requirements
This project is a portfolio project for my cloud engineering bootcamp at Northcoders. In this project, we were asked to build an infrastructure where clients can have their applications running without any interruption. The client has some following requirements.

- Be completed using terraform
- Be a production ready network setup with both public and private subnets
- Make use of terraform variables and looping where possible
- Make your code as DRY and reusable as possible by creating modules where you can
- Have DynamoDB tables to account for the services that need them
- Be created with 'design for failure' in mind - we do not want a loss of service if one of the EC2 instances fails

I decided to build the infrastrure using `Terraform` and deploy it to `aws` with following components
- VPC in `eu-2-west` region
- Three `subnets` in each availability zone
- An `ec2` instance in each subnet
- Create `security group` for all the traffic 
- Deploy application for <em>lights</em>, <em>heating</em>, and <em>status</em> in each instance
- Create a `load balancer (ALB)` to respond to the requests
- Three goups for `ALB`, with each containing one instance
- Create Autoscaling groups with each have the ability to have an instance available in each availability zone

The infrastucture has following modules to meet the requirements
1. vpc
2. smart_home_server
3. security
4. dynamo
5. load_balancer
6. autoscaling

### VPC
This module has the configuration to create a an aws vpc infratructure in a given region and zones, and desired number of subnets, a root table to route public traffic, a gateway to allow external requests.
<br>

### Smart_Home_Server
This contains the configuration to create ec2 instances in each subnet, allowing access for public.  
<br>

### Security
Security group has security for ingress and egress. It has rules set for http, https, ipv4, ipv6 and ssh.
<br>

### Dynamo
This module create 2 dynamo tables for apps deployed for lighting and heating application.
<br>

### Load_Balancer
The load balancer module created three groups each conatining one subnet and all attached to a single load balancer.
<br>

### Autoscaling
The autoscaling has the configuration to launch instances in each availability zone. The instances will be lauched from the so=ame image as the original instance. In this case, three AMIs for the given applications.
<br>

## Devlopment & Production
For the development, msot of the values are passed by variables. However, at times, hard coded values weere passed to the modules. All secret files have been added to the .gitignore file to make sure the security has not been compromised. For the production ready infrastructure, I have moved AMIs to the root `variable.tf`. Therefore, for this infrastructure to be deployed, one would need to provide AMIs through creting a `terraform.tfvars` file in the root directory.
<br>

### Deployment
Following commands can be used to to deploy the infrastructure. Before the deployment, make sure to have terraform installed and right permissions to access and create `aws` infrastructure.

```
    terraform init
    terraform validate
    terraform plan
    terraform apply

```

### Tearing things down

The command `terraform destroy` can be run to remove everything to remove the entire infrastructure.

## Credits

### Content

- The applications were provided by Northcoders
- Parts of the infrastructure code has been taken from various sources including terraform official documentation. 

## Bugs
There are no known bugs in the project. 

## Acknowledgements

I would like to acknowledge the following people who have helped me with completing this project:

 - The Northcoders team who have helped me throughout the course
 - Special thanks to the course tutors and content developers, who have put an immense amount of work and consideration into the creation and delivery of the course.
