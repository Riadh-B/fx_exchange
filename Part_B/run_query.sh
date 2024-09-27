#!/bin/bash
export DB_NAME="fx_exchange"
export DB_USER="postgres"
export DB_PASSWORD="1234"

# Execute queries
psql -U $DB_USER -d $DB_NAME -f ../sql_scripts/queries.sql
