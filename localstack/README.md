# LocalStack: AWS Cloud Emulation

**LocalStack** provides a fully functional local AWS cloud stack. Develop and test your cloud and Serverless apps offline.

---

## 🏗️ Architecture & Strategy: Why These Tools?

This deployment provisions a lightweight AWS environment on your local machine, avoiding the costs and latency of real AWS infrastructure during development.

1. **LocalStack Gateway:** Emulates core AWS services (S3, IAM, Lambda, API Gateway, EC2).
2. **Docker Socket Mount:** Allows LocalStack to seamlessly spin up ephemeral micro-containers when you trigger AWS Lambda functions locally.

---

## 📁 Directory Structure

- **`./volume`**: Bound to `/var/lib/localstack`. This persists your buckets, databases, and configuration across container restarts.

---

## 🚀 Technical Implementation Guide (IT Runbook)

### Phase 1: Initialization

1. Copy the `.env.example` file:
   ```bash
   cp .env.example .env
   ```
2. (Optional) Edit the `SERVICES` variable in `.env` to load only the AWS APIs you need, saving system RAM.

### Phase 2: Deploying the Stack

Run the stack in the background:
```bash
docker compose up -d
```

### Phase 3: Accessing the Gateway

Your simulated AWS environment is now available on **port 4566**.
You can interact with it using the `awslocal` CLI or by overriding the `--endpoint-url` in standard AWS CLI:

```bash
aws --endpoint-url=http://localhost:4566 s3 mb s3://my-test-bucket
```

---

## 🔗 Connection Summary

| Service               | Internal Port | External Visibility                        |
| :-------------------- | :------------ | :----------------------------------------- |
| **LocalStack Gateway**| `4566`        | Public (`http://localhost:4566`)           |
| **Service Ports**     | `4510-4559`   | Public                                     |
