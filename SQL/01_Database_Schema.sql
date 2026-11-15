use Stocks_Market_Investments;
select DB_NAME () CurrentDatabase;

-- CREATE TABLES

CREATE TABLE DimCompany (
    CompanyID INT IDENTITY(1,1) PRIMARY KEY,
    CompanyName VARCHAR(100) NOT NULL,
    Ticker VARCHAR(20) NOT NULL UNIQUE,
    Exchange VARCHAR(20)
);

CREATE TABLE dbo.FactStockPrices
(
    StockPriceID INT IDENTITY(1,1) PRIMARY KEY,

    CompanyID INT NOT NULL,

    [Date] DATE NOT NULL,

    [Open] DECIMAL(18,4) NOT NULL,
    High DECIMAL(18,4) NOT NULL,
    Low DECIMAL(18,4) NOT NULL,
    [Close] DECIMAL(18,4) NOT NULL,
    AdjustedClose DECIMAL(18,4) NOT NULL,

    Volume BIGINT NOT NULL,

    DailyReturn DECIMAL(18,6) NULL,
    CumulativeReturn DECIMAL(18,6) NULL,
    RunningPeak DECIMAL(18,4) NULL,
    Drawdown DECIMAL(18,6) NULL,

    CONSTRAINT FK_FactStockPrices_DimCompany
        FOREIGN KEY (CompanyID)
        REFERENCES dbo.DimCompany(CompanyID)
);

CREATE TABLE dbo.FactStockPerformance
(
    PerformanceID INT IDENTITY(1,1) PRIMARY KEY,

    CompanyID INT NOT NULL,

    FinalAdjustedClose DECIMAL(18,4),
    CumulativeReturn DECIMAL(18,6),
    PerformanceRank INT,

    CONSTRAINT FK_StockPerformance_DimCompany
        FOREIGN KEY (CompanyID)
        REFERENCES dbo.DimCompany(CompanyID),

    CONSTRAINT UQ_StockPerformance_Company
        UNIQUE (CompanyID)
);

CREATE TABLE dbo.FactStockRisk
(
    RiskID INT IDENTITY(1,1) PRIMARY KEY,

    CompanyID INT NOT NULL,

    AverageDailyReturn DECIMAL(18,6),
    DailyVolatility DECIMAL(18,6),
    AnnualisedVolatility DECIMAL(18,6),
    BestDay DECIMAL(18,6),
    WorstDay DECIMAL(18,6),
    SharpeRatio DECIMAL(18,6),

    CONSTRAINT FK_StockRisk_DimCompany
        FOREIGN KEY (CompanyID)
        REFERENCES dbo.DimCompany(CompanyID),

    CONSTRAINT UQ_StockRisk_Company
        UNIQUE (CompanyID)
);

CREATE TABLE dbo.FactStockDrawdown
(
    DrawdownID INT IDENTITY(1,1) PRIMARY KEY,

    CompanyID INT NOT NULL,

    MaximumDrawdown DECIMAL(18,6),

    CONSTRAINT FK_StockDrawdown_DimCompany
        FOREIGN KEY (CompanyID)
        REFERENCES dbo.DimCompany(CompanyID),

    CONSTRAINT UQ_StockDrawdown_Company
        UNIQUE (CompanyID)
);

--Insert company records
INSERT INTO dbo.DimCompany
    (CompanyName, Ticker, Exchange)
VALUES
    ('Apple', 'AAPL.US', 'NASDAQ'),
    ('Microsoft', 'MSFT.US', 'NASDAQ'),
    ('Amazon', 'AMZN.US', 'NASDAQ'),
    ('NVIDIA', 'NVDA.US', 'NASDAQ'),
    ('Alphabet', 'GOOGL.US', 'NASDAQ');

--FACTSTOCKPRICE TABLE
   INSERT INTO dbo.FactStockPrices
(
    CompanyID,
    [Date],
    [Open],
    High,
    Low,
    [Close],
    AdjustedClose,
    Volume,
    DailyReturn,
    CumulativeReturn,
    RunningPeak,
    Drawdown
)

SELECT
    d.CompanyID,
    s.[date],
    s.[open],
    s.[high],
    s.[low],
    s.[close],
    s.adjusted_close,
    s.volume,
    s.daily_return,
    s.cumulative_return,
    s.running_peak,
    s.drawdown

FROM dbo.stock_prices_staging AS s

INNER JOIN dbo.DimCompany AS d
    ON s.ticker = d.Ticker;

--- Fact Stock Perfomance Table
SELECT
    d.CompanyID,
    d.CompanyName,
    s.ticker,
    s.adjusted_close AS FinalAdjustedClose,
    s.cumulative_return AS CumulativeReturn,

    ROW_NUMBER() OVER (
        ORDER BY s.cumulative_return DESC
    ) AS PerformanceRank

FROM dbo.stock_performance_staging AS s

INNER JOIN dbo.DimCompany AS d
    ON s.ticker = d.Ticker;

    INSERT INTO dbo.FactStockPerformance
(
    CompanyID,
    FinalAdjustedClose,
    CumulativeReturn,
    PerformanceRank
)

SELECT
    d.CompanyID,
    s.adjusted_close,
    s.cumulative_return,

    ROW_NUMBER() OVER (
        ORDER BY s.cumulative_return DESC
    )

FROM dbo.stock_performance_staging AS s

INNER JOIN dbo.DimCompany AS d
    ON s.ticker = d.Ticker;

    --- Fact Stock Risk Table
    SELECT
    d.CompanyID,
    d.CompanyName,
    s.average_daily_return,
    s.daily_volatility,
    s.annualised_volatility,
    s.best_day,
    s.worst_day,
    s.sharpe_ratio

FROM dbo.stock_risk_staging AS s

LEFT JOIN dbo.DimCompany AS d
    ON s.company = d.CompanyName;

    INSERT INTO dbo.FactStockRisk
(
    CompanyID,
    AverageDailyReturn,
    DailyVolatility,
    AnnualisedVolatility,
    BestDay,
    WorstDay,
    SharpeRatio
)

SELECT
    d.CompanyID,
    s.average_daily_return,
    s.daily_volatility,
    s.annualised_volatility,
    s.best_day,
    s.worst_day,
    s.sharpe_ratio

FROM dbo.stock_risk_staging AS s

INNER JOIN dbo.DimCompany AS d
    ON s.company = d.CompanyName;

    -- Fact Stock Drawdown Table
    SELECT
    d.CompanyID,
    d.CompanyName,
    s.maximum_drawdown

FROM dbo.stock_drawdown_staging AS s

LEFT JOIN dbo.DimCompany AS d
    ON s.company = d.CompanyName;

    INSERT INTO dbo.FactStockDrawdown
(
    CompanyID,
    MaximumDrawdown
)

SELECT
    d.CompanyID,
    s.maximum_drawdown

FROM dbo.stock_drawdown_staging AS s

INNER JOIN dbo.DimCompany AS d
    ON s.company = d.CompanyName;

    --- DATA VALIDATION
    
SELECT
    COUNT(*) AS TotalRecords,
    COUNT(DISTINCT CompanyID) AS Companies
FROM dbo.FactStockPrices;

SELECT
    'Performance' AS TableName,
    COUNT(*) AS TotalRecords
FROM dbo.FactStockPerformance

UNION ALL

SELECT
    'Risk',
    COUNT(*)
FROM dbo.FactStockRisk

UNION ALL

SELECT
    'Drawdown',
    COUNT(*)
FROM dbo.FactStockDrawdown;

