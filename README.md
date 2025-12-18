Final Project added to Midterm 1 Repo. po.1-3 json files added precautionary. additional files to be used in repo.

### Final Project Overall Process README:

# Project Overview: 
This project uses PySpark to build a data pipeline based on purchase order data
from the AdventureWorks dataset provided by Professor Tupitza. The goal is to show how data from different sources can be combined and organized for analysis using a Bronze–Silver–Gold
approach with PySpark.

# Data Sources Used and Relational Data:
The project uses data from several sources:
- JSON files that simulate streaming purchase order data
- CSV files for product and employee information
- SQL-based tables for vendor and date data
- MongoDB

# Data Pipeline (Followed Lab 6 approach):
- Bronze Layer: Raw purchase order data is ingested from JSON files in
  multiple batches to simulate real-time data arrival.
- Silver Layer: The raw data is cleaned and joined with reference data to
  add information for product, vendor, employee, and date dimensions.
- Gold Layer: The Silver data is used to create tables that make it
  easier to analyze purchasing trends. The output shows two queries that produce two different output tables.

# Tables Created
## Dimension Tables (Three dimensions products, vendors, employees plus dim_date)
- dim_date – stores calendar information such as month and year
- dim_products – contains product details and categories
- dim_vendors – contains vendor information
- dim_employees – contains employee information
### Fact Table
- fact_purchase_orders_by_product: summarizes the number of purchase orders per product by month and is used for reporting and analysis. This is the table used to produce resulting queries.

# Analysis:
The final tables are used to analyze how often products appear in purchase orders over time and to compare purchasing activity across different products and categories.
First Query: This final Gold fact table displays the number of purchase-order line items per product, by month, enabling business analysis of purchasing activity over time (by showing how many times each product appears in purchase orders for each month.) 
Unable to use product_category without error, so I kept product_key.

Second Query: # This summarizes purchase-order activity by vendor and employee,by each month, including number of orders and total spending.

## Additional tools used
- PySpark, Spark Structured Streaming, Parquet files, GitHub.





#### Midterm 1 README: 
# Project Overview
This project focuses on building a basic data mart using data from the AdventureWorks  dataset provided by Professor Tupitza. The goal of the project is to show how data from different systems can be combined, cleaned, and organized for analysis with Python.

The project uses data from multiple sources:
- Purchase order data stored in MongoDB
- Product data loaded from a CSV file
- Vendor and date data retrieved from a MySQL database

## Data Process
Purchase order data is first loaded from MongoDB into a Pandas DataFrame.
Product, vendor, and date data are then loaded from their respective sources.
These datasets are joined together using shared keys such as product ID,
vendor ID, and order date to create a complete purchase order fact table. During this process, unnecessary columns are removed and the remaining
columns are reorganized to make the data easier to analyze.

# Dimension Tables (2 plus dim_date)
- dim_products – contains product details such as product number and category
- dim_vendor – contains vendor information
- dim_date – contains calendar information used for time-based analysis

# Fact Table
- fact_purchaseorders – contains purchase order transactions and links
  to the product, vendor, and date dimensions

# Analysis
SQL queries are run on the data mart to analyze purchasing activity, such as
total amount due by vendor and product, and total purchase amounts by vendor
over different time periods. These queries demonstrate how the fact and
dimension tables can be used together to answer business questions.

# Additional Tools Used: Pandas, MongoDB, MySQL, GitHub.
