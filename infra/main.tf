data "aws_iam_role" "main_role" {
  name = "LabRole"
}

resource "aws_sqs_queue" "data_queue" {
  name = "data-queue"
}