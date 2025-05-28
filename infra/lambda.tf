module "grouper_lambda" {
  source = "./modules/lambda"
  filename = data.archive_file.grouper.output_path
  source_code_hash = data.archive_file.grouper.output_base64sha256
  function_name = "grouper_lambda"
  role_arn = data.aws_iam_role.main_role.arn
  handler       = "grouper/main.lambda_handler"
  runtime       = "python3.13"
  reserved_concurrent_executions = 4
}

# module "error_handling_lambda" {
#   source = "./modules/lambda"
#   filename = data.archive_file.error-handler.output_path
#   source_code_hash = data.archive_file.error-handler.output_base64sha256
#   function_name = "error-handler_lambda"
#   role_arn = data.aws_iam_role.lab_role.arn
#   handler       = "error-handler/main.lambda_handler"
#   runtime       = "python3.8"
#   reserved_concurrent_executions = 3
# }

module "aggregator_lambda" {
  source = "./modules/lambda"
  filename = data.archive_file.aggregator.output_path
  source_code_hash = data.archive_file.aggregator.output_base64sha256
  function_name = "aggregator_lambda"
  role_arn = data.aws_iam_role.main_role.arn
  handler       = "aggregator/main.lambda_handler"
  runtime       = "python3.13"
  reserved_concurrent_executions = 4
}