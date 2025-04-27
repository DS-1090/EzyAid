from kafka import KafkaConsumer
import redis
import json

# Connect to Redis
redis_client = redis.Redis(host="redis_ezyaid", port=6379, db=0, decode_responses=True)

# Kafka Consumer with safer error handling
consumer = KafkaConsumer(
    bootstrap_servers="kafka_ezyaid:9092",
    auto_offset_reset="earliest",
    group_id="schemeupdateconsumer",
    value_deserializer=lambda m: json.loads(m.decode('utf-8'))

)
consumer.subscribe(pattern="ezyaid.ezyaid.schemeDirectory")  # Subscribe to all topics

print("Kafka Consumer is running and listening for messages...")

def store_in_redis(record_id, updated_fields):
    redis_key = f"schemeDirectory:{record_id}"
    print(redis_key)
    for k, v in updated_fields.items():
        redis_client.hset(redis_key, k, v)

try:
     for message in consumer:
        data = message.value
        payload = data.get("payload", {})
        after = payload.get("after")

        if after:
            record_id = after.get("id")
            if record_id:
                # Filter only non-null fields
                updates = {k: v for k, v in after.items() if v is not None}
                print(f"[INFO] Writing to Redis for ID {record_id}: {updates}")
                store_in_redis(record_id, updates)

except KeyboardInterrupt:
    pass
finally:
    consumer.close()