-- Exploratory Data Analysis

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

-- Percentage laid off = 100%
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = '1'
ORDER BY total_laid_off DESC;

-- Number of millions funds DESC
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = '1'
ORDER BY funds_raised_millions DESC;

-- Start and End Date
SELECT min(`date`), max(`date`)
FROM layoffs_staging2;

-- Total laid off by company
SELECT company, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- Total laid off by industry
SELECT industry, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

-- Total laid off by country
SELECT country, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

-- Total laid off by Year
SELECT YEAR(`date`), sum(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

-- Total laid off by Stage
SELECT stage, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

-- Rolling sum of Layoffs

SELECT SUBSTRING(`date`,1,7) AS `Month`, SUM(total_laid_off), country
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `Month`, country
ORDER BY 1 DESC;

WITH Rolling_total AS 
(
SELECT SUBSTRING(`date`,1,7) AS `Month`, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `Month`
ORDER BY 1 DESC
)

-- Month by Month Progression
SELECT `Month`, total_off, SUM(total_off) OVER ( order by  `Month`) AS rolling_total
FROM Rolling_total;

-- How many laid off by Company by Year
SELECT company, year(`date`), sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company, year(`date`)
ORDER BY company ASC
;

-- CTE 
WITH Company_year (company, years, total_laid_off) AS
(
SELECT company, year(`date`), sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company, year(`date`)
 ),
 Company_Year_Rank AS -- Giving a Rank
 (
SELECT *, DENSE_RANK()OVER (PARTITION BY Years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_year
WHERE Years IS NOT NULL
)

-- TOP 5 companies with total laid off
SELECT *
FROM Company_Year_Rank
WHERE Ranking <=5;







