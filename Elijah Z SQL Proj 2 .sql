Use Airlines;

Select * from customer;

Select * from passengers_on_flights;

Select * from ticket_details;

Select * from routes;

-- Task 2 - Create a route details table for the airlines

Create Table route_details (
	route_id int not null,
    flight_num int not null,
    origin_airport varchar(50) not null ,
    destination_airport varchar (50) not null,
    aircraft_id varchar (50) not null,
    distance_miles int not null,
    primary key (route_id)
    );
    
-- Task 3 - Display all passengers who have travelled in routes 1 to 25

Select * from passengers_on_flights 
where route_id between 1 and 25;

-- Task 4 - Identify the number of passengers and total revenue in business class

Select 
count(customer_id),
sum(price_per_ticket)
from ticket_details
where class_id = 'Bussiness' ; -- business is spelt wrong should be 'business'

-- Task 5 - Display customer full name

Select
concat(first_name, ' ', last_name)
from customer;

-- Task 6 - Extract the customers who have registered and booked a ticket

Select * 
from 
ticket_details ; -- the solution is just the table as there isn't a column that states registration. it is assumed all have booked else their details would not be in the details

-- Task 7 - Identify the customer’s first name and last name based on their customer ID and brand (Emirates) 

Select 
customer.customer_id,
customer.first_name,
customer.last_name,
ticket_details.brand 
From customer 
left join ticket_details
on customer.customer_id = ticket_details.customer_id
Where ticket_details.brand = 'Emirates';

-- Task 8 - Identify the customers who have travelled by Economy Plus class using Group By and Having clause

Select 
customer_id,
aircraft_id,
class_id,
brand
from ticket_details
Group by 
customer_id,
aircraft_id,
class_id,
brand
having class_id = 'Economy Plus'
Order by 
aircraft_id;

-- Task 9 - Identify whether the revenue has crossed 10000 using the IF clause

Select if (
	sum(price_per_ticket)>10000 , 'Yes' , 'No' 
    ) as revenue_over_10000
From ticket_details ;

-- Task 10 - Create and grant access to a new user to perform operations on a database.
-- User 'Analyst' created using administration tab with custom role with select only priviledges

-- Task 11 

-- Task 12 - Create a view with only business class customers along with the brand of airlines. 

Create view business_class_customers As
Select 
*
from 
ticket_details 
where class_id = 'bussiness';

-- Task 13

-- Shows error message

-- Task 14 - Create a stored procedure that extracts all the details from the routes table where the travelled distance is more than 2000 miles.

-- changing delimiter to create stored procedure

Delimiter //

Create procedure sp_distance_over_2000 ()
Begin
Select *
From 
routes 
Where distance_miles > 2000;
End // 

-- changing delimiter back

Delimiter ;

Call sp_distance_over_2000;

-- Task 15 -  create a stored procedure that groups the distance travelled by each flight into three categories.

Select
*,
Case 
	When distance_miles <= 2000 then 'SDT'
    When distance_miles between 2000 and 6500 then 'IDT' 
    when distance_miles >6500 then 'LDT'
    Else 'Oops check logic'
    end as distance_category
from routes
order by distance_miles desc
;

-- Task 16 - Extract ticket purchase date, customer ID, class ID and specify if the complimentary services

-- changing delimiter to create stored procedure

Delimiter //

Create procedure sp_complimentary_services ()
Begin
Select 
p_date,
customer_id,
class_id,
	Case 
		When class_id = 'Bussiness' then 'Yes'
        When class_id = 'Economy Plus' then 'Yes'
        else 'No'
        End as complimentary_services
From 
ticket_details;
End // 

-- changing delimiter back

Delimiter ;

Call sp_complimentary_services;

-- Task 17 - extract the first record of the customer whose last name ends with Scott

Select 
*
from 
customer 
where last_name like '%Scott';



















