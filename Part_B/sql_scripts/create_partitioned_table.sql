-- Main partitioned table
CREATE TABLE IF NOT EXISTS fx_rates_partitioned (
    event_id SERIAL,
    ccy_couple TEXT NOT NULL,
    rate NUMERIC NOT NULL,
    event_time BIGINT NOT NULL,
    PRIMARY KEY (event_id, event_time) -- Include event_time in the primary key
) PARTITION BY RANGE (event_time);

-- Example of creating partitions for specific days (Adjust the epoch time as per actual data)
CREATE TABLE fx_rates_partition_20230924 PARTITION OF fx_rates_partitioned
FOR VALUES FROM (1695523200000) TO (1708466401710);

CREATE TABLE fx_rates_partition_20230925 PARTITION OF fx_rates_partitioned
FOR VALUES FROM (1695609600000) TO (1695696000000);


