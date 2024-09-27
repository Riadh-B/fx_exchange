#!/bin/bash
export DB_NAME="fx_exchange"
export DB_USER="postgres"
export DB_PASSWORD="1234"

# Create the main table and its initial partitions
psql -U $DB_USER -d $DB_NAME -f ../sql_scripts/create_partitioned_table.sql


# Set up indexes
psql -U $DB_USER -d $DB_NAME -f ../sql_scripts/indexes.sql


# Load the data from CSV into the database
psql -U $DB_USER -d $DB_NAME -f ../sql_scripts/load_data.sql