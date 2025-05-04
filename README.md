# Consumer Complaint Data Analysis


![complaint](https://github.com/user-attachments/assets/a6c8aaf1-58ef-4c66-88f0-863503b957cd)

## Table of Contents
- [Introduction](#Introduction)
- [Dataset Overview](#DatasetOverview)
- [Project Objective](#ProjectObjective)
- [Data Cleaning](#DataCleaning)
- [Data Insights](#DataInsights)
- [Conclusion](Conclusion)
- [Recommendation](Recommendation)

  ## Introduction
  Consumer complaints provide valuable insights into customer dissatisfaction and potential areas for service improvement.
  Analyzing these complaints can help **Bank of America** identify trends, address recurring issues, and improve customer service efficiency.

  ## Dataset Overview
- This project is made up of 12 columns and 62516 rows
- Field	Description																									
- Complaint ID	                The unique identification number for a complaint																						
- Submitted via	                How the complaint was submitted to the CFPB																						
- Date submitted	              The date the CFPB received the complaint																						
- Date received	                The date the CFPB sent the complaint to the company																					
- State	                        The state of the mailing address provided by the consumer																					
- Product	                      The type of product the consumer identified in the complaint																					
- Sub-product      	            The type of sub-product the consumer identified in the complaint (not all Products have Sub-products)																	
- Issue	                        The issue the consumer identified in the complaint (possible values are dependent on Product)																	
- Sub-issue	                    The sub-issue the consumer identified in the complaint (possible values are dependent on Product and Issue, and not all Issues have corresponding Sub-issues)											
- Company public response	      The company's optional, public-facing response to a consumer's complaint. Companies can choose to select a response from a pre-set list of options that will be posted on the public database. For example, "Company believes complaint is the result of an isolated error."	
- Company response to consumer	This is how the company responded. For example, "Closed with explanation."																			
- Timely response?	            Whether the company gave a timely response (Yes/No)

  ## Project Objective
  Key Business Questions to Solve:
1. Complaint Trends & Seasonality
   
✅ Do consumer complaints show any seasonal patterns (e.g., more complaints during certain months)?

✅ How have complaint volumes changed over time from 2017 to 2023?

✅ Are certain states reporting more complaints than others?

2. Product & Issue Analysis
   
✅ Which financial products receive the most complaints?

✅ What are the most common issues reported for each product?

✅ Are certain sub-products more prone to complaints?

✅ Which issues escalate frequently (i.e., result in repeated complaints)?

3. Company Response & Resolution Patterns
   
✅ What percentage of complaints receive a timely response?

✅ How are most complaints resolved? (e.g., Closed with explanation, closed with monetary relief?)

✅ Is there a correlation between the type of issue and the likelihood of receiving monetary relief?

4. Untimely Responses & Their Impact
   
✅ Are there patterns in untimely responses?

✅ Do specific complaint types or products tend to have delayed responses?

✅ Are certain states more likely to receive untimely responses?

5. Submission Channel & Processing Time
   
✅ Which submission channels (e.g., Phone, Email, Online) generate the most complaints?

✅ Does submission method affect response time?

✅ How long does it take, on average, for the company to respond to a complaint?
               				

## Data Cleaning

- Renaming some of the columns to standard SQL format.

'''sql 
Alter table consumer_complaint
Rename column `Complaint ID` to Complaint_ID;
'''

'''sql 
Alter table consumer_complaint
Rename column `Submitted via` to Submitted_Via;
'''

'''sql 
Alter table consumer_complaint
Rename column `Date submitted` to Date_Submitted;
'''
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
Rename column `Timely response? ` to Timely_Response;
'''
Rename column `Sub-issue` to Sub_Issue;
Alter table consumer_complaint
Rename column `Company public response` to Company_Public_Response;
Alter table consumer_complaint
Rename column `Company response to consumer` to Company_Respone_Consumer;
Alter table consumer_complaint
Rename column `Timely response? ` to Timely_Response;

- I also updated the Date_submitted to the standard SQL format.u

'''sql
Set SQL_Safe_Updates =0;
'''
'''sql
Update consumer_complaint
Set Date_submitted = str_to_date(Date_submitted,"%m/%d/%YYYY");
'''
'''sql
Update consumer_complaint
 Set Date_Recieved = str_to_date(Date_Recieved,"%m/%d/%YYYY");
'''
 - To check for duplicate
 - '''sql
 select Complaint_ID, Submitted_Via, Date_Submitted, State, Product, Sub_product, Count(*) from consumer_complaint
 group by Complaint_ID, Submitted_Via, DAte_Submitted, State, Product, Sub_product
  having count (*) >1;
'''

## Data Insights

Total number of customers
Insights: There are 62516 customers in this dataset

Total number of Issues
Insights: There are 76 Issues

Total number of states
Insights: 51 states are in this dataset

Total number of products 
Insights: 9

1. Complaint Trends & Seasonality
   
✅ Do consumer complaints show any seasonal patterns (e.g., more complaints during certain months)?

Insights: Yes! There are more complaints during the second and third quarter of the year.
Quarter3 has the highest number of complain of 16923, then Quarter2 has 16569, followed by
Quarter1 having 14820 and lastly Quarter4 with the least complain of 14204.

✅ How have complaint volumes changed over time from 2017 to 2023?

In the year 2017 there was 0.00% complain because there was no year 2016 to use as previous year
difference in the dataset and it skyrocketed to 45.94% in 2018 a then dropped by -10.12% in 2019. 
In the year 2020, complaints rise by 26.39% and then dropped by 24.68% in 2021 and dropped to 16.18% 
in 2022 and lastly a further decrease by -29.51% in the year 2023.

✅ Are certain states reporting more complaints than others?

After limiting to 10 and ordered the count of complaint in descending order,
CA have the highest count of complaint of 13709, followed by FL having 6488 complaints count and then TX having 4686, NY have 4442, GA have 2921, NJ have 2661, IL have 2270, MA 2141, MD 1959 and lastly VA having 1731 count of complaint.

2. Product & Issue Analysis
   
✅ Which financial products receive the most complaints?

There were 9 complaints in total but I limited to 3.
Checking or savings account received the most complaint with a count of 24814

✅ What are the most common issues reported for each product?

Insights:

Products						Issues					Count
1.	Checking or savings account	Managing an account	15109
2.	Credit card or prepaid card	Problem with a purchase shown on your statement	4415
3.	Credit reporting, credit repair services, or other personal consumer reports	Incorrect information on your report	4145
4.	Debt collection	Attempts to collect debt not owed	1351
5.	Money transfer, virtual currency, or money service	Fraud or scam	1951
6.	Mortgage	Trouble during payment process	2827
7.	Payday loan, title loan, or personal loan	Getting a line of credit	71
8.	Student loan	Dealing with your lender or servicer	20
9.	Vehicle loan or lease	Managing the loan or lease	222

✅ Are certain sub-products more prone to complaints?

Insights: After limiting to 5, I observed that the Checking account has the highest count of complaints of 20768, 
followed by General-purpose credit card or charge card having 13404 counts of complaints, then Credit reporting have 7340,
next is Conventional home mortgage with a complaint count of 3767 and lastly is other banking product or service with 2568 count of complaints.

✅ Which issues escalate frequently?

Insights: After limiting to 5, the issue that escalate most frequently is that of managing an account occurring 15109 times,
after this is Incorrect information on your report with a count of 4931. Problem with a purchase shown on your statement 
is next having 4415 counts and then closing an account with a count of 2953 and lastly, trouble during payment process having a count of 2827.


3. Company Response & Resolution Patterns
   
✅ What percentage of complaints receive a timely response?

Insights: I used the Case function to group the timely response column to:
1.	Very Timely having the highest of 93.77%. Not timely has 3.84% and lastly 2.39% for No Response.
	
	
✅ How are most complaints resolved? 

Insights: Most complaints are resolved “Closed with explanation”, it has the highest count of 41044,

“Closed with monetary relief is next”, with a count of 14697, then ‘Closed with nonmonetary relief has 5273 counts, 
“In progress” has a count of 1494 and lastly “Closed” count is 8.

4. Untimely Responses & Their Impact
   
✅ Are there patterns in untimely responses?

Insights: Weekdays have high complaint count as compared to weekend. Weekends have the lowest
complaint count of 195 for Saturday and 143 for Sunday. 
For weekdays, Thursday has the highest count of 468, followed by Tuesday having 426 counts
and then Wednesday having 420. Friday has a count of 386 and Monday has 365.

✅ Do specific complaint types or products tend to have delayed responses?

✅ Are certain states more likely to receive untimely responses?

5. Submission Channel & Processing Time
   
✅ Which submission channels generate the most complaints?

Submission via web generates the most complaints with a count of 45423, next is submission via referral having a count of 10766,
followed by submission via phone with a count of 4684 complaints. Submission via post mail have count of 1318, submission via fax 
have 233 counts of complaint, web referral has a count of 90 and lastly submission via email has the lowest with a complaint count of 2.

✅ Does submission method affect response time?

Yes, submission method affects response time.
Submission via Web, Web referral, Fax, Email has the shortest response time of 1 day, 
submission via Phone and Postal mail has a response time of 2days while submission via referral has a response time of 4 days.

✅ How long does it take, on average, for the company to respond to a complaint?

On average, it takes the company 2days to respond to a complaint.

## Conclusion

The consumer complaint analysis across 62,516 customers and 76 issue categories reveals clear patterns in complaint behavior, product performance, and company responsiveness. Complaints show strong seasonality, with peaks in Q2 and Q3, and a volatile trend in volume over the years 2017–2023. California, Florida, and Texas are the top states with the highest complaint counts, indicating possible regional service or communication challenges.

Checking or savings accounts generate the most dissatisfaction, particularly around "managing an account". Similarly, issues like incorrect credit report information and purchase discrepancies on statements are recurring and heavily escalated.

The company demonstrates commendable responsiveness, with 93.77% of cases handled in a timely manner, and most complaints being "closed with explanation". However, untimely responses are still present and seem more common on weekends, and potentially vary by state, issue, or product—requiring further investigation.
Submission method plays a significant role in processing time, with web submissions being the fastest and referrals taking the longest to resolve.

## Recommendation

1.	Target High-Risk Products for Improvement:

	Prioritize service quality enhancements for checking or savings accounts, especially in account management processes.
	Address systemic issues in credit reporting and credit card transactions through better customer education and error resolution procedures.

2.	Strengthen Support in High-Complaint Regions:

	Focus customer support efforts and oversight in California, Florida, and Texas, where complaints are disproportionately high.

3.	Improve Handling of Escalated Issues:
   
	Identify root causes of top escalated issues like "managing an account" and "incorrect report information", and develop targeted resolutions or system fixes.

4.	Optimize Weekend Support:
	Increase staffing or implement automation to reduce response delays on Saturdays and Sundays, where untimely replies are more likely.

5.	Streamline Referral-Based Processing:
   
	Investigate delays in referral submissions and implement workflow improvements to reduce the average 4-day response time.
6.	Monitor and Report Untimely Patterns by Segment:
    
	Drill deeper into which states, products, or issues are more prone to delayed responses to proactively mitigate them.
7.	Enhance Transparency Through Reporting Dashboards:
   
	Create internal dashboards to continuously monitor complaint volumes, types, and response times across channels, helping teams act on emerging trends swiftly.

