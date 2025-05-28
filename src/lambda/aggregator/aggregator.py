def lambda_handler(event, context):
    location_id = event["location_id"]
    temperatures = event["temperatures"]

    avg_temp = sum(temperatures) / len(temperatures)

    return {
        "location_id": location_id,
        "average_temperature": avg_temp
    }