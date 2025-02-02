# EXPLORATORY DATA ANALYSIS 


-- Most common programming language among developers
SELECT MainBranch, LanguageWorkedWith, COUNT(LanguageWorkedWith) AS programming_languages
FROM cs_students
WHERE MainBranch = "Developer"
GROUP BY MainBranch, LanguageWorkedWith
ORDER BY programming_languages DESC
LIMIT 5;

-- Most common programming language among none developers 
SELECT MainBranch, LanguageWorkedWith, COUNT(LanguageWorkedWith) AS programming_languages
FROM cs_students
WHERE MainBranch = "Not Developer"
GROUP BY MainBranch, LanguageWorkedWith
ORDER BY programming_languages DESC
LIMIT 5;

-- What % of CS students are by gender (895 students)
SELECT 
gender, 
COUNT(gender) AS gender_count,
ROUND((COUNT(gender) * 100.0 / (SELECT COUNT(*) FROM cs_students)), 2) AS perc_gender
FROM cs_students
GROUP BY gender
LIMIT 3;

-- What countries have the most CS students
SELECT 
IFNULL(country, 'Total') AS country, 
COUNT(country) AS country_count,
ROUND((COUNT(country) * 100.0 / (SELECT COUNT(*) FROM cs_students)), 2) AS perc_country 
FROM cs_students
GROUP BY country WITH ROLLUP
ORDER BY country_count DESC 
;

-- AVG age of developers 
SELECT 
CEILING(AVG(age)) AS avg_age
FROM cs_students
WHERE age IS NOT NULL;

-- Most commonly used database
SELECT 
DatabaseWorkedWith,
COUNT(DatabaseWorkedWith) AS total_db
FROM cs_students
WHERE DatabaseWorkedWith IS NOT NULL
GROUP BY DatabaseWorkedWith
ORDER BY total_db DESC;

-- Most commonly used platform
SELECT 
PlatformWorkedWith,
COUNT(PlatformWorkedWith) AS total_pf
FROM cs_students
WHERE PlatformWorkedWith IS NOT NULL
GROUP BY PlatformWorkedWith
ORDER BY total_pf DESC;

-- Most commonly used platform
SELECT 
WebFrameWorkedWith,
COUNT(WebFrameWorkedWith) AS total_wf
FROM cs_students
WHERE WebFrameWorkedWith IS NOT NULL
GROUP BY WebFrameWorkedWith
ORDER BY total_wf DESC;

-- Most commonly used developer environment
SELECT 
DevEnviron,
COUNT(DevEnviron) AS total_de
FROM cs_students
WHERE DevEnviron IS NOT NULL
GROUP BY DevEnviron
ORDER BY total_de DESC;

-- How many cs students have a degree and their %
SELECT 
IFNULL(EdLevel, 'Total') AS EducationCount,
COUNT(EdLevel) AS total_ed,
ROUND((COUNT(EdLevel) * 100.0 / (SELECT COUNT(*) FROM cs_students)), 2) AS perc_ed
FROM cs_students
WHERE EdLevel IS NOT NULL
GROUP BY EdLevel WITH ROLLUP
ORDER BY total_ed DESC
;

-- Top 5 most commonly used programming languages in United States
SELECT 
country, 
LanguageWorkedWith,
COUNT(LanguageWorkedWith) AS num_lang
FROM cs_students 
WHERE country = "United States"
GROUP BY country, LanguageWorkedWith
ORDER BY num_lang DESC
LIMIT 5
;

-- Top 5 most commonly used programming languages in India
SELECT 
country, 
LanguageWorkedWith,
COUNT(LanguageWorkedWith) AS num_lang
FROM cs_students 
WHERE country = "India"
GROUP BY country, LanguageWorkedWith
ORDER BY num_lang DESC
LIMIT 5
;

-- Top 5 most commonly used programming languages in uk
SELECT 
country, 
LanguageWorkedWith,
COUNT(LanguageWorkedWith) AS num_lang
FROM cs_students 
WHERE country = "United Kingdom"
GROUP BY country, LanguageWorkedWith
ORDER BY num_lang DESC
LIMIT 5
;

-- Compare most popular programming language to most desired in the future 
SELECT 
LanguageWorkedWith,
COUNT(LanguageWorkedWith) AS total_count,
COUNT(LanguageDesireNextYear) AS total_desired_count
FROM cs_students
WHERE LanguageWorkedWith IS NOT NULL
GROUP BY LanguageWorkedWith
ORDER BY total_count DESC
;

-- Identify what languages current students are looking to learn next year
SELECT 
LanguageDesireNextYear,
COUNT(LanguageDesireNextYear) AS total_desired_count
FROM cs_students
WHERE LanguageWorkedWith IS NOT NULL 
AND Student = 'Y'
GROUP BY LanguageDesireNextYear
ORDER BY total_desired_count DESC
LIMIT 5
;

-- Identify what databases current students are looking to learn next year
SELECT 
DatabaseDesiredNextYear,
COUNT(DatabaseDesiredNextYear) AS total_desired_count
FROM cs_students
WHERE DatabaseDesiredNextYear IS NOT NULL 
AND Student = 'Y'
GROUP BY DatabaseDesiredNextYear
ORDER BY total_desired_count DESC
LIMIT 5
;

-- Identify what databases current students are looking to learn next year
SELECT 
WebFrameDesiredNextYear,
COUNT(WebFrameDesiredNextYear) AS total_desired_count
FROM cs_students
WHERE WebFrameDesiredNextYear IS NOT NULL 
AND Student = 'Y'
GROUP BY WebFrameDesiredNextYear
ORDER BY total_desired_count DESC
LIMIT 5
;

-- See if there's a trend in what younger vs. older developers are looking to learn next
-- Younger age 18-39
SELECT 
  WebFrameDesiredNextYear,
  COUNT(WebFrameDesiredNextYear) AS total_desired_count
FROM cs_students
WHERE WebFrameDesiredNextYear IS NOT NULL 
  AND AGE BETWEEN 18 AND 40
GROUP BY WebFrameDesiredNextYear
ORDER BY total_desired_count DESC
LIMIT 5
;

-- See if there's a trend in what younger vs. older developers are looking to learn next
-- Older age 40+
SELECT 
  WebFrameDesiredNextYear,
  COUNT(WebFrameDesiredNextYear) AS total_desired_count
FROM cs_students
WHERE WebFrameDesiredNextYear IS NOT NULL 
  AND AGE >= 40
GROUP BY WebFrameDesiredNextYear
ORDER BY total_desired_count DESC
LIMIT 5
;

-- What % of CS students dont use social media at all
SELECT 
ROUND(COUNT(SocialMedia) / 
((SELECT COUNT(SocialMedia) FROM cs_students WHERE SocialMedia = 'None') * 100), 2)  AS perc_sm
FROM cs_students
;

-- Most used social media 
SELECT 
SocialMedia, 
COUNT(SocialMedia) AS num_sm
FROM cs_students 
GROUP BY SocialMedia
ORDER BY num_sm DESC
LIMIT 10
;

-- Which countries have the highest proportion of developers.
WITH country_total_CTE AS (
  SELECT 
    country,
    COUNT(*) AS country_total
  FROM cs_students
  GROUP BY country
)
SELECT 
  cte.country, 
  cte.country_total,
  COUNT(cs.country) AS dev_total
FROM cs_students cs
JOIN country_total_CTE cte
  ON cte.country = cs.country
WHERE cs.MainBranch = 'Developer' 
GROUP BY cte.country, cte.country_total
ORDER BY cte.country_total DESC, dev_total DESC;

SELECT *
FROM cs_students
;




