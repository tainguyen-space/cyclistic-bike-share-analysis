# Cyclistic Bike-Share Analysis

## Project Overview
This project analyzes bike-share usage data for Cyclistic (a fictional company based on Divvy data)
to identify behavioral differences between annual members and casual riders.
The goal is to support data-driven marketing strategies to increase annual memberships.

## Business Question
How do annual members and casual riders use Cyclistic bikes differently?

## Data Source
- Data is officially from Divvy's bike-share system (https://divvytripdata.s3.amazonaws.com/index.html)
- The data has been made publicly available by Motivate International Inc. under this license: https://divvybikes.com/data-license-agreement
- The data is hosted on an Amazon S3 bucket under the directory "divvy-tripdata." The data is stored as ZIP files that, when extracted, contain CSV structured datasets
- 12 latest available datasets are used; they contain monthly trip data of 2024 (202401-divvy-tripdata.csv ... 202412-divvy-tripdata.csv)
- Data includes ride ID, rideable type, ride start/end date and time, start/end location name and ID, start/end location longitude and         latitude, and member type

## Tools Used
- SQL (MySQL)
- Tableau
- GitHub

## Data Cleaning & Preparation
- Combined 12 monthly datasets (~6 million rows)
- Standardized datetime formats
- Removed invalid timestamps and coordinates
- Engineered ride duration and time-based features
- Created weekday, monthly, and hourly dimensions

## Key Insights
- Annual members take significantly more rides, but with shorter average duration
- Casual riders show strong leisure-based patterns, especially on weekends and evenings
- Members peak during commuting hours (6-8 AM, ~5 PM)
- Both groups peak during summer months, with casual riders more seasonally sensitive

## Visualizations
![Visuals](visuals)

## Recommendations
- Introduce reward-based programs to incentivize frequent casual riders to convert
- Promote safety and late-night features for casual riders
- Launch seasonal and weekend-focused membership campaigns

## Skills Demonstrated
- SQL data cleaning and transformation
- Large-scale dataset handling
- Analytical reasoning
- Business-oriented insights
- Data visualization

