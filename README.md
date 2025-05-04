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

Renaming some of the columns to standard SQL format.

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
