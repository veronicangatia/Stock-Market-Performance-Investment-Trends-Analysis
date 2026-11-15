# Stock Market Performance & Investment Trends Analysis

An end-to-end financial data analytics project exploring stock market performance, investment risk and trading activity across five major US-listed technology companies using Python, SQL Server and Power BI.

## Project Overview

This project analyses historical stock market data for five publicly traded technology companies over an approximately one-year period.

The project follows an end-to-end data analytics workflow, beginning with data extraction from the EOD Historical Data (EODHD) API using Python, followed by data cleaning and transformation, financial analysis, database development using Microsoft SQL Server, and interactive dashboard development using Power BI.

The objective is to transform raw financial market data into meaningful insights that help evaluate stock performance, investment risk and trading behaviour.

**Companies Analysed**

| Company | Ticker | Exchange |
|---|---|---|
| Apple | AAPL.US | NASDAQ |
| Microsoft | MSFT.US | NASDAQ |
| Amazon | AMZN.US | NASDAQ |
| NVIDIA | NVDA.US | NASDAQ |
| Alphabet | GOOGL.US | NASDAQ |

**Dataset Overview**

- Data source: EOD Historical Data (EODHD)
- Period analysed: 7 November 2025 – 6 November 2026
- Companies analysed: 5
- Total observations: 1,255
- Trading observations per company: 251

## Business Problem

Investors and financial analysts need more than stock prices to evaluate investment opportunities.

A stock that generates high returns may also experience significant price fluctuations and substantial losses during market downturns. Similarly, high trading activity does not necessarily indicate positive price performance.

Without analysing historical returns, volatility, drawdowns and trading activity together, it can be difficult to understand the relationship between investment performance and risk.

This project addresses this problem by examining historical stock market data to identify performance trends, compare investment risk and investigate trading behaviour across five major technology companies.

### Project Objectives

1. Evaluate historical stock price movements and investment returns.
2. Compare the performance of the selected companies.
3. Measure investment risk using volatility, Sharpe ratio and maximum drawdown.
4. Identify patterns in daily and monthly stock returns.
5. Examine trading volumes and their relationship with daily price movements.
6. Develop an interactive dashboard to communicate findings.

## Research Questions

The analysis was guided by the following questions:

1. Which company generated the highest cumulative return during the study period?
2. How did adjusted closing prices evolve over time?
3. Which companies experienced the highest and lowest daily returns?
4. How did monthly returns vary across the selected companies?
5. Which company demonstrated the strongest risk-adjusted performance?
6. Which stocks experienced the highest volatility and deepest drawdowns?
7. How frequently did each company record positive and negative trading days?
8. Which companies recorded the highest trading volumes?
9. Is there an observable relationship between trading volume and the magnitude of daily stock returns?

## Data Source

