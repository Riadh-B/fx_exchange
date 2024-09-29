#!/bin/bash

# Create the main table and its initial partitions
psql -U $DB_USER -d $DB_NAME -f ../sql_scripts/create_partitioned_table.sql


# Set up indexes
psql -U $DB_USER -d $DB_NAME -f ../sql_scripts/indexes.sql

