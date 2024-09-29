-- This script will need to be executed by a job that checks daily if a new partition is needed

-- Placeholder function for creating a partition dynamically
CREATE OR REPLACE FUNCTION add_new_partition(start_epoch BIGINT, end_epoch BIGINT, partition_name TEXT) RETURNS VOID AS $$
BEGIN
    EXECUTE format('CREATE TABLE IF NOT EXISTS %I PARTITION OF fx_rates_partitioned FOR VALUES FROM (%s) TO (%s)', 
        partition_name, start_epoch, end_epoch);
END;
$$ LANGUAGE plpgsql;
    