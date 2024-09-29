#!/bin/bash
# Configuration settings for partitioning, if needed
export PARTITION_SIZE_DAYS=1



# Today's and tomorrow's dates in epoch milliseconds
today_epoch=$(date +%s%N | cut -b1-13)
tomorrow_epoch=$((today_epoch + 86400000))

# Add new partition for the next day
psql -U $DB_USER -d $DB_NAME -c "SELECT add_new_partition($today_epoch, $tomorrow_epoch, 'fx_rates_partition_' || to_char(now(), 'YYYYMMDD'));" 