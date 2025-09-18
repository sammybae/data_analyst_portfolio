-- DATA CLEANING
  -- 1) REMOVING OF DUPLICATES
  -- 2) STANDARDISATION
  -- 3) REMOVING OF NULL/ BLANK VALUES
  -- 4) REMOVING OF UNNECESSARY VALUES
  
  
select * from layoffs;

CREATE TABLE layoff_staging
like layoffs;

select * 
from layoff_staging;



insert into layoff_staging
select * from layoffs;

select *, 
row_number() over(
partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as id
from layoff_staging;

with duplicate_cte as
(
select *, 
row_number() over(
partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as id
from layoff_staging)
select * 
from duplicate_cte
where id > 1;

select *
from layoff_staging 
where company = 'Casper';



CREATE TABLE `layoff_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `id` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


select * 
from layoff_staging2;

insert into layoff_staging2
select *, 
row_number() over(
partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as id
from layoff_staging;


select * from layoff_staging2
where id > 1;


delete from layoff_staging2
where id > 1;


