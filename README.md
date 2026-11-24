# AWS EC2 Auto Scaling Backend

## Project Overview

This project demonstrates how to deploy a Python Flask backend on AWS EC2 and make it horizontally scalable using an Application Load Balancer and Auto Scaling Group.

The architecture distributes incoming traffic across multiple EC2 instances and automatically adjusts compute capacity based on CPU utilization.

## Architecture

```text
                  Internet
                     |
                     v
          Application Load Balancer
                     |
                     v
                Target Group
                /          \
               v            v
            EC2-1          EC2-2
               \            /
                Auto Scaling
                     |
                     v
                CloudWatch
```

## Technologies Used

- AWS EC2
- Application Load Balancer
- EC2 Auto Scaling Group
- Launch Template
- Target Group
- Amazon CloudWatch
- Python
- Flask
- Gunicorn
- Linux
- Git and GitHub

## Project Structure

```text
aws-ec2-auto-scaling-backend/
│
├── app/
│   ├── app.py
│   └── requirements.txt
│
├── scripts/
│   └── user-data.sh
│
├── tests/
│   └── test_api.py
│
├── .gitignore
└── README.md
```

## Backend API Endpoints

| Endpoint | Description |
|---|---|
| / | Application status |
| /health | Health check |
| /api/users | Sample users |
| /api/info | Instance information |

## Deployment Process

1. Create a Flask backend application.
2. Deploy the application using Gunicorn.
3. Create an EC2 Launch Template.
4. Configure the Target Group and health checks.
5. Create an Application Load Balancer.
6. Configure an Auto Scaling Group.
7. Configure CPU-based target tracking.
8. Verify traffic distribution.
9. Test scaling behavior.
10. Monitor resources using CloudWatch.

## Auto Scaling Configuration

| Parameter | Value |
|---|---|
| Minimum instances | 2 |
| Desired instances | 2 |
| Maximum instances | 4 |
| Scaling metric | Average CPU utilization |
| Target CPU | 60% |

## Testing

Run the following commands:

```bash
curl http://YOUR-ALB-DNS/
curl http://YOUR-ALB-DNS/health
curl http://YOUR-ALB-DNS/api/users
```

Run automated tests:

```bash
pytest -v
```

## Security Considerations

- Backend instances do not expose application ports publicly.
- Backend traffic is accepted only from the ALB security group.
- SSH access is not publicly enabled.
- Production deployments should use HTTPS.
- Use IAM roles with least-privilege permissions.
- Keep secrets outside application source code.

## Learning Outcomes

- Understanding horizontal scaling.
- Deploying backend applications on EC2.
- Configuring Application Load Balancers.
- Managing EC2 instances with Auto Scaling Groups.
- Implementing health checks.
- Monitoring infrastructure with CloudWatch.
- Understanding high availability and fault tolerance.

## Cleanup

Delete the Auto Scaling Group, Load Balancer, Target Group, Launch Template and unused Security Groups after testing to avoid unnecessary AWS charges.

## Author

Ammar Khan
