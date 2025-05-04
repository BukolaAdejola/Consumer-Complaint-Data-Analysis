SELECT * FROM project.consumer_complaint;
select * from consumer_complaint;
-- Data Cleaning
Alter table consumer_complaint
Rename column `Complaint ID` to Complaint_ID;
Alter table consumer_complaint
Rename column `Submitted via` to Submitted_Via;
Alter table consumer_complaint
Rename column `Date submitted` to Date_Submitted;
Alter table consumer_complaint
Rename column `Date received` to Date_Recieved ;
Alter table consumer_complaint
Rename column `Sub-product` to Sub_Product;
Alter table consumer_complaint
Rename column `Sub-issue` to Sub_Issue;
Alter table consumer_complaint
Rename column `Company public response` to Company_Public_Response;
Alter table consumer_complaint
Rename column `Company response to consumer` to Company_Respone_Consumer;
Alter table consumer_complaint
Rename column `Timely response?` to Timely_Response;

  Set SQL_Safe_Updates =0;
  Update consumer_complaint
  Set Date_submitted = str_to_date(Date_submitted,"%m/%d/%YYYY");
  
  Update consumer_complaint
  Set Date_Recieved = str_to_date(Date_Recieved,"%m/%d/%YYYY");
  select * from consumer_complaint;
  
  -- To check for duplicate
  select Complaint_ID, Submitted_Via, Date_Submitted, State, Product, Sub_product, Count(*) from consumer_complaint
  group by Complaint_ID, Submitted_Via, DAte_Submitted, State, Product, Sub_product
  having count(*) >1;
  
  select count(Complaint_ID) as Total_Complaint from consumer_complaint;
  select Submitted_Via, count(Submitted_Via) as Submitted_Method from consumer_complaint group by Submitted_Via;
  select timely_response, count(timely_response) as Types_of_Response from consumer_complaint group by Timely_Response;
  select Company_Respone_Consumer, count(Company_Respone_Consumer) as Company_Response from consumer_complaint 
  group by Company_Respone_Consumer;
  select count(distinct issue) from consumer_complaint;
  select count(distinct state) from consumer_complaint;
  select count(distinct product) from consumer_complaint;
  select count(distinct submitted_via) from consumer_complaint;
  
 -- 1. Complaint Trends & Seasonality
-- ✅ Do consumer complaints show any seasonal patterns (e.g., more complaints during certain months)?
select count(complaint_ID), date_submitted, month(date_submitted) as monthnumber from consumer_complaint
group by Date_Submitted, monthnumber
order by count(complaint_ID) desc;

with cte as (select count(Complaint_ID) as count_complaint, month(date_submitted) as complaint_month from consumer_complaint
group by complaint_month),
Seasonality as (select *, case
						when complaint_month between 1 and 3 then "QTR1"
                        when complaint_month between 4 and 6 then "QTR2"
                        when complaint_month between 7 and 9 then "QTR3"
                        when complaint_month between 10 and 12 then "QTR4" end as Seasons from  cte)
select seasons, sum(count_complaint) from seasonality group by seasons order by sum(count_complaint) desc;

-- ✅ How have complaint volumes changed over time from 2017 to 2023?
with cte as (select count(Complaint_ID) as count_complaint, year(date_submitted) as complaint_year from consumer_complaint
group by complaint_year
order by complaint_year),
cte2 as (Select *, lag(count_complaint, 1) OVER() as previous_year_count from cte),
cte3 as (select complaint_year, count_complaint, previous_year_count, (count_complaint-previous_year_count) as diff from cte2)
select complaint_year,concat(round(coalesce((diff*100/previous_year_count),0),2),"% ") as percentage_complaint from cte3
order by percentage_complaint desc;

-- ✅ Are certain states reporting more complaints than others?
select state, count(complaint_ID) as count_complaint from consumer_complaint
group by state
order by count_complaint desc
limit 10;

select * from consumer_complaint;
-- 2. Product & Issue Analysis
-- ✅ Which financial products receive the most complaints?
select product, count(complaint_Id) as count_complaint from consumer_complaint 
group by product
order by count_complaint desc
limit 3;

-- ✅ What are the most common issues reported for each product?
select *, rank() over (partition by issue) as gradeissue,
					rank() over (partition by product) as gradeproduct from consumer_complaint;
with cte as (select issue, product, count(issue) as issue_count from consumer_complaint
group by issue, product),
Ranking as(select *, rank() over (partition by product order by issue_count desc) as Ranked from cte)
select product, issue, issue_count from ranking where ranked =1; 

-- ✅ Are certain sub-products more prone to complaints?
select sub_product, count(complaint_ID) as count_complaint from consumer_complaint
group by sub_product
order by count_complaint desc
limit 5;

-- ✅ Which issues escalate frequently (i.e., result in repeated complaints)?
 select Issue, count(issue) as count_issue from consumer_complaint
 group by Issue
 order by count_issue desc
 limit 5;
 
-- 3. Company Response & Resolution Patterns
-- ✅ What percentage of complaints receive a timely response?
select Timely_response, count(complaint_ID) as count_complaint from consumer_complaint
where Timely_Response = "Yes"
group by Timely_Response;

select Timely_Response, concat(round(count(Timely_response) *100/(select count(*) from consumer_complaint),2),"% ") as Percentage_Response from consumer_complaint
group by Timely_Response;

 select case 
		when Timely_Response = "Yes" then "Very_Timely"
        when Timely_Response ="no" then "Not_Timely"
        else "No_Response"
        end as Response_Group,
round(count(Timely_response) *100/(select count(*) from consumer_complaint),2) as Percentage_Response from consumer_complaint
group by Timely_Response;
 
-- ✅ How are most complaints resolved? 
select company_respone_consumer, count(complaint_ID) as count_complaint from consumer_complaint
group by company_respone_consumer
order by count_complaint desc;

-- ✅ Is there a correlation between the type of issue and the likelihood of receiving monetary relief?
select Company_Respone_Consumer, count(Issue) as count_issue from consumer_complaint
group by Company_Respone_Consumer;

select * from consumer_complaint;
-- 4. Untimely Responses & Their Impact
-- ✅ Are there patterns in untimely responses?
select weekday(date_submitted) as Week_name, Dayname(Date_Submitted) as Day_Name, count(complaint_Id) as untimely_response from consumer_complaint
where Timely_Response = "No"
group by week_name,day_name
order by week_name;

-- ✅ Do specific complaint types or products tend to have delayed responses?
select product, count(Timely_Response) as delayed_response from consumer_complaint
where timely_response = "No"
group by Product
order by delayed_response desc;

-- ✅ Are certain states more likely to receive untimely responses
Select state, count(timely_response) as untimely_response from consumer_complaint
where Timely_Response= "No"
group by state
order by untimely_response desc
limit 3;

-- 5. Submission Channel & Processing Time
-- ✅ Which submission channels  generate the most complaints?
select submitted_via, count(complaint_ID) as count_complaint from consumer_complaint
group by Submitted_Via
order by count_complaint desc;

-- ✅ Does submission method affect response time?
select submitted_via, ceiling((avg(datediff(Date_recieved, Date_submitted)))) as responsetime from consumer_complaint
group by submitted_via
order by responsetime desc;

-- ✅ How long does it take, on average, for the company to respond to a complaint?
select ceiling(avg(datediff(Date_recieved, Date_submitted))) as respond_time from consumer_complaint;

