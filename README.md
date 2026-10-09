# Data warehouse and Analytics Project

Welcome to the **Data warehouse and Analytics Project** repository!

This project implements a SQL Server data warehouse that integrates CRM and ERP sales data using a Bronze, Silver, and Gold layered architecture. It focuses on data ingestion, data cleansing, transformation, and preparing business-ready data for analytical queries and reporting.
## Key Features

- Integrated CRM and ERP source data.
- Organized data processing using Bronze, Silver, and Gold layers.
- Cleaned and transformed data for analytical use.
- Designed a Gold layer star schema with fact and dimension tables.
- Created architecture and data model diagrams.
- Prepared the warehouse structure for analytical queries and reporting.

## 🚀 Project Requirements

### Building the Data Warehouse (Data Engineering)

#### Objective

Develop a modern data warehouse using SQL Server to consolidate sales data, enabling analytical reporting and informed decision-making.

#### Specifications

- **Data Sources:**  Import data from two source systems (ERP and CRM) provided as CSV files.
- **Data Quality:**  Cleanse and resolve data quality issues prior to analysis.
- **Integration:**  Combine both sources into a single, user-friendly data model designed for analytical queries.
- **Scope:**  Focus on the latest dataset only; historization of data is not required.
- **Documentation:**  Provide clear documentation of the data model to support both business stakeholders and analytics teams.

### Data Warehouse Layers

- **Bronze Layer:** Stores raw data loaded from CRM and ERP source files.
- **Silver Layer:** Cleans and transforms data to improve consistency and data quality.
- **Gold Layer:** Contains business-ready data organized into fact and dimension tables for analytics.

### BI: Analytics & Reporting (Data Analytics)

#### Objective

Develop SQL-based analytics to deliver detailed insights into:

- **Customer Behavior**
- **Product Performance**
- **Sales Trends**

These insights empower stakeholders with key business metrics, enabling strategic decision-making.
## Technologies used:
- **Database:** Microsoft SQL Server
- **Language:** T-SQL
- **Data Sources:** CRM and ERP CSV files
- **Architecture:** Bronze, Silver, and Gold layers
- **Documentation:** Draw.io
## Project Structure
```text
sql-data-warehouse-project/
├── datasets/    # Source CRM and ERP datasets
├── docs/        # Architecture and data model diagrams
├── scripts/     # SQL scripts for warehouse processing
├── tests/       # Data quality checks and validation
├── README.md    # Project documentation
└── LICENSE      # Project license
```
## How to Run the Project

1. Install or open Microsoft SQL Server and connect using SQL Server Management Studio (SSMS).
2. Download or clone this repository.
3. Review the source datasets in the `datasets/` folder.
4. Execute the SQL scripts in the `scripts/` folder in the appropriate order.
5. Validate the results using the checks available in the `tests/` folder.

## Data Warehouse Documentation:

### Data Warehouse Architecture
![Data Warehouse Architecture](docs/Data%20Warehouse%20Architecture.drawio.png)

### Data Flow Diagram
![Data Flow Diagram](docs/Data%20Flow%20Diagram.drawio.png)

### Source Data Model
![Source Data Model](docs/source%20data%20model%20.drawio.png)

### Gold Layer Star Schema
![Gold Layer Star Schema](docs/Gold%20Layer(Star%20schema).drawio.png)
---

## 📍 License

This project is licensed under the [MIT License](LICENSE). You are free to use, modify, and share this project with proper attribution.

## 🌟 About Me

Hi there! I am **Madaka Navya Latha**, a fresher and aspiring **Data Engineer/Data Analyst**. I am passionate about learning data technologies and building projects using **SQL, Python, Data Warehousing, and Data Analytics**.
