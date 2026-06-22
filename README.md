# Retail-Sales-Analytics-Database-
# Retail Sales Analytics Database & Dashboard

## Project Overview

This project demonstrates the complete lifecycle of a retail analytics solution, from raw data preparation to business intelligence reporting.

Using a retail sales dataset from Kaggle, I designed a normalized relational database, cleaned and transformed raw transactional data, developed SQL-based business analytics, and built an interactive Tableau dashboard to visualize key performance metrics.

The goal of this project was to simulate a real-world retail analytics environment and answer business questions related to revenue generation, profitability, customer behavior, and product performance.

---

## Project Objectives

- Clean and prepare raw retail sales data for analysis
- Design and normalize a relational database to Third Normal Form (3NF)
- Establish primary and foreign key relationships
- Develop analytical SQL queries to answer business questions
- Create visualizations and dashboards for decision-making
- Identify sales trends, profitability patterns, and top-performing products

---

## Tools & Technologies

- MySQL Workbench
- SQL
- Tableau Public
- Excel
- GitHub
- dbdiagram.io

---

## Dataset Information

**Source:** Kaggle Retail Sales Dataset

The original dataset included transactional retail sales data with customer information, product information, sales metrics, shipping details, and order information.

### Original Fields

- Order ID
- Order Date
- Ship Date
- Ship Mode
- Customer Name
- Segment
- State
- Country
- Market
- Region
- Product ID
- Category
- Subcategory
- Product Name
- Sales
- Quantity
- Discount
- Profit
- Shipping Cost
- Order Priority
- Year

---

## Data Cleaning Process

The raw dataset underwent several cleaning and validation steps:

### Data Quality Checks

- Verified imported records
- Identified and reviewed duplicate records
- Checked for missing values
- Validated date fields
- Standardized text formatting
- Removed leading and trailing spaces
- Corrected inconsistent values
- Validated numerical fields

### Data Transformation

- Converted date fields into proper SQL date formats
- Created derived date attributes
- Verified sales and profit calculations
- Preserved historical sales records during transformation

---

## Database Design & Normalization

The original flat-file dataset was normalized into Third Normal Form (3NF) to reduce redundancy and improve data integrity.

### Tables Created

#### Customers

| Field | Description |
|---------|-------------|
| customer_id | Primary Key |
| customer_name | Customer Name |
| segment | Customer Segment |
| state | State |
| country | Country |
| market | Market |
| region | Region |

---

#### Products

| Field | Description |
|---------|-------------|
| product_id | Primary Key |
| category | Product Category |
| subcategory | Product Subcategory |
| product_name | Product Name |

---

#### Orders

| Field | Description |
|---------|-------------|
| order_id | Primary Key |
| customer_id | Foreign Key |
| order_date | Order Date |
| ship_date | Ship Date |
| ship_mode | Shipping Method |
| order_priority | Order Priority |

---

#### Order_Items

| Field | Description |
|---------|-------------|
| order_id | Composite Primary Key |
| product_id | Composite Primary Key |
| sales | Sales Amount |
| quantity | Quantity Ordered |
| discount | Discount Applied |
| profit | Profit Earned |
| shipping_cost | Shipping Cost |

---

## Entity Relationship Diagram (ERD)

![ERD](Asset/ERD.pdf)

### Relationships

**Customers → Orders**

- A customer can place zero or many orders.
- An order must belong to exactly one customer.

**Orders → Order_Items**

- An order can contain one or many order items.
- An order item must belong to exactly one order.

**Products → Order_Items**

- A product can appear in zero or many order items.
- An order item must reference exactly one product.

**Orders ↔ Products**

- Many-to-Many relationship
- Resolved through the Order_Items junction table

---

## SQL Analysis Performed

### Sales Analysis

- Total Revenue
- Monthly Sales Trends
- Yearly Sales Performance
- Sales by Category
- Sales by Product

### Profitability Analysis

- Total Profit
- Most Profitable Products
- Least Profitable Products
- Profit by Category

### Product Performance

- Top Selling Products
- Product Revenue Rankings
- Product Profit Rankings

### Customer Analysis

- Customer Purchase Activity
- High-Value Customers
- Order Frequency Analysis

---

## Dashboard Development

An interactive Tableau dashboard was created to visualize key business metrics and trends.

### Dashboard Components

#### KPI Cards

- Total Revenue
- Total Profit
- Total Orders
- Average Order Value

#### Visualizations

- Monthly Sales Trend
- Top 10 Products by Sales
- Profit vs Sales Scatter Plot
- Sales by Category

#### Interactive Features

- Category Filtering
- Product Performance Exploration
- Profitability Analysis

---

## Key Business Insights

### Revenue Performance

- Identified top-performing product categories
- Evaluated sales growth patterns over time
- Measured category contribution to total revenue

### Profitability

- Identified products generating the highest profits
- Highlighted products with strong sales but low profit margins
- Compared category-level profitability

### Customer Behavior

- Analyzed customer purchasing activity
- Identified repeat customers
- Evaluated order frequency patterns


---

## Project Structure

```text
Retail-Sales-Analytics-Database/
│
├── data/
│   ├── retail_sales_raw.csv
│   └── retail_dashboard_data.csv
│
├── sql/
│   ├── 01_database_setup.sql
│   ├── 02_data_cleaning.sql
│   ├── 03_customers_table.sql
│   ├── 04_products_table.sql
│   ├── 05_orders_table.sql
│   ├── 06_order_items_table.sql
│   └── 07_business_analysis_queries.sql
│
├── dashboard/
│   ├── retail_dashboard.twb
│   ├── dashboard_overview.png
│   ├── sales_trend.png
│   ├── top_products.png
│   └── profitability_analysis.png
│
├── erd/
│   └── retail_sales_erd.png
│
└── README.md
```

---

## Skills Demonstrated

### Database Skills

- Relational Database Design
- Database Normalization (3NF)
- Primary & Foreign Keys
- Data Modeling
- Entity Relationship Diagrams

### SQL Skills

- Joins
- Aggregations
- Group By
- Subqueries
- Business Analytics Queries
- Data Cleaning

### Analytics Skills

- KPI Development
- Trend Analysis
- Profitability Analysis
- Customer Analytics
- Product Performance Analysis

### Visualization Skills

- Tableau Dashboard Design
- Interactive Dashboards
- Data Storytelling
- Business Intelligence Reporting

---

## Future Enhancements

- Sales Forecasting
- Customer Segmentation Analysis
- Regional Sales Analysis
- Inventory Analytics
- Power BI Dashboard Version
- Advanced KPI Monitoring

---

## Author

**Regina Kamara**

Computer Information Technology Major  
Minors: Mathematics & Theatre  
Minnesota State University, Mankato

Interested in:
- Data Analytics
- Database Analytics
- Business Intelligence
- Data Engineering

---
