
USE Stocks_Market_Investments;
GO

-- Stock Performance Overview
CREATE VIEW dbo.vw_Stock_Performance
AS
SELECT
    d.CompanyName,
    d.Ticker,
    p.FinalAdjustedClose,
    p.CumulativeReturn,
    p.PerformanceRank,
    r.AverageDailyReturn,
    r.DailyVolatility,
    r.AnnualisedVolatility,
    r.SharpeRatio,
    r.BestDay,
    r.WorstDay,
    dd.MaximumDrawdown

FROM dbo.FactStockPerformance AS p

INNER JOIN dbo.FactStockRisk AS r
    ON p.CompanyID = r.CompanyID

INNER JOIN dbo.FactStockDrawdown AS dd
    ON p.CompanyID = dd.CompanyID

INNER JOIN dbo.DimCompany AS d
    ON p.CompanyID = d.CompanyID;
GO


 --MONTHLY STOCK PRICE TRENDS
  

CREATE VIEW dbo.vw_Stock_Price_Trends
AS
SELECT
    d.CompanyName,
    d.Ticker,
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
    d.Ticker,
    YEAR(s.Date),
    MONTH(s.Date);
GO

--INVESTMENT RISK ANALYSIS

CREATE VIEW dbo.vw_Stock_Risk_Analysis
AS
SELECT
    d.CompanyName,
    d.Ticker,
    r.AverageDailyReturn,
    r.DailyVolatility,
    r.AnnualisedVolatility,
    r.BestDay,
    r.WorstDay,
    r.SharpeRatio,
    dd.MaximumDrawdown
FROM dbo.FactStockRisk AS r
INNER JOIN dbo.FactStockDrawdown AS dd
    ON r.CompanyID = dd.CompanyID
INNER JOIN dbo.DimCompany AS d
    ON r.CompanyID = d.CompanyID;
GO


 --TRADING ACTIVITY

ALTER VIEW dbo.vw_Trading_Activity
AS
SELECT
    d.CompanyName,
    d.Ticker,
    SUM(s.Volume) AS TotalTradingVolume,
    AVG(CAST(s.Volume AS DECIMAL(18,2))) AS AverageDailyVolume,
    MAX(s.Volume) AS HighestDailyVolume,
    MIN(s.Volume) AS LowestDailyVolume
FROM dbo.FactStockPrices AS s
INNER JOIN dbo.DimCompany AS d
    ON s.CompanyID = d.CompanyID
GROUP BY
    d.CompanyName,
    d.Ticker;
GO

   --TESTING VIEWS

   SELECT *
FROM dbo.vw_Stock_Performance
ORDER BY PerformanceRank;

SELECT *
FROM dbo.vw_Stock_Price_Trends
ORDER BY TradingYear, TradingMonth, CompanyName;

SELECT *
FROM dbo.vw_Stock_Risk_Analysis
ORDER BY SharpeRatio DESC;

SELECT *
FROM dbo.vw_Trading_Activity
ORDER BY TotalTradingVolume DESC;
GO
