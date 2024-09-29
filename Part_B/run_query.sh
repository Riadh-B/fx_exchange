#!/bin/bash

# Execute queries
psql -U $DB_USER -d $DB_NAME -f ../sql_scripts/queries.sql
