import json
import boto3
import io
import csv
from datetime import datetime

# s3 = boto3.client('s3')

sqs = boto3.client('sqs')
QUEUE_URL = "https://sqs.us-east-1.amazonaws.com/677427606013/sensor-readings-queue"

def lambda_handler(event, context):
    # bucket_name = "sensorscsv"
    # file_key = "sensor-100k.csv"
    start_time = datetime.fromisoformat(event["start_time"].replace("Z", ""))
    end_time = datetime.fromisoformat(event["end_time"].replace("Z", ""))

    # response = s3.get_object(Bucket=bucket_name, Key=file_key)
    # file_content = response['Body'].read().decode('utf-8')

    # csv_reader = csv.DictReader(io.StringIO(file_content))

    # grouped_data = {}
    # for row in csv_reader:
    #     location = row["location_id"]
    #     value = float(row["temperature"])
    #     ts = datetime.fromisoformat(row["timestamp"])

    #     if start_time <= ts <= end_time:
    #         if location not in grouped_data:
    #             grouped_data[location] = []
    #         grouped_data[location].append(value)

    grouped_data = {}

    while True:
        messages = sqs.receive_message(
            QueueUrl=QUEUE_URL,
            MaxNumberOfMessages=10,
            WaitTimeSeconds=1,
            VisibilityTimeout=5
        ).get("Messages", [])

        if not messages:
            break

        for msg in messages:
            try:
                body = json.loads(msg["Body"])
                ts = datetime.fromisoformat(body["timestamp"])

                if start_time <= ts <= end_time:
                    loc = body["location_id"]
                    temp = float(body["temperature"])
                    grouped_data.setdefault(loc, []).append(temp)

                # sqs.delete_message(QueueUrl=QUEUE_URL, ReceiptHandle=msg["ReceiptHandle"])

            except Exception as e:
                print(f"Błąd w wiadomości: {e}")

    result = [{"location_id": loc, "temperatures": temps} for loc, temps in grouped_data.items()]
    
    return result
