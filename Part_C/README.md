#  FX Rates Kafka Producer & Consumer
This project consists of two main components:

Kafka Producer: Reads data from a CSV file and streams currency exchange rates into a Kafka topic.
Kafka Consumer: Consumes messages from the Kafka topic, stores the rates in a PostgreSQL database, and calculates percentage change between the current rate and yesterday's 5 PM rate.

##  Requirements
Python 3.6+
PostgreSQL: Make sure PostgreSQL is running, and you have a database set up with the correct schema for storing FX rates.
Kafka: You need a running Kafka broker to handle the message streaming.

Table Schema (PostgreSQL)
To store the FX rates in PostgreSQL, you need to create the following table:


```bash
CREATE TABLE fx_rates (
    id SERIAL PRIMARY KEY,
    ccy_couple TEXT NOT NULL,
    rate NUMERIC NOT NULL,
    event_time BIGINT NOT NULL
);

```
## Producer
The producer reads FX rate data from a CSV file and sends each row as a message to the Kafka topic.

### Usage
Install dependencies:

```bash
pip install confluent_kafka
```
Run the producer:

```bash
python producer.py
```

The CSV file must contain the following headers:

ccy_couple: The currency pair (e.g., "EUR/USD").
rate: The exchange rate.
event_time: The time of the rate event in epoch milliseconds.

## Code Overview
Producer Configuration: Set the Kafka broker address (localhost:9092).
CSV Reading: The producer reads each row from the CSV and sends it as a JSON message to the Kafka topic fx_rates.
Real-time Simulation: A sleep of 1 second is used between each message to simulate real-time data streaming.