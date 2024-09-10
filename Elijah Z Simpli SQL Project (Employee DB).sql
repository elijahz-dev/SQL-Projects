-- Task 1 - completed using the User Interface tool, could have been done with the code

Use employee;

-- Task 3 - fetching data employee data

Select
emp_id,
first_name,
last_name,
gender,
dept
from
emp_record_table;

-- Task 4 - fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is <2,>4, between 2 & 4

Select
emp_id,
first_name,
last_name,
gender,
dept,
case 
when emp_rating < 2 then 'less than 2' 
when emp_rating > 4 then 'greater than 4' 
when emp_rating between 2 and 4 then 'between 2 and 4' else null
end as emp_rating_range
from
emp_record_table
group by 
emp_id,
first_name,
last_name,
gender,
dept,
case 
when emp_rating < 2 then 'less than 2' 
when emp_rating > 4 then 'greater than 4' 
when emp_rating between 2 and 4 then 'between 2 and 4' else null
end ;

-- Task 5 - concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance department

Select
concat(first_name,' ', last_name) as Name

from
emp_record_table
where dept = 'finance';

-- Task 6 - list only those employees who have someone reporting to them

Select
emp_id,
first_name as name,
last_name as surname,
role,
dept
from 
emp_record_table
where
role = 'president' 
or
role = 'manager';

-- Task 7 - to list down all the employees from the healthcare and finance departments using union

Select
emp_id,
first_name as name,
last_name as surname, 
role,
dept
from emp_record_table
where dept = 'healthcare'

Union

Select
emp_id,
first_name as name,
last_name as surname, 
role,
dept
from emp_record_table
where dept = 'finance';

-- Task 8 - to list down employee details

Select
emp_id,
first_name as name,
last_name as surname, 
role,
dept,
emp_rating,
max(emp_rating)

From
emp_record_table

Group by
emp_id,
first_name,
last_name, 
role,
dept,
emp_rating

Order by 
dept;


-- Task 9 - 

Select
emp_id,
first_name as name,
last_name as surname, 
role,
dept,
emp_rating,
case 
when dept= 'all' then max(emp_rating)
when dept= 'automotive' then max(emp_rating)
when dept= 'retail' then max(emp_rating)
when dept= 'healthcare' then max(emp_rating)
when dept= 'finance' then max(emp_rating)
else null
end as max_emp_rating_per_dept

From
emp_record_table

Group by
emp_id,
first_name,
last_name, 
role,
dept,
emp_rating

Order by 
dept;


-- Task 10 - assign ranks to each employee based on their experience

Select
emp_id,
first_name as name,
last_name as surname,
role,
dept,
exp,
rank () Over (order by exp desc) as exp_ranking
from 
emp_record_table

order by 
exp desc;

-- Task 11 - create a view that displays employees in various countries whose salary is more than six thousand

Create View Salaries_geographic AS
Select *
from 
emp_record_table
where SALARY > 6000
Order by 
salary desc;

Select * from salaries_geographic;


-- Task 12 - nested query to find employees with experience of more than ten years

Select * 
from emp_record_table 
Where exp > 10

Order by exp desc;

-- Task 13 - create a stored procedure to retrieve the details of the employees whose experience is more than three years

-- change delimiter to // so that stored procedure can be created with ';' sign in it

Delimiter //

Create procedure sp_employeeexp ()
Begin
	Select * 
    from 
    emp_record_table
    where exp > 3
    order by exp;
End //

-- changing delimiter back 

Delimiter ;

Call sp_employeeexp ();

-- Task 14 - stored procedure 

-- change delimiter so that stored procedure can be created
Delimiter // 

Create procedure sp_position ()
Begin
Select 
	emp_id,
    FIRST_NAME,
    LAST_NAME,
    DEPT,
    Exp,
	case
		When exp <= 2 then 'JUNIOR DATA SCIENTIST'
        When exp between 2 and 5 then 'ASSOCIATE DATA SCIENTIST'
		When exp between 5 and 10 then 'SENIOR DATA SCIENTIST'
        When exp between 10 and 12 then 'LEAD DATA SCIENTIST'
        WHEN exp between 12 and 16 then 'MANAGER'
        When exp >= 20 then 'PRESIDENT'
        else 'oops check logic'
        end as 'postion_sp'
    
from employee.emp_record_table;
End //

Delimiter ;
-- changed delimiter back

Call sp_position ();

-- Task 15


-- Task 16 - calculate the bonus for all the employees, based on their ratings and salaries 

Select * ,
'0.05%'*SALARY*EMP_RATING as Bonus
from 
emp_record_table;


-- Task 17 - calculate the average salary distribution based on the continent and country

Select
continent,
country,
	avg(salary) as avg_salary
from emp_record_table
Group by 
continent,
country 
Order by avg(salary) desc;
