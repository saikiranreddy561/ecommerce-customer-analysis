E-commerce Customer Data Analysis with AWS Athena

This project demonstrates how to use **Amazon Athena** and **S3** to analyze real-world e-commerce customer data using SQL. It is designed to simulate business analysis tasks a data analyst might perform in a real company setting.

---

Business Objective

To extract key insights from customer purchase data that can help the business:
- Understand revenue trends
- Evaluate customer churn
- Identify key customer segments

---

Tools & Technologies

- **Amazon S3** — for data storage  
- **Amazon Athena** — for serverless SQL querying  
- **AWS Glue Catalog** — for table schema management  
- **SQL** — for data wrangling and analysis

---

Dataset Overview

The dataset contains customer transactions including:

| Column Name             | Description                         |
|-------------------------|-------------------------------------|
| Customer ID             | Unique customer identifier          |
| Purchase Date           | Date of transaction (DD-MM-YYYY)    |
| Product Category        | Category of the purchased item      |
| Product Price           | Price per item                      |
| Quantity                | Quantity purchased                  |
| Total Purchase Amount   | Total amount for the transaction    |
| Payment Method          | Credit Card, PayPal, etc.           |
| Customer Age            | Age of the customer                 |
| Returns                 | Number of items returned            |
| Customer Name           | Full name of the customer           |
| Gender                  | Male/Female                         |
| Churn                   | 1 = Churned, 0 = Active             |

---

Key Analyses

 1. Monthly Revenue Trends
 Analyzed total revenue generated each month by parsing and grouping `purchase_date`. This helps the business understand seasonal trends and peak revenue periods.

 2. Churn Rate by Age Group
 Grouped customers into age brackets and calculated the churn rate for each. This reveals which age groups are most likely to stop buying and can help with targeted retention strategies.

 3. Customer Retention
 Tracked customer IDs over time to identify repeat customers vs one-time buyers. Used this to assess customer loyalty.

 4. Product Category Performance
 Aggregated revenue and sales volume by `product_category` to identify best-selling and underperforming categories.

 5. Payment Method Preferences
 Analyzed which payment methods are most commonly used by customers. This can influence payment gateway partnerships.

 6. Return Behavior Analysis
 Explored return rates by product category and customer age to identify potential quality or satisfaction  issues.

