-- Creating an index on each partition for faster retrieval
CREATE INDEX ON fx_rates_partitioned (ccy_couple, event_time DESC);
