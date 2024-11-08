-- Data Cleaning

SELECT * 
FROM layoffs;

-- Remove Duplicates
-- Standarize the data
-- Null values or blank values
-- Remove any columns

CREATE TABLE layoffs_staging
lIKE layoffs;

SELECT *
FROM layoffs_staging;

INSERT INTO layoffs_staging
select * 
from layoffs;

SELECT *,
ROW_NUMBER() 
OVER(partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
FROM layoffs_staging;

with duplicate_cte as 
(
SELECT *,
ROW_NUMBER() 
OVER(partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
FROM layoffs_staging
)

SELECT *
from duplicate_cte
where row_num > 1;

select *
from layoffs_staging
where company = 'oda'

CREATE TABLE `Layoffs_staging2` (
`company` text,
`location` text,
`industry` text,
`total_laid_off` int DEFAULT NULL,
`percentage_laid_off` text,
`date` text,
`stage` text,
`country` text,
`funds_raised_million` int DEFAULT NULL,
`row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() 
OVER(partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
FROM layoffs_staging;

DELETE 
FROM layoffs_staging2
where row_num >1;

SELECT *
FROM layoffs_staging2
where row_num >1;

SELECT *
FROM Layoffs_staging2;

-- Standarizing Data

select company, trim(company)
from layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT DISTINCT(industry)
from layoffs_staging2
ORDER BY 1;

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'crypto%';

SELECT DISTINCT industry
FROM layoffs_staging2;


SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country = trim(TRAILING '.' FROM country)
where  country like 'United States%';

SELECT `date`, str_to_date(`date`,'%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date`= str_to_date(`date`,'%m/%d/%Y');

select `date`
from layoffs_staging2;

ALTER TABLE layoffs_staging2
MODIFY column `date` DATE;

-- NULL or Blank Values

SELECT *
from layoffs_staging2
where industry IS NULL or industry = '';

select *
from layoffs_staging2
where company = 'Airbnb';

UPDATE layoffs_staging2
SET industry = NULL 
WHERE industry = '';

SELECT *
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry= '')
AND t2.industry IS NOT NULL;    

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL 
AND t2.industry IS NOT NULL;  


-- Remove Columns & Rows

SELECT * 
from layoffs_staging2
where total_laid_off IS NULL 
AND percentage_laid_off IS NULL;


DELETE 
from layoffs_staging2
where total_laid_off IS NULL 
AND percentage_laid_off IS NULL;


SELECT *
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;
