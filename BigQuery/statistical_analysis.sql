/*
	Significant Earthquakes
  Author: Ivan Musebe
	Email: musebeivan@gmail.com 
	LinkedIn: https://www.linkedin.com/in/musebe-ivan/
	
	File Name: statistical_analysis.bgsql
	
*/


-- A statistical overview and summaries of earthquake events:
--  The main purpose of this file is to provide descriptive statists of earthquake events.

-- General Statistics
-- How many earthquakes have since been recorded over the years?
SELECT
  year, COUNT(*) AS earthquake_count
FROM
 `youtube-factcheck.earthquake_analysis.earthquakes_copy`
GROUP BY year
ORDER BY year;

-- Global earthquake distrubution per day:
-- Add Date column
ALTER TABLE `youtube-factcheck.earthquake_analysis.earthquakes_copy`
ADD COLUMN Date DATE;

--  Populate the column joining month day and year
UPDATE `youtube-factcheck.earthquake_analysis.earthquakes_copy`
SET Date = 
  CASE
    WHEN year < 0 THEN DATE_ADD(DATE(ABS(year), month, day), INTERVAL 1 DAY)
    ELSE DATE(year, month, day)
  END
WHERE
 Date IS NULL;

-- Frequecy of earthquakes per day:
SELECT
  Date,
  COUNT(*) AS earthquake_count
FROM
  `youtube-factcheck.earthquake_analysis.earthquakes_copy`
GROUP BY Date
ORDER BY Date DESC;


-- The top 5 regions prone to eartquakes:
SELECT
  region_code, COUNT(*) AS no_of_eq
FROM
 `youtube-factcheck.earthquake_analysis.earthquakes_copy`
GROUP BY region_code
ORDER BY no_of_eq DESC
LIMIT 5;

-- The top 5 regions prone to earthquakes include:
/* 
| region_code | no_of_eq|
|           30|     1054|
|          130|      855|
|          170|      820|
|          140|      813|
|          160|      606|
*/

-- What are the countries that fall in region 30:
SELECT
  DISTINCT country
FROM
  `youtube-factcheck.earthquake_analysis.earthquakes_copy`
WHERE region_code = 30;

/*
| country     |
| CHINA       |
| JAPAN       |
| TAIWAN      |
| VIETNAM     |
| NORTH KOREA |
| SOUTH KOREA |
*/

-- Count the number of events in this countries:
SELECT
  country,
  COUNT(*) AS earthquake_count
FROM
  `youtube-factcheck.earthquake_analysis.earthquakes_copy`
WHERE
  country IN
  (
    SELECT DISTINCT country
    FROM `youtube-factcheck.earthquake_analysis.earthquakes_copy`
    WHERE region_code = 30
  )
GROUP BY country;

/*
| country     | earthquake_count |
| CHINA       |               609|
| JAPAN       |               411|
| TAIWAN      |                98|
| VIETNAM     |                 5|
| NORTH KOREA |                 6|
| SOUTH KOREA |                20|
*/

--  The Asia continent is prone to earthquake events compared to other continent.
--  Check the top locations in each country with the highest earthquake events:
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

/*
| country     | location_name   | earthquake_count |
| CHINA       | YUNNAN PROVINCE |              609 |
| TAIWAN      | TAIWAN          |              411 |
| JAPAN       | SANRIKU         |               98 |
| SOUTH KOREA | KYONGJU         |                5 |
| NORTH KOREA | KAESONG         |                6 |
*/


-- Check the top five locations in the country with highest earthquake events.
--  In this case CHINA:

SELECT
  cleaned_location AS location_name,
  earthquake_count
FROM
  CountryEarthquakeCounts
WHERE
  country =
  ( 
    SELECT
    country
    FROM
      (
        SELECT
          country,
          COUNT(*) AS earthquake_count
        FROM
          `youtube-factcheck.earthquake_analysis.earthquakes_copy`
        WHERE
          country IN
          (
            SELECT DISTINCT country
            FROM `youtube-factcheck.earthquake_analysis.earthquakes_copy`
            WHERE region_code = 30
          )
        GROUP BY country
      )
    LIMIT
      1)
ORDER BY
  earthquake_count DESC
LIMIT
  5;

/*
| location_name    | earthquake_count |
| YUNNAN PROVINCE  | 68               |
| SICHUAN PROVINCE | 44               |
| GANSU PROVINCE   | 27               |
| SHANXI PROVINCE  | 20               |
| HEBEI PROVINCE   | 16               |
*/


