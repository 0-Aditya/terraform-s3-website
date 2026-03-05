Terraform S3 Static Website with CloudFront

This project demonstrates how to deploy a static website on AWS using Terraform modules. The infrastructure provisions an Amazon S3 bucket for static website hosting and a CloudFront distribution to deliver the website through a global Content Delivery Network (CDN).

Using Terraform ensures that the entire infrastructure can be deployed automatically and consistently through Infrastructure as Code. Instead of manually configuring services in the AWS console, this project defines all resources through reusable Terraform modules.

Architecture Overview

The infrastructure follows a simple and scalable architecture where CloudFront sits in front of the S3 bucket.

User
  ↓
CloudFront CDN
  ↓
S3 Static Website
  ↓
HTML / CSS / JS files

When a user visits the website, the request first reaches CloudFront. If the content is cached, CloudFront serves it directly from the nearest edge location. Otherwise, CloudFront retrieves the content from the S3 bucket and caches it for future requests.

This setup improves performance, scalability, and global availability.

Project Structure

The project follows a modular Terraform structure to ensure reusability and maintainability.

terraform-s3-website
│
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
│
├── website
│   ├── index.html
│   └── error.html
│
└── modules
    ├── s3-static-website
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    │
    └── cloudfront-distribution
        ├── main.tf
        ├── variables.tf
        └── outputs.tf

The root Terraform configuration calls both modules and connects them together.

Features

This project demonstrates several key infrastructure capabilities.

Automated infrastructure deployment using Terraform

Reusable Terraform modules

Static website hosting using Amazon S3

Content delivery through Amazon CloudFront

Global caching through CloudFront edge locations

Infrastructure defined completely as code

Prerequisites

Before running this project, ensure the following tools are installed.

Terraform

AWS CLI

Git

You must also configure AWS credentials locally.

aws configure

Provide your AWS Access Key, Secret Key, region, and output format.

Deployment Steps

First clone the repository.

git clone https://github.com/0-Aditya/terraform-s3-website.git
cd terraform-s3-website

Initialize Terraform to download the required providers.

terraform init

Preview the infrastructure Terraform will create.

terraform plan

Apply the configuration to deploy the infrastructure.

terraform apply

Terraform will create the S3 bucket, configure static website hosting, upload website files, and deploy the CloudFront distribution.

Accessing the Website

After deployment, Terraform outputs the CloudFront domain name.

Example output:

cloudfront_url = d123example.cloudfront.net

Open the URL in your browser to access the website.

https://d123example.cloudfront.net
Terraform Modules
S3 Static Website Module

This module creates and configures the S3 bucket used to host the static website. It handles bucket creation, static website configuration, file uploads, and the bucket policy required for public access.

CloudFront Distribution Module

This module provisions the CloudFront distribution and connects it to the S3 bucket origin. It configures caching behavior, request forwarding, and HTTPS redirection.

Why Use Terraform for This Setup

Terraform simplifies infrastructure management by allowing developers to define cloud resources as code. Instead of manually configuring services, infrastructure becomes reproducible, version-controlled, and easy to maintain.

This approach is widely used in modern DevOps workflows.

Future Improvements

Several improvements can extend this architecture further.

Add a custom domain using Route 53

Configure SSL certificates using AWS Certificate Manager

Enable CloudFront cache policies

Add CI/CD deployment pipelines

Author

Aditya

This project was created as part of a Terraform infrastructure exercise to demonstrate modular infrastructure design using AWS services.
