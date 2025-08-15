// lambda/index.js
const AWS = require("aws-sdk");
const { v4: uuidv4 } = require('uuid');

const ddb = new AWS.DynamoDB.DocumentClient({ region: process.env.REGION });
const comprehend = new AWS.Comprehend({ region: process.env.REGION });
const translate = new AWS.Translate({ region: process.env.REGION });
const ses = new AWS.SES({ region: process.env.REGION });

const TABLE = process.env.DYNAMO_TABLE;
const SENDER = process.env.SENDER_EMAIL;

exports.handler = async (event) => {
  console.log("Full event:", JSON.stringify(event, null, 2));
  console.log("Event body:", event.body);

  try {
    const body = JSON.parse(event.body);
    const { name, email, message } = body;

    if (!name || !email || !message) {
      return {
        statusCode: 400,
        body: JSON.stringify({ error: "Name, email, and message are required." }),
      };
    }

    // Detect language
    const detectParams = { Text: message };
    const detectData = await comprehend.detectDominantLanguage(detectParams).promise();
    const languageCode = detectData.Languages[0]?.LanguageCode || "en";
    console.log("Detected language:", languageCode);

    // Translate message if not English
    let translatedMessage = message;
    if (languageCode !== "en") {
      const translateParams = {
        Text: message,
        SourceLanguageCode: languageCode,
        TargetLanguageCode: "en"
      };
      const translateData = await translate.translateText(translateParams).promise();
      translatedMessage = translateData.TranslatedText;
      console.log("Translated message:", translatedMessage);
    }

    // Detect sentiment on translated message (in English)
    const sentimentData = await comprehend.detectSentiment({
      Text: translatedMessage,
      LanguageCode: "en"
    }).promise();
    const sentiment = sentimentData.Sentiment || "NEUTRAL";
    console.log("Detected sentiment:", sentiment);

    const timestamp = new Date().toISOString();

    // Save to DynamoDB
    const dbParams = {
      TableName: TABLE,
      Item: {
        id: uuidv4(),          // unique ID
        name,
        email,
        originalMessage: message,
        translatedMessage,
        sourceLang: languageCode,
        sentiment,
        timestamp: new Date().toISOString()
      }
    };

    await ddb.put(dbParams).promise();
    console.log("Saved to DynamoDB");

    // Email to the client (confirmation)
const emailParamsToSender = {
  Source: SENDER,
  Destination: { ToAddresses: [email] },  // client’s email address
  Message: {
    Subject: { Data: `Thank you for contacting BeachBay Hotel!` },
    Body: {
      Text: {
        Data: `Hi ${name},\n\nThanks for reaching out!\n\nWe received your message:\n\n"${message}"\n\nA memeber of our team will get back to you shortly.\n\nBest regards,\n\nBeachBay Guest Services`,
      },
    },
  },
};

// Email to hotel (notification)
const emailParamsToReceiver = {
  Source: SENDER,
  Destination: { ToAddresses: [SENDER] },  
  Message: {
    Subject: { Data: `New message from ${name}` },
    Body: {
      Text: {
        Data: `From: ${name} <${email}>\nLanguage: ${languageCode}\nSentiment: ${sentiment}\n\nOriginal:\n${message}\n\nTranslated:\n${translatedMessage}`,
      },
    },
  },
};


    // Send email and wait for it to finish before Lambda exits
    await ses.sendEmail(emailParamsToSender).promise();
    await ses.sendEmail(emailParamsToReceiver).promise();
    console.log("Email sent via SES");

    return {
      statusCode: 200,
      body: JSON.stringify({ message: "Message processed successfully" })
    };

  } catch (err) {
    console.error("Error processing message:", err);
    return {
      statusCode: 500,
      body: JSON.stringify({ error: "Internal Server Error" })
    };
  }
};
