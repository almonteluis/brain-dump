---
tags: ["advanced", "aws", "aws-certification", "beginner", "certification", "devops"]
---
# AWS Learning Path MOC  
Parent: [[DevOps & Cloud Skills MOC]]  

---
description: React notes and reference about AWS Learning Path MOC.

## Core AWS Concepts  
- [[AWS Core Services Overview]]  
- [[AWS Global Infrastructure]]  
- [[AWS Shared Responsibility Model]]  

---

## Certifications & Courses  
### Foundational  
- [[AWS Cloud Practitioner Essentials]] 
	- Link: [AWS Training](https://explore.skillbuilder.aws/learn/courses/134/aws-cloud-practitioner-essentials/lessons/136404/aws-cloud-practitioner-essentials)
	- Tags: #aws-certification #beginner 
### Associate/Professional  
- [[AWS Certified DevOps Engineer Pro]]  
  - Course: [Udemy AWS DevOps Pro](link)  
  - Exam Guide: [DOP-C02 Syllabus](https://aws.amazon.com/certification/)  
  - Tags: #aws-certification #advanced  

- [[DevOps on AWS Specialization (Coursera)]]  
  - Lab: [Hands-on with AWS CodePipeline](link)  
  - Notes: [[AWS CI/CD Pipeline Project]]  

---

## Hands-On Labs & Projects  
- **Labs**:  
  - [[AWS Skill Builder Labs]]  
  - [[Qwiklabs AWS Projects]]  

- **Projects**:  
  1. [[Deploy a Serverless App with AWS Lambda]]  
     - Tools: Lambda, API Gateway, S3  
  2. [[Build a CI/CD Pipeline with AWS CodePipeline]]  
     - Tools: CodeCommit, CodeBuild, CodeDeploy  
  3. [[Infrastructure as Code with AWS CloudFormation]]  
     - Template: [[CloudFormation YAML Basics]]  

---

## Key Tools & Services  
- **Compute**: [[EC2]], [[Lambda]], [[ECS]]  
- **Storage**: [[S3]], [[EBS]], [[EFS]]  
- **DevOps**: [[CodePipeline]], [[CodeBuild]], [[CloudWatch]]  
- **Security**: [[IAM]], [[KMS]], [[AWS Config]]  

---

## Related Topics  
- [[Multi-Cloud Strategy (AWS + Azure/GCP)]]  
- [[AWS + Kubernetes (EKS)]]  
- [[AWS vs. On-Prem DevOps]]  


---


---

### **3. Atomic Notes for AWS Concepts**  
Create individual notes for each AWS service/topic (e.g., `EC2.md`, `Lambda.md`) with this template:  
```markdown
# EC2 (Elastic Compute Cloud)  
Parent: [[AWS Learning Path MOC]]  

## Key Features  
- Scalable virtual servers  
- Integration with Auto Scaling, Load Balancing  

## Use Cases  
- Hosting web apps  
- Batch processing  

## Commands/Templates  
```bash
aws ec2 run-instances --image-id ami-xyz --instance-type t2.micro
```

## Links  
- [AWS EC2 Docs](https://docs.aws.amazon.com/ec2)  
- Related: [[VPC]], [[Security Groups]]  
```

---

### **4. Use Obsidian Features**  
- **Tags**: Add `#aws`, `#devops`, `#certification` to notes for easy filtering.  
- **Backlinks**: Use `![[EC2]]` to embed EC2 details in project notes.  
- **Graph View**: Track connections between AWS services and projects.  

---

### **5. Track Progress**  
Create a `AWS Certification Tracker.md`:  
```markdown
- [ ] Complete AWS Cloud Practitioner  
  - Progress: 30%  
  - Notes: [[AWS CCP Study Plan]]  

- [ ] Enroll in DevOps on AWS (Coursera)  
  - Deadline: 2025-03-01  
```

---

### **Example Workflow**  
1. Start with the **AWS Cloud Practitioner** course.  
2. Build a simple project (e.g., [[Deploy a Static Website on S3]]).  
3. Move to advanced labs (e.g., [[AWS CodePipeline Project]]).  
4. Schedule the **AWS DevOps Pro exam**.  

Use daily notes like `2025-02-15.md` to log:  
```markdown
## Today’s AWS Tasks  
- [x] Studied [[IAM Roles]]  
- [ ] Debugged [[Lambda Permission Error]]  
```

---

This structure keeps your learning modular, interconnected, and aligned with industry certifications. Let me know if you want templates for Azure/GCP next! 🚀