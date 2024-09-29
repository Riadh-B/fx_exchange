import configparser
import psycopg2
from confluent_kafka import Consumer, KafkaError
import json
import time

# Load configuration
config = configparser.ConfigParser()
config.read('config.ini')

# Connect to PostgreSQL using credentials from config file
conn = psycopg2.connect(
    dbname=config['database']['dbname'],
    user=config['database']['user'],
    password=config['database']['password'],
    host=config['database']['host'],
    port=config['database']['port']
)
cur = conn.cursor()

# Kafka consumer setup using configuration from config.ini
consumer_conf = {
    'bootstrap.servers': config['kafka']['bootstrap_servers'],
    'group.id': config['kafka']['group_id'],
    'auto.offset.reset': 'earliest'
}
consumer = Consumer(consumer_conf)
consumer.subscribe(['fx_rates'])

# Insert rate into PostgreSQL
def insert_rate_into_db(rate_data):
    query = """
        INSERT INTO fx_rates (ccy_couple, rate, event_time)
        VALUES (%s, %s, %s)
    """
    cur.execute(query, (rate_data['ccy_couple'], rate_data['rate'], rate_data['event_time']))
    conn.commit()

# Process each message from Kafka and calculate percentage change
def process_message(message):
    rate_data = json.loads(message.value().decode('utf-8'))
    insert_rate_into_db(rate_data)
    
    sql_query = """
    WITH last_event_time AS (
        SELECT MAX(event_time) AS now_epoch
        FROM fx_rates
    ),
    active_rates AS (
        SELECT DISTINCT ON (ccy_couple)
            ccy_couple, 
            rate, 
            event_time
        FROM fx_rates, last_event_time
        WHERE event_time >= last_event_time.now_epoch - 30000
        ORDER BY ccy_couple, event_time DESC
    ),
    yesterday_at_5pm AS (
        SELECT (DATE_TRUNC('day', now() AT TIME ZONE 'America/New_York') - interval '1 day' + interval '17 hour') AT TIME ZONE 'America/New_York' AS yesterday_5pm
    ),
    yesterday_rates AS (
        SELECT DISTINCT ON (ccy_couple)
            ccy_couple, 
            rate, 
            event_time
        FROM fx_rates, yesterday_at_5pm
        WHERE event_time <= extract(epoch from yesterday_at_5pm.yesterday_5pm) * 1000
        ORDER BY ccy_couple, event_time DESC
    )
    SELECT a.ccy_couple, 
           a.rate AS current_rate, 
           (a.rate - y.rate) / y.rate * 100 AS percentage_change
    FROM active_rates a
    JOIN yesterday_rates y
    ON a.ccy_couple = y.ccy_couple;
    """
    
    cur.execute(sql_query)
    results = cur.fetchall()
    
    for row in results:
        print(f"Currency: {row[0]}, Current Rate: {row[1]}, Percentage Change: {row[2]:.2f}%")

# Consume messages in real time
try:
    while True:
        msg = consumer.poll(timeout=1.0)
        if msg is None:
            continue
        if msg.error():
            if msg.error().code() == KafkaError._PARTITION_EOF:
                continue
            else:
                print(msg.error())
                break

        process_message(msg)

finally:
    consumer.close()
    cur.close()
    conn.close()
