--- Exploratory data analysis (EDA)


SELECT * 
FROM layoff_new

--- to see maximum laid_off and percentage_laid_off
	
SELECT max(total_laid_off) as total,
	max(percentage_laid_off) as percentage
FROM layoff_new

--- to see the 100% laid_off (here 1 means 100%)

SELECT * 
FROM layoff_new
where percentage_laid_off = 1 and funds_raised_millions is not null
order by funds_raised_millions desc

--- Companies with the biggest single Layoff (Top 10)	

select company ,sum(total_laid_off)
FROM layoff_new
where total_laid_off is not null
group by company
order by 2 desc
limit 10

--- start date and end date of Layoff 	
	
select min(date),max(date)
FROM layoff_new

--- industry wise Layoff 

select industry,sum(total_laid_off)
FROM layoff_new
where total_laid_off is not null
group by industry
order by 2 desc

--- country wise Layoff 

select country,sum(total_laid_off)
FROM layoff_new
where total_laid_off is not null
group by country
order by 2 desc

--- date wise Layoff 

select date,sum(total_laid_off)
FROM layoff_new
where total_laid_off is not null
group by date
order by 1 desc

--- year wise Layoff 
	
select to_char(date,'YYYY') as year,sum(total_laid_off)
FROM layoff_new
where total_laid_off is not null
group by year
order by 1 

--- stage wise Layoff 
	
select stage,sum(total_laid_off)
FROM layoff_new
where total_laid_off is not null
group by stage
order by 2 desc

--- year wise month wise Layoff 

select to_char(date,'YYYY-MM') as month,sum(total_laid_off)
FROM layoff_new
where to_char(date,'YYYY-MM')is not null
group by month
order by 1

--- to view month wise laioff and its rolling total

with Rolling_Total as
(
select to_char(date,'YYYY-MM') as month,sum(total_laid_off) as laid_off
FROM layoff_new
where to_char(date,'YYYY-MM')is not null
group by month
order by 1	
)
select month,laid_off,
	sum(laid_off) over(order by month) as rolling_total
from Rolling_Total

--- company wise year wise Layoff 

select company,to_char(date,'YYYY') as year ,sum(total_laid_off)
FROM layoff_new
group by company,year
order by Company

select company,to_char(date,'YYYY') as year ,sum(total_laid_off)
FROM layoff_new
	where total_laid_off is not null
group by company,year
order by 3 desc

--- company wise year wise Layoff view in CTE
	
with Company_year(Company,Years,Total_laid_off) as
(select company,to_char(date,'YYYY') as year ,sum(total_laid_off)
FROM layoff_new
	where total_laid_off is not null
group by company,year	
)
select *
from Company_year
