create database debt;
use debt;

create table if not exists international_debt(
`country_name` varchar(50),
`country_code` varchar(50),
`indicator_name` varchar (100),
`indicator_code` varchar(50),
`debt` int)

load data infile 
"D:\international_debt.csv"
into table international_debt
fields terminated by ','
enclosed by """"
lines terminated by '\n'
ignore 1 rows

SHOW GLOBAL VARIABLES LIKE 'local_infile';
set global local_infile = 1;

SET SESSION sql_mode = "";
SET SQL_SAFE_UPDATES = 0;







---------The WORLD BANKS INTERNATIONAL DEBT DATA---------------



---------What is the total amount of debt that is owed by the countries listed in the dataset?------------

select sum(debt) as `total amount of debt` 
from international_debt;



---------Which country owns the maximum amount of debt and what does that amount look like?----------

select country_name, sum(debt) as 
Total_debt from international_debt 
group by country_name order by 
Total_debt desc limit 3;





---------Find the number of distinct countries?-------------------------

select count(distinct (country_name))
from international_debt;




---------Finding out the distinct debt indicators------------------------

select distinct(indicator_code) 
as distinct_debt_indicators
from international_debt order by 
distinct_debt_indicators;




---------Totaling the amount of debt owed by the country---------------

SELECT country_name, SUM(debt) AS 
countries_debt FROM international_debt group by 
country_name order by countries_debt desc;



---------Country with the highest debt-----------------

select country_name, sum(debt) as 
Total_debt from international_debt 
group by country_name 
order by Total_debt desc limit 3;



---------Average amount of debt across indictor---------

select 
    indicator_code as debt_indicator,
    indicator_name,
    avg (debt) as average_debt
from international_debt
group by 1,2
order by 3 desc
limit 10;



------------------- The highest amount of principal repayments--------------------------

select 
    country_name, 
    indicator_name
from international_debt
where debt= (select 
                 max(debt)
             from international_debt
             where indicator_code ='DT.AMT.DLXF.CD');



---------------- The most common debt indicator------------

select 
    indicator_code,
    count(indicator_code) as indicator_count
from international_debt
group by indicator_code
order by indicator_count desc, indicator_code desc
limit 20;




---------------- Other viable debt issues and conclusion---------------------

select 
    country_name, 
    indicator_code, 
    MAX(debt) as maximum_debt
from international_debt
group by 1,2
order by 3 desc
limit 10;






