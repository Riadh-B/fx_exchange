# FX Exchange Rates Database (Part B)

This repository contains SQL scripts, bash scripts, and utilities for managing a partitioned PostgreSQL database that stores high-frequency foreign exchange (FX) rates. It is optimized to handle up to 300 currency pairs with minute-level updates using **PostgreSQL partitioning** to improve performance and manageability.

## Project Overview

### Features:
- **Partitioned PostgreSQL Table**: Partitioning by `event_time` to optimize data storage and queries.
- **Dynamic Partition Management**: Automatic creation of new partitions daily via a scheduled script.
- **Automated Data Loading**: Load currency rate data from CSV files.
- **Scheduled Data Queries**: Fetch the latest FX rates every minute using a cron job.
- **Efficient Indexing**: Indexes for faster query retrieval.

---

## Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/your-repo/fx_exchange.git
cd fx_exchange
```

### 2. Configure Database Settings
Edit the database configuration file located at cronjob.sh, run_query.sh and partition_maintenance.sh:
```bash
#!/bin/bash
export DB_NAME="fx_exchange"
export DB_USER="postgres"
export DB_PASSWORD="your_password"
```

### 3.  Initialize the Database
Run the following script to initialize the partitioned table, create the initial partitions, and set up indexes:

```bash
bash bash_scripts/initialize_database.sh
```

### 4. Load Data
Place your FX rates CSV file in the data/ directory. You can use the provided sample file rates_sample.csv as an example. Run the following command to load the data into the database:

```bash
bash bash_scripts/load_data.sh
```

### 4.  Schedule Partition Maintenance
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

### 6. Schedule Query Execution
You can schedule the run_queries.sh script to fetch the latest rates every minute.
Open your cron scheduler:
```bash
crontab -e
Add the following cron job to execute the query every minute:

```bash
* * * * * run_queries.sh
```

