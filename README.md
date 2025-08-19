# BeachBay Hotel Guest Contact Form

A cloud-based contact form solution for hotels, built using **AWS Lambda**, **Amazon Comprehend**, **Amazon Translate**, **Amazon SES**, and **DynamoDB**.  
This system allows hotel guests to send messages in any language, automatically detects the language, translates the message into English, analyzes sentiment, stores the message in DynamoDB, and sends an email notification to the hotel.

Access Medum article [here](https://medium.com/@psalvador8/building-a-serverless-ai-contact-form-with-aws-and-terraform-enhancing-guest-communication-at-aeae50b4d354)
---

## Features

- **Language detection** using Amazon Comprehend.
- **Automatic translation** to English using Amazon Translate.
- **Sentiment analysis** to understand guest tone (positive, negative, neutral).
- **Message storage** in DynamoDB for record-keeping.
- **Email notifications** to the hotel and sender using Amazon SES.
- **Error handling** for failed requests.

---

## Architecture

1. **Frontend**  
   HTML form with fields for name, email, and message.  
   JavaScript sends form data to API Gateway.

2. **API Gateway**  
   Receives HTTP requests and triggers AWS Lambda.

3. **AWS Lambda**  
   - Detects language and sentiment with Amazon Comprehend.  
   - Translates non-English messages with Amazon Translate.  
   - Stores original and translated messages in DynamoDB.  
   - Sends email notifications using Amazon SES.

4. **DynamoDB**  
   Stores guest messages with metadata (language, sentiment, timestamp).

5. **Amazon SES**  
   Sends an email containing the original and translated message to the hotel.

---

## Technologies Used

- **AWS Lambda** – Serverless compute
- **Amazon Comprehend** – Language detection & sentiment analysis
- **Amazon Translate** – Language translation
- **Amazon SES** – Email delivery
- **Amazon DynamoDB** – NoSQL database
- **API Gateway** – HTTP endpoint
- **HTML/CSS/JavaScript** – Frontend

---

## Setup Instructions

### 1. Clone the Repository
```bash
git clone https://github.com/YOUR_USERNAME/beachbay-hotel-contact.git
cd beachbay-hotel-contact
## 2. Configure AWS

1. **Create a DynamoDB table** with primary key: `id` (string).  
2. **Verify your sender email** in Amazon SES.  
3. **Create a Lambda function** and attach an IAM role with permissions for:  
   - DynamoDB  
   - Comprehend  
   - Translate  
   - SES  
4. **Set environment variables** in Lambda:  
   - `REGION`  
   - `DYNAMO_TABLE`  
   - `SENDER`  

## 3. Deploy Backend

1. Upload `lambda/index.js` to your Lambda function.  
2. Connect Lambda to **API Gateway** for HTTP `POST` requests.  

## 4. Deploy Frontend

1. Update `script.js` with your API Gateway endpoint URL.  
2. Host `index.html`, `styles.css`, and `script.js` on **S3**, **Amplify**, or any static hosting solution.
