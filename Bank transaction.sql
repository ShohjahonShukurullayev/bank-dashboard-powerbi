
--================================== 1. Bank Transactions | Summary ==========================

--Total_Amount
select SUM(Amount) as Total_Amount
from Bank_Transactions
where YEAR(TransactionDate) = 2025 and Currency = 'EUR';

--Average_Amount
select AVG(Amount) as Average_Amount
from Bank_Transactions
where YEAR(TransactionDate) = 2025 and Currency = 'EUR';

Alter table Bank_Transactions
Add Years date;

alter table Bank_Transactions
drop column Years;

--Add column years
Alter table Bank_Transactions
Add Years int;

--Filled column
update Bank_Transactions
set Years = YEAR(TransactionDate);


select * from Bank_Transactions;

--Total_income
select sum(Amount) as Total_income
from Bank_Transactions
where Years = 2025 and Currency = 'EUR' and TransactionType = 'Kirim';

--Total_Output
select sum(Amount) as Total_Output
from Bank_Transactions
where Years = 2025 and Currency = 'EUR' and TransactionType = 'Chiqim';

--====================================== INCOME ==============================
--Income %
Select sum(case 
            when TransactionType = 'Kirim' then Amount else 0 end)*100/SUM(Amount) as 'Income %'
from Bank_Transactions
where Years = 2025 and Currency = 'EUR';

--Active_Amount
select sum(Amount) as Active_Amount
from Bank_Transactions
where Years = 2025 and Currency = 'EUR' and AccountStatus = 'Active' and TransactionType = 'Kirim';

--Frozen_Amount
select sum(Amount) as Frozen_Amount
from Bank_Transactions
where Years = 2025 and Currency = 'EUR' and AccountStatus = 'Frozen' and TransactionType = 'Kirim';

--Inactive_Amount
select sum(Amount) as Inactive_Amount
from Bank_Transactions
where Years = 2025 and Currency = 'EUR' and AccountStatus = 'Inactive' and TransactionType = 'Kirim';

--=============================================== Output =================================
--Output %
select sum(case 
               when transactionType = 'Chiqim' then Amount else 0 end)*100/sum(Amount) as 'Output %'
from Bank_Transactions
Where Years = 2025 and Currency = 'EUR';

--Active_Amount
select sum(Amount) as Active_Amount
from Bank_Transactions
where Years = 2025 and Currency = 'EUR' and AccountStatus = 'Active' and TransactionType = 'Chiqim';

--Frozen_Amount
select sum(Amount) as Frozen_Amount
from Bank_Transactions
where Years = 2025 and Currency = 'EUR' and AccountStatus = 'Frozen' and TransactionType = 'Chiqim';

--Inactive_Amount
select sum(Amount) as Inactive_Amount
from Bank_Transactions
where Years = 2025 and Currency = 'EUR' and AccountStatus = 'Inactive' and TransactionType = 'Chiqim';


SELECT 
    AccountStatus, 
    Currency, 
    ROUND(SUM(Amount), 2) AS Total_Amount, 
    ROUND(AVG(Amount), 2) AS Average_amount,
    ROUND(SUM(CASE WHEN TransactionType = 'Kirim' THEN Amount ELSE 0 END), 2) AS Income,
    ROUND(SUM(CASE WHEN TransactionType = 'Chiqim' THEN Amount ELSE 0 END), 2) AS Output,
    ROUND(
        CAST(SUM(CASE WHEN TransactionType = 'Kirim' THEN Amount ELSE 0 END) AS FLOAT) * 100 / 
        NULLIF(SUM(Amount), 0), 2) AS [Income %],
    ROUND(
        CAST(SUM(CASE WHEN TransactionType = 'Chiqim' THEN Amount ELSE 0 END) AS FLOAT) * 100 / 
        NULLIF(SUM(Amount), 0), 2) AS [Output %]
FROM Bank_Transactions
WHERE Years = 2025 AND Currency = 'EUR'
GROUP BY AccountStatus, Currency;

select * from Bank_Transactions;

--End Summary


--================================================== 2. Overview ==================================================


--Add column Month_num
Alter table Bank_Transactions
Add Month_num int;

--Filled column
update Bank_Transactions
set Month_num = MONTH(Transactiondate);

--Add column Month_Name
Alter table Bank_Transactions
Add Month_Name Varchar (20);

--Filled column
update Bank_Transactions
set Month_Name = FORMAT(TransactionDate, 'MMM')

--Total income by month
select Month_num, Month_Name, Sum(case when TransactionType = 'Kirim' then Amount else 0 end) as Total_income
from Bank_Transactions
where Years = 2025 and Currency = 'EUR'
Group by Month_num, Month_Name
order by 1;

--Total output by nonth
select Month_num, Month_Name, Sum(case when TransactionType = 'Chiqim' then Amount else 0 end) as Total_output
from Bank_Transactions
where Years = 2025 and Currency = 'EUR'
Group by Month_num, Month_Name
order by 1;

--Total income by Region and TransactionType
select Branch, TransactionType, SUM(Amount) as Total_Amount
from Bank_Transactions
Group by Branch, TransactionType
order by 1;

select Currency, COUNT(case when Currency =  then 1  end)*100/COUNT(Amount)
from Bank_Transactions
where TransactionType = 'Kirim' 
group by Currency
order by 1

select * from Bank_Transactions;






