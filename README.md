# marketing-and-customer-insights-analytics

## Shopverge Marketing & Sales Analysis 📈

## Overview

Shopverge, a fictional online retail company, is facing declining customer engagement and conversion rates despite increased investment in online marketing. To combat this failing ROI, this project thoroughly analyzes customer behavior, campaign performance, and customer feedback using SQL, Power BI, and Python to identify the drivers of this decline and recommend actionable improvements for the firm to leverage.

Due to the comprehensive scope of this project and the structure of the source data, which is maintained in a SQL Server .bak backup containing multiple relational tables, I am unable to provide the dataset in a consolidated CSV format. Instead, I've included relevant SQL queries and the Power BI data model in addition to the .bak file to give a better understanding of the source data. The Power BI data model and schema can be found in /marketing-data-analysis/docs/marketing_analysis_powerbi_schema.PNG.

## Objectives

- **Increase Conversion Rates**: Identify factors impacting the conversion rate and provide relevant recommendations to improve it. For example, highlighting key stages where visitors drop off and thereby finding ways to optimize the conversion funnel.
- **Enhance Customer Engagement**: Determine which types of content drive the most engagement. This means analyzing interaction levels with different types and styles of marketing content to inform better marketing strategies. 
- **Improve Customer Feedback Scores**: Understand common themes in customers reviews and provide actionable insights. Things like recurring positive and negative feedback should be used to foster product and service improvements.

## Key Metrics

- **Conversion Rate**: Percentage of website visitors who make a purchase
- **Customer Engagement**: Level of interaction with marketing content (clicks, likes, comments)
- **Customer Feedback Score**: Average rating from customer reviews

## Data Sources

- **Customer Journey Table**: Tracks customer movements through the website to analyze the conversion funnel
- **Engagement Data Table**: Measures engagement with different types of content
- **Customer Reviews Table**: Analyzes customer feedback to identify common themes and sentiment
- **Customers Table**: Provides additional information about customers
- **Geography Table**: Provides additional geographic information about customers
- **Products Table**: Provides additional information about products

## Techincal Tools Used
- **Microsoft SQL Server/SQL Server Management Studio** – Data extraction, cleaning, standardization, and transformation
- **Power BI** – Interactive dashboards and KPI visualization
- **Python** – Sentiment analysis and other applicable statistical analyses

## Project Structure

```
/marketing-data-analysis
│
├── /docs # Project documentation (Excel, PDFs, etc.)
├── /sql # SQL queries
├── /python # Python scripts and notebooks
├── /powerbi # Power BI report files (.pbix)
├── /data # SQL Server .bak backup file
│
└── README.md # Project overview and structure
```
