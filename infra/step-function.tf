module "workflow" {
    source = "./modules/step-function"
    name     = "workflow"
    role_arn = data.aws_iam_role.main_role.arn
    definition = "workflow.json"
    grouper_lambda_arn    = module.grouper_lambda.lambda_function_arn
    # error_handling_lambda_arn = module.error_handling_lambda.lambda_function_arn
    aggregator_lambda_arn    = module.aggregator_lambda.lambda_function_arn
}