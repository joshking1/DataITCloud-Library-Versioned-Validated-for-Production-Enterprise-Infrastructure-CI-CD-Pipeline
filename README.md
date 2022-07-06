# terraform-for-advanced-class-
This is a project demo in which jenkins CI server is provisioned using terraform.  
Shell scripts are run using terraform and used to provision an EC2 server, install Apache Maven, Install Docker.io, Install git, install blueocean container jenkins and the Kubectl commandline interphase. 
Blue ocean container is the preference of this Demo project as a method to provison jenkins CI server.  


# Backend Configuration

A backend defines where Terraform stores its state data files.

Terraform uses persisted state data to keep track of the resources it manages. 

Most non-trivial Terraform configurations either integrate with Terraform Cloud or use a backend to store state remotely. 

This lets multiple people access the state data and work together on that collection of infrastructure resources.

# Using a Backend Block

You do not need to configure a backend when using Terraform Cloud because Terraform Cloud automatically manages state in the workspaces associated with your configuration. 

If your configuration includes a cloud block, it cannot include a backend block.

To configure a backend, add a nested backend block within the top-level terraform block.

The following example configures the remote backend.

terraform {
  backend "remote" {
    organization = "example_corp"

    workspaces {
      name = "my-app-prod"
    }
  }
}

# or you can use terraform cloud block 

# terraform cloud block 

terraform 
 cloud{}
