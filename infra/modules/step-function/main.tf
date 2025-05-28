resource "aws_sfn_state_machine" "my_workflow" {
    name     = var.name
    role_arn = var.role_arn
definition = templatefile("${path.module}/${var.definition}", {
  grouper_lambda_arn    = var.grouper_lambda_arn
  # error_handling_lambda_arn = var.error_handling_lambda_arn
  aggregator_lambda_arn    = var.aggregator_lambda_arn
})
}