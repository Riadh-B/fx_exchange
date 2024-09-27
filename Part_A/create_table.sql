CREATE TABLE IF NOT EXISTS fx_rates(
    id SERIAL PRIMARY KEY,
    ccy_couple VARCHAR(10),
    rate NUMERIC,
    event_time BIGINT
);

-- load_csv.sql: Load CSV data into fx_rates table
COPY fx_rates(ccy_couple, rate, event_time)
FROM 'Data/rates_sample.csv'
DELIMITER ',' 
CSV HEADER;