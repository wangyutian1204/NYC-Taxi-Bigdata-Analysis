-- ============================================
-- NYC Taxi Trip Feature Analysis
-- Using Feature-Engineered Dataset (data_encoded.csv)
-- SQL Analysis Project
-- MySQL 8.0+
-- ============================================

-- ============================================
-- 0. Notes
-- ============================================
-- This script is fully rerunnable
-- Drops old table if exists, creates table, loads data, performs basic validation and analysis.
-- Make sure 'data_encoded.csv' is placed in the MySQL server's accessible directory.
-- Update file path below if needed.

-- ============================================
-- 1. Drop Old Table (if exists)
-- ============================================
DROP TABLE IF EXISTS taxi_trips_features;

-- ============================================
-- 2. Create Table Matching CSV Columns
-- ============================================
CREATE TABLE taxi_trips_features (
    id INT AUTO_INCREMENT PRIMARY KEY,           -- Auto-generated ID
    vendor_id INT,
    passenger_count INT,
    pickup_longitude DOUBLE,
    pickup_latitude DOUBLE,
    dropoff_longitude DOUBLE,
    dropoff_latitude DOUBLE,
    log_trip_duration DOUBLE,
    hour INT,
    day_of_week INT,
    month INT,
    haversine_distance DOUBLE,
    manhattan_distance DOUBLE,
    euclidean_distance DOUBLE,
    lat_diff DOUBLE,
    lon_diff DOUBLE
);

-- ============================================
-- 3. Load Data from CSV
-- ============================================
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data_encoded.csv'
INTO TABLE taxi_trips_features
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    vendor_id,
    passenger_count,
    pickup_longitude,
    pickup_latitude,
    dropoff_longitude,
    dropoff_latitude,
    log_trip_duration,
    hour,
    day_of_week,
    month,
    haversine_distance,
    manhattan_distance,
    euclidean_distance,
    lat_diff,
    lon_diff
);

-- ============================================
-- 4. Basic Validation Queries
-- ============================================

-- Total rows loaded
SELECT COUNT(*) AS total_rows FROM taxi_trips_features;

-- Check for missing values in key columns
SELECT
    SUM(vendor_id IS NULL) AS vendor_nulls,
    SUM(passenger_count IS NULL) AS passenger_nulls,
    SUM(log_trip_duration IS NULL) AS duration_nulls
FROM taxi_trips_features;

-- Passenger count distribution
SELECT passenger_count, COUNT(*) AS trips
FROM taxi_trips_features
GROUP BY passenger_count
ORDER BY passenger_count;

-- Hourly trip distribution
SELECT hour, COUNT(*) AS trips
FROM taxi_trips_features
GROUP BY hour
ORDER BY hour;

-- ============================================
-- 5. Analytical Queries
-- ============================================

-- A. Average trip duration vs Haversine distance
SELECT
    ROUND(haversine_distance, 1) AS distance_km,
    AVG(EXP(log_trip_duration)) AS avg_trip_duration_sec
FROM taxi_trips_features
GROUP BY ROUND(haversine_distance, 1)
ORDER BY distance_km;

-- B. Trips by day type (Weekday vs Weekend)
SELECT
    CASE
        WHEN day_of_week IN (1, 7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    COUNT(*) AS trips,
    AVG(haversine_distance) AS avg_distance_km
FROM taxi_trips_features
GROUP BY day_type;

-- C. Passenger count vs average trip duration
SELECT
    passenger_count,
    AVG(EXP(log_trip_duration)) AS avg_duration_sec
FROM taxi_trips_features
GROUP BY passenger_count
ORDER BY passenger_count;

-- D. Vendor comparison (average duration and distance)
SELECT
    vendor_id,
    COUNT(*) AS trips,
    AVG(EXP(log_trip_duration)) AS avg_duration_sec,
    AVG(haversine_distance) AS avg_distance_km
FROM taxi_trips_features
GROUP BY vendor_id;

-- ============================================
-- 6. Performance Optimization (Optional)
-- ============================================

-- Create indexes for faster querying on common columns
CREATE INDEX idx_hour ON taxi_trips_features(hour);
CREATE INDEX idx_passenger_count ON taxi_trips_features(passenger_count);
CREATE INDEX idx_vendor ON taxi_trips_features(vendor_id);

-- Test query plan
EXPLAIN SELECT * FROM taxi_trips_features WHERE hour = 8;

-- ============================================
-- 7. Preview first 10 rows
-- ============================================
SELECT * FROM taxi_trips_features
LIMIT 10;