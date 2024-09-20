--- SQL Project - Data Cleaning in PostgreSQL



SELECT * 
FROM layoff_new

--- Mark each row as unique row

SELECT *, ctid
FROM layoffs

--- Find duplicate 

select *
	from layoff_new
	GROUP BY company,location,industry,date,stage,country,total_laid_off,percentage_laid_off,funds_raised_millions
	HAVING COUNT(*)>1

---  Remove the duplicate 

delete from layoff_new
where ctid in (
	select max(ctid)
	from layoff_new
	GROUP BY company,location,industry,date,stage,country,total_laid_off,percentage_laid_off,funds_raised_millions
	HAVING COUNT(*)>1)

--- Remove white space from a particular column

update layoff_new
set company = trim(company)

--- Sort unique industry
	
SELECT distinct industry
FROM layoff_new
order by 1

--- To see the details of particular industry

SELECT *
FROM layoff_new
where industry like 'Crypto%'

--- To update particular industry name as a same name

update layoff_new
set industry = 'Crypto'
where industry like 'Crypto%'

--- Sort unique country

SELECT distinct country
FROM layoff_new
order by 1

--- To update particular industry name as a same name

update layoff_new
set country = 'United States'
where country like 'United States.'

--- date conversion view

select date,
to_date(date,'MM-DD-YYYY') 
from layoff_new

--- date conversion update

update layoff_new
set date = to_date(date,'MM-DD-YYYY')

--- data type change in date column( from text to date)

ALTER TABLE layoff_new
alter column date type date
using(date::date)

--- to see the null value


select *
from layoff_new t1
join layoff_new t2
	on t1.company = t2.company
where t1.industry is null 
and t2.industry is not null

--- to see the null value company wise
	
SELECT *
FROM layoff_new
where company ='Airbnb'

--- Update the null value

update layoff_new
set industry = 'Travel'
where company like 'Airbnb'

SELECT *
FROM layoff_new
where company ='Juul'

update layoff_new
set industry = 'Consumer'
where company like 'Juul'

SELECT *
FROM layoff_new
where company ='Carvana'

update layoff_new
set industry = 'Transportation'
where company like 'Carvana'

--- to see the null value industry wise

select *
from layoff_new
where industry is null


--- to see the null value total_laid_off wise

SELECT *
FROM layoff_new
WHERE total_laid_off IS NULL

--- to see the null value total_laid_off and percentage_laid_off

SELECT *
FROM layoff_new
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULl

--- to delete the null value total_laid_off and percentage_laid_off

DELETE FROM layoff_new
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL	