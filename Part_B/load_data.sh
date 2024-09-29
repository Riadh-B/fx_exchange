
# Load the data from CSV into the database
psql -U $DB_USER -d $DB_NAME -f ../sql_scripts/load_data.sql