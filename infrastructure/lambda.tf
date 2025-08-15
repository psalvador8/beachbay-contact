

# Lambda function
resource "aws_lambda_function" "contact_handler" {
  function_name = var.lambda_function_name

  # Use path.module to resolve relative path from lambda.tf location
  filename         = "${path.module}/../lambda/package.zip"
  source_code_hash = filebase64sha256("${path.module}/../lambda/package.zip")


  handler = "index.handler"
  runtime = "nodejs20.x"
  role    = aws_iam_role.lambda_exec_role.arn

  environment {
    variables = {
      DYNAMO_TABLE  = var.dynamodb_table_name
      SENDER_EMAIL  = var.ses_sender_email
      NOTIFY_EMAIL  = var.ses_notify_email
      REGION        = var.aws_region
    }
  }

  tags = {
    Project = "BeachBayContact"
  }
}


