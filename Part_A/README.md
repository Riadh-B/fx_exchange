# FX Rates PART A Cron Job

This folder contains SQL and shell scripts for automating the calculation of FX rates and percentage changes using a scheduled cron job. The cron job will:

1. Create the `fx_rates` table (if it doesn't already exist).
2. Load FX rate data from a CSV file.
3. Calculate the latest active FX rates within the last 30 seconds.
4. Compare the latest rates with those from yesterday at 5 PM and calculate the percentage change.



## Step 1: Set up Environment Variables 

Before running the script, you need to export the database environment variables (DB_NAME, DB_USER, DB_PASSWORD) securely.

Securely Set Environment Variables
Open your terminal and run the following commands to export the environment variables without storing them directly in the cronjob.sh script:

```bash
export DB_NAME="fx_exchange"
export DB_USER="user"
export DB_PASSWORD="your_secure_password"
```

### Step 2: Set up the Database

1. Update the cronjob.sh file if necessary (e.g., paths to SQL scripts or CSV files).
2. Place the CSV file in the appropriate location and update the CSV_PATH variable in cronjob.sh.

### Step 3: Run the Shell Script

Run the following command to execute the `cronjob.sh` script manually:

```bash
bash cronjob.sh
```

### Step 4: Set up the Cron Job
To schedule the script to run automatically, you can set up a cron job. Open the crontab configuration by typing:
```bash
crontab -e
```
Then, add the following line to run the job every hour:

```bash
# Run the job every hour
0 * * * * cronjob.sh
```