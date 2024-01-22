# Analysing BigQuery Data with SQL

![bigquery runner](https://logowik.com/content/uploads/images/google-bigquery6102.jpg "bigquery runner installer")


# BigQuery Earthquake Data Analysis Repository
Welcome to the BigQuery Earthquake Data Analysis directory! This repository houses a collection of .bqsql files dedicated to analyzing earthquake data using Google BigQuery. The files included here cover essential aspects of data processing, from providing summary information to cleaning the data, performing feature engineering, and generating descriptive statistics. The results obtained from these queries serve as the foundation for visualizations in Tableau and Python.

## Data
This repository will be utilizing the Global Significant Earthquake Database, a comprehensive record spanning over 5,700 earthquakes from 2150 BC to the present. Hosted on Google BigQuery, this dataset not only details essential seismic information but also includes socio-economic data, political geography, and additional insights.

## Repository Structure
- **Summary Information**: Explore .bqsql files that offer comprehensive insights into the overall characteristics and key statistics of the earthquake data.
- **Data Cleaning**: Dive into files dedicated to cleaning and preprocessing the raw earthquake data, ensuring its accuracy and reliability for subsequent analyses.
- **Feature Engineering:** Uncover the .bqsql files focused on creating new features and enhancing the dataset to extract more meaningful information for advanced analytics.
- **Descriptive Statistics**: Access queries designed to generate descriptive statistics, enabling a deeper understanding of the patterns and trends within the earthquake dataset.

Below are a few examples of the queries available in this repository:

Eartquake table dimensions:
-
```SQL
SELECT
  total_entries,
  no_of_columns
FROM
  (SELECT COUNT(*) AS total_entries
   FROM `youtube-factcheck.earthquake_analysis.earthquakes_copy`) AS entries,
  (SELECT COUNT(DISTINCT column_name) AS no_of_columns
   FROM `youtube-factcheck`.earthquake_analysis.INFORMATION_SCHEMA.COLUMNS
   WHERE table_name = "earthquakes_copy") AS columns;
```
The query outputs the number of unique variables and the total records in the table.

Output:
| total_entries| no_of_columns|
| -------------|--------------|
|          6272|            48|


Top Earthquake-Prone locations in the five countries with the highest earthquake counts:
-
```SQL
WITH CountryEarthquakeCounts AS (
  SELECT
    country,
    REGEXP_REPLACE(location_name, '^[^:]+:', '') AS cleaned_location,
    COUNT(*) AS earthquake_count,
    RANK() OVER (PARTITION BY country ORDER BY COUNT(*) DESC) AS rank
  FROM
     `youtube-factcheck.earthquake_analysis.earthquakes_copy`
  WHERE
    country IN (
      SELECT DISTINCT country
      FROM `youtube-factcheck.earthquake_analysis.earthquakes_copy`
      WHERE region_code = 30
    )
  GROUP BY
    country,
    cleaned_location
)

SELECT
  country,
  cleaned_location AS location_name,
  earthquake_count
FROM
  CountryEarthquakeCounts
WHERE
  rank = 1
ORDER BY
  earthquake_count DESC
LIMIT
  5;
```

Ouput:
| country     | location_name   | earthquake_count |
| ----------- | --------------- | ---------------- |
| CHINA       | YUNNAN PROVINCE |              609 |
| TAIWAN      | TAIWAN          |              411 |
| JAPAN       | SANRIKU         |               98 |
| SOUTH KOREA | KYONGJU         |                5 |
| NORTH KOREA | KAESONG         |                6 |

These queries are designed as pipelines, providing you the flexibility to explore, adapt, and build upon them for your specific analysis requirements. Feel free to dive in and enjoy the analytical journey!