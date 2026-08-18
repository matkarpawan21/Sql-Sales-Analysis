# SQL Sales Analysis

## Project Overview

SQL Sales Analysis is a SQL Server project created to analyze sales, customers, products, and orders using SQL queries.

The project uses a relational database containing customer, product, order, and order-detail information.

## Database Tables

The project contains four main tables:

- Customers
- Products
- Orders
- OrderDetails

## Database Structure

### Customers
Contains customer information such as:
- CustomerID
- CustomerName
- City
- State

### Products
Contains product information such as:
- ProductID
- ProductName
- Category
- Price

### Orders
Contains order information such as:
- OrderID
- CustomerID
- OrderDate

### OrderDetails
Contains order-level product details such as:
- OrderDetailID
- OrderID
- ProductID
- Quantity

## SQL Analysis Performed

The project includes analysis for:

- Total number of customers
- Total number of products
- Total number of orders
- Total quantity sold
- Total sales
- Customer-wise sales
- Customer-wise order analysis
- Product-wise sales
- Product-wise quantity sold
- Category-wise sales
- City-wise and state-wise customer analysis
- Daily sales analysis
- Top 5 products by sales

## Advanced SQL Concepts

The project also demonstrates:

- JOINs
- GROUP BY
- HAVING
- Aggregate Functions
- CASE
- COALESCE
- Subqueries
- CTEs
- ROW_NUMBER()
- RANK()
- DENSE_RANK()
- Date-based analysis

## Tools & Technologies

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- SQL

## Project Files

- `SQL-Sales-Analysis.sql` – SQL queries used for sales analysis
- `database setup` – Database setup scripts
- `sales analysis` – Sales analysis queries and project work

## Objective

The main objective of this project is to develop practical SQL and data analysis skills by working with a relational sales database and extracting meaningful business insights from transactional data.

## Conclusion

This project demonstrates practical knowledge of SQL Server, relational databases, data analysis, joins, aggregations, and advanced SQL techniques.

It is designed as a portfolio project for demonstrating SQL and Data Analyst skills.