Historical end-of-day stock market data was obtained from the [EOD Historical Data (EODHD) API](https://eodhd.com/).

The extracted dataset included:

- Date
- Open
- High
- Low
- Close
- Adjusted Close
- Volume

Additional analytical fields were calculated during data preparation, including daily returns, cumulative returns, running peak prices and drawdowns.

The final dataset contains 1,255 observations across five companies, with 251 trading observations per company.

## Key Metrics

| Metric | Description |
|---|---|
| Daily Return | Percentage change in adjusted closing price from the previous trading day |
| Cumulative Return | Compounded return over the analysis period |
| Average Daily Return | Mean daily return during the selected period |
| Annualised Volatility | Standard deviation of daily returns annualised using 252 trading days |
| Sharpe Ratio | Risk-adjusted return measure using a simplified zero risk-free rate assumption |
| Maximum Drawdown | Largest percentage decline from a previous running price peak |
| Best Daily Return | Highest observed daily return |
| Worst Daily Return | Lowest observed daily return |
| Average Monthly Price | Average adjusted closing price within each calendar month |
| Monthly Percentage Change | Percentage change between consecutive monthly average adjusted closing prices |
| Trading Volume | Number of shares traded |
| Average Daily Volume | Average number of shares traded per trading day |

## Dashboard

The Power BI dashboard consists of four interactive pages, each focusing on a different aspect of stock market analysis.

### 1. Executive Summary

Provides an overview of the five companies and their overall investment performance.

Key visualisations:

- Companies analysed
- Top-performing stock
- Highest cumulative return
- Average annualised volatility
- Average Sharpe ratio
- Cumulative return comparison by company
- Risk-adjusted performance comparison
- Investment performance comparison table

![Executive Summary Dashboard](Screenshots/Executive%20Summary.png)

### 2. Stock Performance

Examines historical price movements and return patterns.

Key visualisations:

- Daily adjusted closing price trends
- Distribution of daily stock returns
- Monthly percentage change by company
- Latest adjusted closing price
- Average adjusted closing price
- Best and worst daily returns

![Stock Performance Dashboard](Screenshots/Stock%20Performance.png)

### 3. Investment Risk

Examines historical downside exposure and changing investment risk.

Key visualisations:

- Historical stock drawdown
- Rolling 30-trading-day annualised volatility
- Positive versus negative trading days
- Maximum drawdown
- Average rolling volatility
- Positive and negative trading-day counts

![Investment Risk Dashboard](Screenshots/Investment%20Risk.png)

### 4. Trading Activity

Investigates trading intensity and the relationship between trading volume and daily price movements.

Key visualisations:

- Average daily trading volume by company
- Daily trading volume trends
- Trading volume versus magnitude of daily returns
- Total shares traded
- Average daily volume
- Highest daily volume
- Trading days analysed

![Trading Activity Dashboard](Screenshots/Trading%20Activity.png)

Company and date slicers allow users to interactively explore the data.

## Key Findings

### 1. Stock Performance

Apple recorded the highest cumulative return during the study period, while NVIDIA was the only company with a negative cumulative return.

| Company | Cumulative Return | Performance Rank |
|---|---:|---:|
| Apple | 28.00% | 1 |
| Microsoft | 7.68% | 2 |
| Amazon | 6.09% | 3 |
| Alphabet | 2.40% | 4 |
| NVIDIA | -0.56% | 5 |

### 2. Investment Risk

Apple recorded the lowest annualised volatility and the highest Sharpe ratio among the five companies.

| Company | Annualised Volatility | Sharpe Ratio | Maximum Drawdown |
|---|---:|---:|---:|
| Apple | 24.89% | 1.125 | -13.80% |
| Microsoft | 33.87% | 0.386 | -30.53% |
| Amazon | 33.96% | 0.341 | -20.20% |
| Alphabet | 33.82% | 0.240 | -30.62% |
| NVIDIA | 38.43% | 0.176 | -24.09% |

These results demonstrate that the company with the highest cumulative return was not necessarily the company with the highest volatility.

### 3. Trading Activity

NVIDIA recorded the highest trading activity among the selected companies.

| Company | Total Trading Volume | Average Daily Volume |
|---|---:|---:|
| NVIDIA | 38.96 billion | 155.25 million |
| Apple | 12.04 billion | 47.98 million |
| Amazon | 11.47 billion | 45.67 million |
| Alphabet | 8.14 billion | 32.43 million |
| Microsoft | 8.06 billion | 32.11 million |

The results show substantial differences in trading activity across the five companies.

### 4. Overall Observations

- Apple delivered the strongest cumulative return and risk-adjusted performance during the study period.
- NVIDIA recorded the highest annualised volatility and trading volume.
- Alphabet and Microsoft experienced the deepest maximum drawdowns.
- All five companies experienced both positive and negative daily returns.
- Trading volume and the magnitude of daily returns provide additional perspectives on market activity, but an observed relationship does not establish causation.

## Tools Used

| Tool | Purpose |
|---|---|
| Python | Data extraction, cleaning, transformation and financial calculations |
| Jupyter Notebook | Interactive Python development and analysis |
| Pandas | Data manipulation and analysis |
| NumPy | Numerical calculations |
| Matplotlib | Exploratory data visualisation |
| EODHD API | Historical stock market data extraction |
| Microsoft SQL Server | Data storage and relational database management |
| SQL Server Management Studio (SSMS) | Database creation, querying and validation |
| Power BI | Interactive dashboard development |
| DAX | Measures and calculations for dashboard analysis |
| Git & GitHub | Version control and project documentation |

### Python

Python was used to retrieve historical stock data, transform the extracted records into structured DataFrames, validate data quality and calculate financial performance metrics.

**Calculating Daily and Cumulative Returns**

```python
import pandas as pd
import numpy as np

# Sort records by company and date
stock_data = stock_data.sort_values(
    ["ticker", "date"]
)

# Calculate daily returns
stock_data["daily_return"] = (
    stock_data.groupby("ticker")["adjusted_close"]
    .pct_change() * 100
)

# Calculate cumulative returns
stock_data["cumulative_return"] = (
    stock_data.groupby("ticker")["daily_return"]
    .transform(
        lambda x: ((1 + x / 100).cumprod() - 1) * 100
    )
)
```

**Calculating Annualised Volatility**

```python
risk_summary = (
    stock_data.groupby("company")
    .agg(
        AverageDailyReturn=("daily_return", "mean"),
        DailyVolatility=("daily_return", "std")
    )
)

risk_summary["AnnualisedVolatility"] = (
    risk_summary["DailyVolatility"] * np.sqrt(252)
)
```

### SQL Server

SQL Server was used to structure the processed datasets into relational tables, perform analytical queries, create reusable views and validate the imported data.

The database consists of the following tables:

- `DimCompany`
- `FactStockPrices`
- `FactStockPerformance`
- `FactStockRisk`
- `FactStockDrawdown`

**Stock Performance Ranking**

```sql
SELECT
    d.CompanyName,
    d.Ticker,
    p.CumulativeReturn,
    p.PerformanceRank

FROM dbo.FactStockPerformance AS p

INNER JOIN dbo.DimCompany AS d
    ON p.CompanyID = d.CompanyID

ORDER BY
    p.CumulativeReturn DESC;
```

**Monthly Stock Price Trends**

```sql
SELECT
    d.CompanyName,
    YEAR(s.Date) AS TradingYear,
    MONTH(s.Date) AS TradingMonth,
    AVG(s.AdjustedClose) AS AverageMonthlyPrice,
    MIN(s.AdjustedClose) AS LowestMonthlyPrice,
    MAX(s.AdjustedClose) AS HighestMonthlyPrice

FROM dbo.FactStockPrices AS s

INNER JOIN dbo.DimCompany AS d
    ON s.CompanyID = d.CompanyID

GROUP BY
    d.CompanyName,
    YEAR(s.Date),
    MONTH(s.Date)

ORDER BY
    TradingYear,
    TradingMonth,
    d.CompanyName;
```

Additional SQL analysis included:

- Month-over-month price changes using CTEs and `LAG()`.
- Trading volume aggregation.
- Daily return comparisons.
- Investment risk comparisons.
- Reusable SQL views for Power BI.

### Power BI and DAX

Power BI was used to develop the four-page interactive dashboard.

DAX was used to create calculations for:

- Cumulative return comparisons.
- Daily return analysis.
- Rolling 30-day volatility.
- Positive and negative trading-day counts.
- Trading volume metrics.
- Dashboard KPI cards.

## Methodology

The project followed an end-to-end analytical workflow.

### Phase 1: Data Extraction

- Connected to the EODHD API using Python and the `requests` library.
- Retrieved historical end-of-day data for five selected companies.
- Combined individual company datasets into one structured dataset.
- Exported the extracted records to CSV.

### Phase 2: Data Cleaning and Analysis

- Inspected dataset structure and data types.
- Checked for missing values and duplicate records.
- Converted date fields into datetime format.
- Validated price fields and adjusted closing prices.
- Calculated daily returns and cumulative returns.
- Calculated running peaks and drawdowns.
- Developed company-level performance and risk summaries.
- Exported processed datasets for SQL Server.

### Phase 3: SQL Server Database Development

- Created the `Stocks_Market_Investments` database.
- Designed the company dimension and stock fact tables.
- Imported processed CSV files into staging tables.
- Mapped company records using ticker symbols.
- Inserted cleaned data into destination tables.
- Validated record counts and company mappings.
- Developed analytical SQL queries.
- Created reusable SQL views for Power BI.

### Phase 4: Power BI Dashboard Development

- Connected Power BI to SQL Server.
- Imported fact tables, the dimension table and SQL views.
- Created and validated data relationships.
- Developed DAX measures.
- Designed four interactive report pages.
- Added company and date slicers.
- Applied consistent formatting and visual design.

### Phase 5: Documentation and Version Control

- Organised project files.
- Documented methodology and analytical findings.
- Prepared SQL scripts and Python notebooks for GitHub.
- Documented the Power BI dashboard and its key insights.

## Project Structure

```text
Stock_Market_Investment_Analysis/
│
├── Data/
│   ├── stock_market_data.csv
│   ├── stock_performance_summary.csv
│   ├── stock_risk_summary.csv
│   └── stock_drawdown_summary.csv
│
├── notebooks/
│   └── 01_EODHD_Data_Extraction.ipynb
│
├── SQL/
│   ├── 01_Database_Schema.sql
│   ├── 02_Analytical_Queries.sql
│   └── 03_SQL_Views.sql
│
├── PowerBI/
│   └── Stock_Market_Investment_Dashboard.pbix
│
├── screenshots/
│   ├── executive_summary.png
│   ├── stock_performance.png
│   ├── investment_risk.png
│   └── trading_activity.png
│
└── README.md
```

## How to Run the Project

### Prerequisites

- Python 3.x
- Jupyter Notebook
- EODHD API account
- Microsoft SQL Server
- SQL Server Management Studio
- Microsoft Power BI Desktop

### Python Setup

Install the required libraries:

```bash
pip install pandas numpy requests matplotlib jupyter
```

Obtain an API key from EODHD and store it securely. Do not hardcode API keys into notebooks or commit them to GitHub.

Launch Jupyter Notebook:

```bash
jupyter notebook
```

Open `notebooks/01_EODHD_Data_Extraction.ipynb` and run the notebook cells to retrieve and process the data.

### SQL Server Setup

1. Open SQL Server Management Studio.
2. Execute `01_Database_Schema.sql` to create the database and destination tables.
3. Import the processed CSV files into the required staging tables.
4. Execute the data insertion and validation scripts.
5. Run `02_Analytical_Queries.sql` to explore the data.
6. Execute `03_SQL_Views.sql` to create reusable views.

### Power BI Setup

1. Open the Power BI project file.
2. Connect to the SQL Server database if required.
3. Update the data source connection to your SQL Server instance.
4. Refresh the data.
5. Explore the dashboard using the company and date slicers.

## Project Context

This is an independent financial data analytics portfolio project developed to demonstrate practical skills in financial data analysis, database management, SQL querying, Python programming and business intelligence reporting.

The project focuses on historical market data and analytical comparisons rather than making investment recommendations.

## Assumptions & Limitations

1. **Limited company selection:** The analysis covers five US-listed technology companies and does not represent the entire stock market.

2. **Limited time period:** The dataset covers approximately one year of historical trading activity. Longer periods may produce different performance and risk conclusions.

3. **Historical data:** Historical performance does not guarantee future investment results.

4. **Risk-free rate assumption:** The Sharpe ratio uses a simplified zero risk-free rate assumption. A more comprehensive analysis would incorporate an appropriate risk-free rate.

5. **Annualisation assumption:** Annualised volatility uses 252 trading days as the assumed number of trading days per year.

6. **Dividend analysis:** A separate dividend and dividend-yield analysis was not included in this version.

7. **Market factors:** The analysis does not incorporate macroeconomic indicators, interest rates, earnings announcements or broader market benchmarks.

8. **Trading volume interpretation:** Trading volume measures the number of shares traded, not the monetary value of those shares. High volume does not automatically indicate positive price movements.

9. **Data provider:** The analysis depends on the completeness and accuracy of the historical data supplied by EODHD.

10. **Investment interpretation:** The results are historical analytical observations and should not be treated as personalised investment advice.

## Future Improvements

Potential extensions to the project include:

- Extend the analysis to a longer historical period.
- Include additional companies and industry sectors.
- Compare stock performance against the S&P 500 or NASDAQ Composite.
- Incorporate dividend-adjusted total return analysis.
- Investigate correlations between companies.
- Develop more advanced rolling risk measures.
- Analyse the relationship between trading volume and price volatility in greater depth.
- Introduce statistical modelling and machine learning for exploratory forecasting.
- Automate data extraction and dashboard refresh processes.

## Conclusion

This project demonstrates an end-to-end approach to financial data analytics, transforming historical stock market data into structured datasets, analytical queries and interactive business intelligence reports.

By combining Python, SQL Server and Power BI, the project explores the relationship between stock performance, investment risk and trading activity while demonstrating practical data preparation, analytical and visualisation skills.


**Data Source:** [EOD Historical Data (EODHD)](https://eodhd.com/)
