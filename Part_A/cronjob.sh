#!/bin/bash
# cronjob.sh

# Set the database variables
DB_NAME="fx_exchange"
DB_USER="postgres"
DB_PASSWORD="1234"

# Step 1: Create the fx_rates table (if it doesn't exist)
psql -U $DB_USER -d $DB_NAME -f sql/create.sql
# Run the SQL query
psql -U $DB_USER -d $DB_NAME -f fx_rates_query.sql