--  Count the number of earthquakes where tsunami's were recorded and where they were not:


SELECT
  flag_tsunami,
  COUNT(*) AS earthquake_count
FROM
 `youtube-factcheck.earthquake_analysis.earthquakes_copy`
GROUP BY flag_tsunami;

/*
| flag_tsunami | earthquake_count |
| Tsu          | 1869             |
| No Tsu       | 4403             |
*/


-- Distribution of earthquakes caused by Tsunami
SELECT
 year,
 COUNT(*) AS earthquake_count
FROM
 `youtube-factcheck.earthquake_analysis.earthquakes_copy`
WHERE
  flag_tsunami = "Tsu"
GROUP BY year
ORDER BY year;

--  In what region do Tsunamis frequently occur:
SELECT
 region_code,
 COUNT(*) AS earthquake_count
FROM
 `youtube-factcheck.earthquake_analysis.earthquakes_copy`
WHERE
  flag_tsunami = "Tsu"
GROUP BY region_code
ORDER BY earthquake_count
LIMIT 5;

/*
| region_code | earthquake_count |
| 170         |               434|
| 30          |               350|
| 160         |               217|
| 150         |               198|
| 130         |               198|
*/


--  Countries in the first two regions:
SELECT
  country,
  COUNT(*) AS earthquake_count
FROM
  `youtube-factcheck.earthquake_analysis.earthquakes_copy`
WHERE
  region_code IN
  (
    SELECT region_code
    FROM
      (
        SELECT
          region_code,
          COUNT(*) AS earthquake_count
        FROM
          `youtube-factcheck.earthquake_analysis.earthquakes_copy`
        WHERE
          flag_tsunami = "Tsu"
        GROUP BY region_code
        ORDER BY earthquake_count DESC
        LIMIT 2
      )
  )
GROUP BY country
ORDER BY earthquake_count DESC
LIMIT 5;

/*
| country     | earthquake_count |
| CHINA       | 514              |
| JAPAN       | 411              |
| PHILLIPINES | 221              |
| INDONESIA   | 177              |
| TAIWAN      | 98               |
*/

-- What months do we have tsunamis occur in the above countries:
SELECT
 month,
 COUNT(*) AS earthquake_count
FROM
 `youtube-factcheck.earthquake_analysis.earthquakes_copy`
WHERE
  flag_tsunami = "Tsu"
GROUP BY month
ORDER BY earthquake_count;

/*
| month | earthquake_count |
| 1     | 224              |
| 11    | 184              |
| 8     | 174              |
| 12    | 158              |
| 9     | 155              |
| 3     | 153              |
| 10     | 151             |
| 5     | 148              |
| 2     | 138              |
| 7     | 131              |
| 6     | 128              |
| 4     | 125              |
*/

-- Generally most tsunamis are recorded in the months of January, November, August, December and September

-- What is the average magnitude, intensity and focal depth of earthquakes in the top ten countries prone to earthquakes when tsunamis are recorded and when they are not:

WITH TopCountries AS (
  SELECT
    country,
    COUNT(*) AS earthquake_count
  FROM
    `youtube-factcheck.earthquake_analysis.earthquakes_copy`
  GROUP BY
    country
  ORDER BY
    earthquake_count DESC
  LIMIT 10
)

SELECT
  tc.country,
  COUNT(*),
  AVG(CASE WHEN flag_tsunami = 'Tsu' THEN eq_mag_mw END) AS avg_magnitude_tsunami,
  AVG(CASE WHEN flag_tsunami = 'No Tsu' THEN eq_mag_mw END) AS avg_magnitude_no_tsunami,
  AVG(CASE WHEN flag_tsunami = 'Tsu' THEN intensity END) AS avg_intensity_tsunami,
  AVG(CASE WHEN flag_tsunami = 'No Tsu' THEN intensity END) AS avg_intensity_no_tsunami,
  AVG(CASE WHEN flag_tsunami = 'Tsu' THEN focal_depth END) AS avg_focal_depth_tsunami,
  AVG(CASE WHEN flag_tsunami = 'No Tsu' THEN focal_depth END) AS avg_focal_depth_no_tsunami
FROM
  `youtube-factcheck.earthquake_analysis.earthquakes_copy` eq
JOIN
  TopCountries tc ON eq.country = tc.country
GROUP BY
  tc.country
ORDER BY
  MAX(tc.earthquake_count) DESC;
