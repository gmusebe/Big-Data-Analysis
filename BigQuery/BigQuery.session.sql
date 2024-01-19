-- Count the total number of entries in the data:
-- SELECT COUNT(*) AS total_entries
-- FROM
--   `youtube-factcheck.earthquake_analysis.earthquakes_copy`


SELECT
  column_name,
  COUNT(*) AS total_rows,
  (COUNT(*) - COUNT(column_name)) * 100.0 / COUNT(*) AS missing_percentage
FROM
  `youtube-factcheck.earthquake_analysis.earthquakes_copy`
GROUP BY
  column_name
ORDER BY
  missing_percentage DESC;