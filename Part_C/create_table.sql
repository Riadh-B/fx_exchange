CREATE TABLE fx_rates (
    id SERIAL PRIMARY KEY,
    ccy_couple TEXT NOT NULL,
    rate NUMERIC NOT NULL,
    event_time BIGINT NOT NULL
);
