# Have a grasp of the datasets and ensure similar formats and data types before combining
DESCRIBE Cyclistic_Project.`202401-divvy-tripdata`; 
# Repeat for all tables

# Change the data type of two columns to DATETIME
ALTER TABLE Cyclistic_Project.`202401-divvy-tripdata`
MODIFY started_at DATETIME,
MODIFY ended_at DATETIME;
# Repeat for all tables

# Create a new table to combine data of 12 months into one
CREATE TABLE tripdata_2024 (
    ride_id TEXT,               
    rideable_type TEXT,          
    started_at DATETIME,                 
    ended_at DATETIME,                   
    start_station_name TEXT,     
    start_station_id TEXT,       
    end_station_name TEXT,       
    end_station_id TEXT,         
    start_lat DOUBLE,                    
    start_lng DOUBLE,                    
    end_lat DOUBLE,                      
    end_lng DOUBLE,                      
    member_casual TEXT            
    );

# Insert data into the new table
INSERT INTO tripdata_2024
SELECT * FROM Cyclistic_Project.`202401-divvy-tripdata`
UNION ALL
SELECT * FROM Cyclistic_Project.`202402-divvy-tripdata`
UNION ALL
SELECT * FROM Cyclistic_Project.`202403-divvy-tripdata`
UNION ALL
SELECT * FROM Cyclistic_Project.`202404-divvy-tripdata`
UNION ALL
SELECT * FROM Cyclistic_Project.`202405-divvy-tripdata`
UNION ALL
SELECT * FROM Cyclistic_Project.`202406-divvy-tripdata`
UNION ALL
SELECT * FROM Cyclistic_Project.`202407-divvy-tripdata`
UNION ALL
SELECT * FROM Cyclistic_Project.`202408-divvy-tripdata`
UNION ALL
SELECT * FROM Cyclistic_Project.`202409-divvy-tripdata`
UNION ALL
SELECT * FROM Cyclistic_Project.`202410-divvy-tripdata`
UNION ALL
SELECT * FROM Cyclistic_Project.`202411-divvy-tripdata`
UNION ALL
SELECT * FROM Cyclistic_Project.`202412-divvy-tripdata`;

# Check for duplicates
SELECT ride_id, count(*) 
FROM Cyclistic_Project.`tripdata_2024`
GROUP BY ride_id
HAVING COUNT(*) > 1;

# Check for null or blank values
SELECT *
FROM Cyclistic_Project.`tripdata_2024`
WHERE ride_id IS NULL OR ride_id = ‘’;
# Repeat for all columns

# Data consistency check 
SET SQL_SAFE_UPDATES = 0; # Unable safe mode
DELETE FROM Cyclistic_Project.`tripdata_2024`
WHERE started_at >= ended_at 
              OR start_lat < -90 OR start_lat > 90  # Latitude ranges from -90 to 90 degrees
              OR start_lng < -180 OR start_lng > 180  # Longitude ranges from -180 to 180
              OR end_lat < -90 OR end_lat > 90 
              OR end_lng < -180 OR end_lng > 180;
SET SQL_SAFE_UPDATES = 1; # Re-enable safe mode after the deletion

# Identify if any ride ID has more or less than 16 characters
SELECT length(ride_id) 
FROM Cyclistic_Project.`tripdata_2024`
WHERE length(ride_id) != 16;

# Check for record types in these two columns
SELECT DISTINCT member_casual, rideable_type
FROM Cyclistic_Project.`tripdata_2024`;

# Add new columns to separate date and time from started_at and ended_at
ALTER TABLE Cyclistic_Project.`tripdata_2024`
ADD COLUMN ended_date DATE AFTER ended_at,
ADD COLUMN ended_time TIME AFTER ended_date,
ADD COLUMN started_date DATE AFTER started_at,
ADD COLUMN started_time TIME AFTER started_date;

# Fill new columns with data from started_at and ended_at
UPDATE Cyclistic_Project.`tripdata_2024` 
SET started_date = DATE(started_at), 
        started_time = TIME(started_at), 
        ended_date = DATE(ended_at), 
        ended_time = TIME(ended_at);

# Add a new column to calculate the duration of each ride in minutes and round the result to 2 decimal places
ALTER TABLE Cyclistic_Project.`tripdata_2024`
ADD COLUMN duration_minutes FLOAT AFTER ended_time;
UPDATE Cyclistic_Project.`tripdata_2024`
SET duration_minutes = ROUND(TIMESTAMPDIFF(SECOND, started_at, ended_at) / 60, 2);

# Add a new column to identify the day of week of when a ride is started
ALTER TABLE Cyclistic_Project.`tripdata_2024`
ADD COLUMN started_day_of_week TEXT AFTER started_date;
UPDATE Cyclistic_Project.`tripdata_2024`
SET started_day_of_week = DAYNAME(started_date);

# Delete these two columns because they are no longer needed
ALTER TABLE Cyclistic_Project.`tripdata_2024`
DROP COLUMN started_at, ended_at;

