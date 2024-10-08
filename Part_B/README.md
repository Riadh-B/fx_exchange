# FX Exchange Rates Database (Part B)

This folder contains SQL scripts, bash scripts, and utilities for managing a partitioned PostgreSQL database that stores high-frequency foreign exchange (FX) rates. It is optimized to handle up to 300 currency pairs with minute-level updates using **PostgreSQL partitioning** to improve performance and manageability.

## Project Overview

### Features:
- **Partitioned PostgreSQL Table**: Partitioning by `event_time` to optimize data storage and queries.
- **Efficient Indexing**: Indexes for faster query retrieval.
- **Dynamic Partition Management**: Automatic creation of new partitions daily via a scheduled script.
- **Scheduled Data Queries**: Fetch the latest FX rates every minute using a cron job.

---

## Setup Instructions


## Step 1: Set up Environment Variables 

Before running the script, you need to export the database environment variables (DB_NAME, DB_USER, DB_PASSWORD) securely.

Securely Set Environment Variables
Open your terminal and run the following commands to export the environment variables without storing them directly in the cronjob.sh script:

```bash
export DB_NAME="fx_exchange"
export DB_USER="user"
export DB_PASSWORD="your_secure_password"
```

### Step 2:  Initialize the Database
Run the following script to initialize the partitioned table, create the initial partitions, and set up indexes:

```bash
bash initialize_database.sh
bash indexes.sh
```

### Step 3:  Load Data
Place your FX rates CSV file in the data/ directory. You can use the provided sample file rates_sample.csv as an example. Run the following command to load the data into the database:

```bash
bash load_data.sh
```

### Step 4:  Schedule Partition Maintenance
The partition_maintenance.sh script automatically creates new partitions daily to store new data.
Open your cron scheduler:

```bash
crontab -e
```

Add the following cron job to run the partition maintenance every day at midnight:
```bash
0 0 * * * partition_maintenance.sh
```
This ensures that a new partition is created each day to store the new day's FX rates.

### Step 5: Schedule Query Execution
You can schedule the run_queries.sh script to fetch the latest rates every minute.
Open your cron scheduler:

```bash
crontab -e
```
Add the following cron job to execute the query every minute:

```bash
* * * * * run_query.sh
```

