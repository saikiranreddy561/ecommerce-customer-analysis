-- Creating table in Athena

CREATE EXTERNAL TABLE IF NOT EXISTS ecommerce_customer_data (
  customer_id INT,
  purchase_date STRING,
  product_category STRING,
  product_price DOUBLE,
  quantity INT,
  total_purchase_amount DOUBLE,
  payment_method STRING,
  customer_age INT,
  returns INT,
  customer_name STRING,
  gender STRING,
  churn INT
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES (
  "field.delim" = ",",
  "serialization.format" = ","
)
LOCATION 's3://data-analyst-project-01/Amazon_sales_data/'
TBLPROPERTIES (
  "skip.header.line.count" = "1"
);



-- Top Product Categories by Sales

SELECT 
  product_category,
  format('%.2f',SUM(total_purchase_amount)) AS total_sales
FROM ecommerce_customer_data
GROUP BY product_category
ORDER BY total_sales DESC;


-- Top 10 highest spending customers

select customer_name, sum(total_purchase_amount) as Total_spent_money from ecommerce_customer_data
group by customer_name
order by Total_spent_money desc
limit 10;


-- Missing values check


SELECT 
  COUNT(*) AS total,
  COUNT(distinct(customer_id)) AS Unique_customers,
  COUNT(*) - COUNT(customer_id) AS missing_customers
FROM ecommerce_customer_data;



-- Payment Method Preferences

SELECT 
  payment_method,
  COUNT(*) AS usage_count
FROM ecommerce_customer_data
GROUP BY payment_method
ORDER BY usage_count DESC;



-- Churn Rate by Age Group

SELECT 
  CASE 
    WHEN customer_age < 25 THEN 'Under 25'
    WHEN customer_age BETWEEN 25 AND 34 THEN '25–34'
    WHEN customer_age BETWEEN 35 AND 44 THEN '35–44'
    WHEN customer_age BETWEEN 45 AND 54 THEN '45–54'
    ELSE '55+'
  END AS age_group,
  COUNT(*) AS total_customers,
  SUM(CAST(churn AS INT)) AS churned_customers,
  ROUND(SUM(CAST(churn AS INT)) * 100.0 / COUNT(*), 2) AS churn_rate
FROM ecommerce_customer_data
GROUP BY 
  CASE 
    WHEN customer_age < 25 THEN 'Under 25'
    WHEN customer_age BETWEEN 25 AND 34 THEN '25–34'
    WHEN customer_age BETWEEN 35 AND 44 THEN '35–44'
    WHEN customer_age BETWEEN 45 AND 54 THEN '45–54'
    ELSE '55+'
  END
ORDER BY churn_rate DESC;




-- Orders and return rate by product category

SELECT product_category, COUNT(*) AS orders,
       SUM(returns) AS returns,
       ROUND(100.0 * SUM(returns) / COUNT(*), 2) AS return_rate
FROM ecommerce_customer_data
GROUP BY product_category
ORDER BY return_rate DESC;



--  revenue per month

SELECT 
  date_format(DATE_PARSE(purchase_date, '%d-%m-%Y'), '%Y-%m') AS month,
  cast(SUM(total_purchase_amount) as decimal(18,2))AS monthly_revenue
FROM ecommerce_customer_data
GROUP BY date_format(DATE_PARSE(purchase_date, '%d-%m-%Y'), '%Y-%m')
ORDER BY date_format(DATE_PARSE(purchase_date, '%d-%m-%Y'), '%Y-%m');

