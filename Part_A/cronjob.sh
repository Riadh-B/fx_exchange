#!/bin/bash
# cronjob.sh

# Set the database variables
export DB_NAME="fx_exchange"
export DB_USER="postgres"
export DB_PASSWORD="1234"

# Step 1: Create the fx_rates table (if it doesn't exist)
psql -U $DB_USER -d $DB_NAME -f sql_scripts/create.sql
# Run the SQL query
psql -U $DB_USER -d $DB_NAME -f sql_scripts/fx_rates_query.sql
