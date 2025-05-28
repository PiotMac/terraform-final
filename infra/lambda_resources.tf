data "archive_file" "grouper" {
    type        = "zip"
    source_dir  = "../src/lambda/grouper/"
    output_path = "../src/lambda/dist/grouper.zip"
}

data "archive_file" "aggregator" {
    type        = "zip"
    source_dir  = "../src/lambda/aggregator/"
    output_path = "../src/lambda/dist/aggregator.zip"
}