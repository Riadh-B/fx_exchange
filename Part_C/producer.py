import configparser
import csv
from time import sleep
from confluent_kafka import Producer
import json

# Load configuration
config = configparser.ConfigParser()
config.read('config.ini')

# Kafka producer configuration using credentials from config.ini
p = Producer({'bootstrap.servers': config['kafka']['bootstrap_servers']})

def delivery_report(err, msg):
    """ Callback for when a message is delivered or an error occurs """
    if err is not None:
        print('Message delivery failed: {}'.format(err))
    else:
        print('Message delivered to {} [{}]'.format(msg.topic(), msg.partition()))

# Function to produce messages from CSV file
def produce_rates(csv_file):
    with open(csv_file, mode='r') as file:
        csv_reader = csv.DictReader(file)
        for row in csv_reader:
            # Create message payload
            rate_data = {
                'ccy_couple': row['ccy_couple'],
                'rate': float(row['rate']),
                'event_time': int(row['event_time'])  # epoch time in ms
            }
            p.produce('fx_rates', value=json.dumps(rate_data), callback=delivery_report)
            p.poll(1)
            # Simulate real-time streaming (1 message per second)
            sleep(1)

if __name__ == '__main__':
    produce_rates('./Data/rates_sample.csv')
