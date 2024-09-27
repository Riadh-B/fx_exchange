# FX Rates PART A Cron Job

This repository contains SQL and shell scripts for automating the calculation of FX rates and percentage changes using a scheduled cron job. The cron job will:

1. Create the `fx_rates` table (if it doesn't already exist).
2. Load FX rate data from a CSV file.
3. Calculate the latest active FX rates within the last 30 seconds.
4. Compare the latest rates with those from yesterday at 5 PM and calculate the percentage change.



## Setup

### Step 1: Set up the Database

1. Update the `cronjob.sh` file with your PostgreSQL database credentials (DB_NAME, DB_USER, DB_PASSWORD).
2. Place your CSV file in the appropriate location and update the `CSV_PATH` in `cronjob.sh`.

### Step 2: Run the Shell Script

Run the following command to execute the `cronjob.sh` script manually:



### Step 3: Set up the Cron Job
Open the crontab configuration by typing:

```bash

crontab -e
Add the following line to run the cronjob.sh script every hour:

```bash
# Run the job every hour
0 * * * * /path/to/your/repository/fx_rate_cron_job/cronjob.sh