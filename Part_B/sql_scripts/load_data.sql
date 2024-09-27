-- load_data.sql
COPY fx_rates_partitioned (ccy_couple, rate, event_time)
FROM 'Data/rates_sample.csv'
DELIMITER ',' CSV HEADER;
