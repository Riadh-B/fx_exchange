#  FX Rates Kafka Producer & Consumer

This part consists of two main components:

1. **Kafka Producer**: Reads data from a CSV file and streams currency exchange rates into a Kafka topic.
2. **Kafka Consumer**: Consumes messages from the Kafka topic, stores the rates in a PostgreSQL database, and calculates the percentage change between the current rate and yesterday's 5 PM rate.

### Requirements

- **Python 3.6+**
- **PostgreSQL**: Make sure PostgreSQL is running, and you have a database set up with the correct schema for storing FX rates.
- **Kafka**: You need a running Kafka broker to handle the message streaming.

### Table Schema (PostgreSQL)
To store the FX rates in PostgreSQL, you need to create the following table:

```bash
psql -U $DB_USER -d $DB_NAME -f create.sql

```

## Secure Configuration Using configparser
To securely manage database and Kafka credentials, this project uses configparser. All sensitive credentials are stored in a separate config.ini file, and the scripts read from this file.

1. Create config.ini
Here’s an example of the config.ini file. Place this file in the project’s root directory.

```bash
[database]
dbname = fx_exchange
user = postgres
password = secure_password
host = localhost
port = 5432

[kafka]
bootstrap_servers = localhost:9092
group_id = fx_rates_group
Important: Make sure to add config.ini to your .gitignore file to prevent it from being pushed to version control.
``` 

## Producer
The producer reads FX rate data from a CSV file and sends each row as a message to the Kafka topic fx_rates.

### Usage
Install dependencies:

```bash
pip install -r requirements.txt
```
Run the producer:

```bash
python producer.py
```
## Consumer
The consumer reads messages from the Kafka topic fx_rates, inserts the rates into PostgreSQL, and computes the percentage change between the current and yesterday's 5 PM rate.

### Usage
1. Ensure PostgreSQL is running and the table schema is set up.

2. Run the consumer to start consuming the Kafka stream:
```bash
python consumer.py
```

## Code Overview
Producer Configuration: Set the Kafka broker address (localhost:9092).
CSV Reading: The producer reads each row from the CSV and sends it as a JSON message to the Kafka topic fx_rates.
Real-time Simulation: A sleep of 1 second is used between each message to simulate real-time data streaming.