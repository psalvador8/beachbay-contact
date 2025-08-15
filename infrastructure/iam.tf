
# Get the current account ID so we can construct ARNs
data "aws_caller_identity" "current" {}

# Lambda execution role
resource "aws_iam_role" "lambda_exec_role" {
  name = "${var.lambda_function_name}-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })

  tags = {
    Project = "BeachBayContact"
  }
}

# Attach AWS-managed policy for basic Lambda execution (CloudWatch Logs)
resource "aws_iam_role_policy_attachment" "lambda_basic_attach" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Inline policy for Lambda to access DynamoDB, SES, Comprehend, Translate
resource "aws_iam_role_policy" "lambda_permissions" {
  name = "${var.lambda_function_name}-inline-policy"
  role = aws_iam_role.lambda_exec_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      # DynamoDB access (scoped to the table)
      {
        Effect = "Allow",
        Action = [
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:GetItem",
          "dynamodb:Query",
          "dynamodb:BatchWriteItem"
        ],
        Resource = "arn:aws:dynamodb:${var.aws_region}:${data.aws_caller_identity.current.account_id}:table/${var.dynamodb_table_name}"
      },

      # CloudWatch Logs (already covered by managed policy, but keep for completeness if needed)
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:*"
      },

      # SES send permissions - allow SendEmail/SendRawEmail (consider scoping to verified identity later)
      {
        Effect = "Allow",
        Action = [
          "ses:SendEmail",
          "ses:SendRawEmail",
          "ses:GetSendQuota",
          "ses:GetSendStatistics"
        ],
        Resource = "*"
      },

      # Amazon Comprehend (NLP)
      {
        Effect = "Allow",
        Action = [
          "comprehend:DetectSentiment",
          "comprehend:DetectKeyPhrases",
          "comprehend:DetectEntities",
          "comprehend:DetectDominantLanguage"
        ],
        Resource = "*"
      },

      # Amazon Translate
      {
        Effect = "Allow",
        Action = [
          "translate:TranslateText",
          "translate:Translate",
          "translate:DetectDominantLanguage"
        ],
        Resource = "*"
      }
    ]
  })
}
