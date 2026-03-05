# 🏨 Serverless AI Contact Form for Hospitality (AWS + Terraform)

This project implements a **serverless AI-powered contact form system** designed for hospitality businesses such as hotels and resorts.

The system automatically processes guest inquiries using **AWS serverless services and AI capabilities** to detect language, translate messages, analyze sentiment, store inquiries, and notify staff.

Infrastructure is deployed using **Terraform**, enabling reproducible cloud environments and automated infrastructure provisioning.

📖 **Architecture Deep Dive (Medium Article):**  
[Building a Serverless AI Contact Form with AWS and Terraform](https://medium.com/@psalvador8/building-a-serverless-ai-contact-form-with-aws-and-terraform-enhancing-guest-communication-at-aeae50b4d354)

---

# 📌 Project Overview

Traditional contact forms can create communication barriers for international guests and often lack mechanisms to prioritize urgent inquiries.

This project implements a **serverless cloud architecture** that enhances guest communication by automatically processing incoming messages.

Key capabilities include:

- Automatic language detection
- Translation of guest messages into English
- Sentiment analysis to prioritize urgent requests
- Message storage for historical records
- Automated email notifications to hotel staff
- Infrastructure provisioning using Terraform

The architecture demonstrates how modern cloud services can be combined to build **intelligent, event-driven applications**.

---

# 🧭 Architecture

![Architecture Diagram](docs/architecture.png)

### Request Flow

```
Guest Contact Form
        ↓
API Gateway
        ↓
AWS Lambda Function
        ↓
Amazon Comprehend (Language Detection + Sentiment)
        ↓
Amazon Translate (Message Translation)
        ↓
DynamoDB (Message Storage)
        ↓
Amazon SES (Email Notification)
```

Guest messages are submitted through a web contact form.

The request is sent to **Amazon API Gateway**, which triggers an **AWS Lambda function**.

The Lambda function performs several processing steps:

- Detects the language of the message
- Analyzes sentiment using Amazon Comprehend
- Translates non-English messages using Amazon Translate
- Stores the message and metadata in DynamoDB
- Sends email notifications using Amazon SES

This architecture allows hotels to automatically process guest inquiries in a **scalable and multilingual system**.

---

# 🧰 Technologies Used

- AWS Lambda
- Amazon API Gateway
- Amazon Comprehend
- Amazon Translate
- Amazon SES
- Amazon DynamoDB
- Terraform
- Python / Node.js
- AWS CloudWatch
- HTML / CSS / JavaScript

---

# ⚙️ Deployment Strategy

Infrastructure for this project is provisioned using **Terraform**, enabling automated and repeatable deployments.

Terraform provisions:

- API Gateway endpoint
- Lambda function
- DynamoDB table
- IAM roles and permissions
- SES configuration
- CloudWatch logging

The serverless backend processes incoming messages, while the frontend contact form sends requests to the API endpoint.

This Infrastructure-as-Code approach ensures the architecture can be **recreated consistently across environments**.

---

# 🚀 Quick Deployment

### Prerequisites

- AWS account
- Terraform installed
- AWS CLI configured

### Deploy Infrastructure

```
terraform init
terraform apply
```

Terraform provisions the required AWS services and deploys the serverless backend infrastructure.

After deployment, the **API Gateway endpoint** can be integrated with the frontend contact form.

---

# 🛟 Reliability & Scalability

The system is designed using **serverless AWS services**, which provide automatic scaling and high availability.

Key reliability features include:

- Automatic scaling with AWS Lambda
- Managed AWS services with built-in redundancy
- CloudWatch logging for monitoring
- Event-driven processing architecture

Because the system is serverless, it can automatically handle spikes in guest inquiries without additional infrastructure management.

---

# 🧠 Design Decisions

Several architectural choices were made to optimize scalability and maintainability.

- **Serverless architecture** eliminates the need for infrastructure management.
- **API Gateway** provides a secure and scalable entry point for requests.
- **AWS Lambda** enables event-driven processing without servers.
- **Amazon Comprehend** enables automated sentiment analysis for prioritizing guest concerns.
- **Amazon Translate** enables communication with international guests.
- **DynamoDB** provides scalable, low-latency storage for guest messages.
- **Terraform** ensures infrastructure is reproducible and version-controlled.

These decisions enable an intelligent, scalable guest communication system.

---

# 🏗️ System Design Principles

This architecture follows several cloud-native design principles.

### Event-Driven Architecture

Incoming messages trigger processing workflows automatically through AWS Lambda.

### Scalability

Serverless services scale automatically based on demand.

### Loose Coupling

Each AWS service performs a specific role and communicates through defined interfaces.

### Fault Isolation

Failures in one component do not cascade through the entire system.

### Automation

Infrastructure is managed using Terraform to eliminate manual configuration.

---

# 🎯 What This Project Demonstrates

- Serverless application architecture on AWS
- Integration of AI services into cloud applications
- Infrastructure as Code with Terraform
- Event-driven system design
- Automated message processing workflows
- Cloud-native scalability and reliability

---

# 🚀 Potential Improvements

Future enhancements could include:

- Adding authentication for hotel staff dashboards
- Implementing analytics dashboards for inquiry trends
- Adding automated AI-generated responses
- Implementing rate limiting and security protections
- Adding monitoring dashboards with CloudWatch metrics

---

# 📁 Repository Structure

```
├── README.md
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
├── lambda/
│   ├── index.js
│   └── dependencies
├── frontend/
│   ├── index.html
│   ├── script.js
│   └── styles.css
└── docs/
    └── architecture.png
```

---

# 💡 Key Takeaway

This project demonstrates how **serverless cloud services and AI capabilities can be combined to build intelligent applications**.

By integrating AWS Lambda, AI services, DynamoDB, and Terraform infrastructure automation, the system provides a scalable solution for improving guest communication in hospitality environments.

---

# 👤 Author

**Priscilla Salvador**  
Cloud & DevOps Engineer
