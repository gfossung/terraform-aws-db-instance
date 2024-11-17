This module can be used to create database instances in the AWS cloud.

To use this module, add the code below to your terraform code:

```
module "db-instances" {
  source = "./gfossung/db-instances"
  dbport = 3307
  typeofinstance = "t2.micro"
}
```
