# Calculate the average and sum of each member type’s ride duration of each day of week.
SELECT 
    started_day_of_week,
    member_casual,
    SUM(duration_minutes) AS sum_duration,
    AVG(duration_minutes) AS avg_duration
FROM 
    Cyclistic_Project.`tripdata_2024`
GROUP BY 
    started_day_of_week, 
    member_casual
ORDER BY 
    FIELD(started_day_of_week, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday',      'Saturday', 'Sunday'), 
    member_casual;

# Count the number of rides for each member type categorized by rideable type and the percentage of each rideable type used by each member type
SELECT 
    member_casual,
    rideable_type,
    COUNT(*) AS ride_count,
    ROUND(
        100 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY member_casual),
        2) AS usage_percentage
FROM 
    Cyclistic_Project.`tripdata_2024`
GROUP BY 
    member_casual, 
    rideable_type
ORDER BY 
    member_casual,
    FIELD(rideable_type, 'classic_bike', 'electric_bike', 'electric_scooter');

# Analyze how number of rides and its corresponding percent of total for each member type change throughout the day
SELECT 
    member_casual,
    HOUR(started_time) AS hour_of_day,
    COUNT(*) AS ride_count,
    ROUND((COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY member_casual)), 2) AS percentage_of_total
FROM 
    Cyclistic_Project.`tripdata_2024`
GROUP BY 
    member_casual,
    HOUR(started_time)
ORDER BY 
    member_casual, 
    hour_of_day;

# Analyze how the number of rides its corresponding percent of total for each member type change monthly
SELECT 
    member_casual,
    MONTH(started_date) AS month,
    COUNT(*) AS ride_count,
    ROUND((COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY member_casual)), 2) AS percentage_of_total
FROM 
    Cyclistic_Project.`tripdata_2024`
GROUP BY 
    member_casual,
    MONTH(started_date)
ORDER BY 
    member_casual, 
    month;
