WITH last_event_time AS (
    -- Use now() as the current time 
    SELECT extract(epoch from now()) * 1000 AS now_epoch
),
active_rates AS (
    -- Get the latest rate for each currency pair, making sure it's within the last 30 seconds
    SELECT DISTINCT ON (ccy_couple) 
        ccy_couple, 
        rate, 
        event_time
    FROM fx_rates, last_event_time
    WHERE event_time >= last_event_time.now_epoch - 30000
    ORDER BY ccy_couple, event_time DESC
),
yesterday_at_5pm AS (
    -- Calculate 'yesterday at 5 PM New York time
    SELECT (DATE_TRUNC('day', now() AT TIME ZONE 'America/New_York') - interval '1 day' + interval '17 hour') AT TIME ZONE 'America/New_York' AS yesterday_5pm
),
yesterday_rates AS (
    -- Get the rates from yesterday at 5 PM New York time
    SELECT DISTINCT ON (ccy_couple)
        ccy_couple, 
        rate, 
        event_time
    FROM fx_rates, yesterday_at_5pm
    WHERE event_time <= extract(epoch from yesterday_at_5pm.yesterday_5pm) * 1000
    ORDER BY ccy_couple, event_time DESC
)
-- Calculate the percentage change between current and yesterday's 5 PM rates
SELECT a.ccy_couple, 
       a.rate AS current_rate, 
       (a.rate - y.rate) / y.rate * 100 AS percentage_change
FROM active_rates a
JOIN yesterday_rates y
ON a.ccy_couple = y.ccy_couple;
