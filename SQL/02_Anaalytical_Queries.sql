--  STOCK PERFORMANCE RANKING
SELECT
    d.CompanyName,
    d.Ticker,
    p.FinalAdjustedClose,
    p.CumulativeReturn,
    p.PerformanceRank

FROM dbo.FactStockPerformance AS p

INNER JOIN dbo.DimCompany AS d
    ON p.CompanyID = d.CompanyID

ORDER BY
    p.CumulativeReturn DESC;

--- Monthly stock price trends
SELECT
    d.CompanyName,

    YEAR(s.Date) AS TradingYear,

    MONTH(s.Date) AS TradingMonth,

    AVG(s.AdjustedClose) AS AverageMonthlyPrice,

    MIN(s.AdjustedClose) AS LowestPrice,

    MAX(s.AdjustedClose) AS HighestPrice

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

    -- Monthly percentage price change
    WITH MonthlyPrices AS
(
    SELECT
        d.CompanyName,
        YEAR(s.Date) AS TradingYear,
        MONTH(s.Date) AS TradingMonth,
        AVG(s.AdjustedClose) AS AverageMonthlyPrice

    FROM dbo.FactStockPrices AS s

    INNER JOIN dbo.DimCompany AS d
        ON s.CompanyID = d.CompanyID

    GROUP BY
        d.CompanyName,
        YEAR(s.Date),
        MONTH(s.Date)
),

PreviousMonth AS
(
    SELECT
        CompanyName,
        TradingYear,
        TradingMonth,
        AverageMonthlyPrice,

        LAG(AverageMonthlyPrice) OVER
        (
            PARTITION BY CompanyName
            ORDER BY TradingYear, TradingMonth
        ) AS PreviousMonthPrice

    FROM MonthlyPrices
)

SELECT
    CompanyName,
    TradingYear,
    TradingMonth,
    AverageMonthlyPrice,
    PreviousMonthPrice,

    ROUND(
        (AverageMonthlyPrice - PreviousMonthPrice)
        / NULLIF(PreviousMonthPrice, 0) * 100,
        2
    ) AS MonthlyPercentageChange

FROM PreviousMonth

ORDER BY
    CompanyName,
    TradingYear,
    TradingMonth;

    --- Trading Activity Analysis
    SELECT
    d.CompanyName,

    SUM(s.Volume) AS TotalTradingVolume,

    AVG(CAST(s.Volume AS BIGINT)) AS AverageDailyVolume,

    MAX(s.Volume) AS HighestDailyVolume,

    MIN(s.Volume) AS LowestDailyVolume

FROM dbo.FactStockPrices AS s

INNER JOIN dbo.DimCompany AS d
    ON s.CompanyID = d.CompanyID

GROUP BY
    d.CompanyName

ORDER BY
    TotalTradingVolume DESC;

    --- Daily Returns Analysis
    SELECT
    d.CompanyName,
    AVG(s.DailyReturn) AS AverageDailyReturn,
    MAX(s.DailyReturn) AS BestDailyReturn,
    MIN(s.DailyReturn) AS WorstDailyReturn
FROM dbo.FactStockPrices AS s
INNER JOIN dbo.DimCompany AS d
    ON s.CompanyID = d.CompanyID
GROUP BY d.CompanyName
ORDER BY AverageDailyReturn DESC;


--- Comparative Investment Analysis
SELECT
    d.CompanyName,
    p.CumulativeReturn,
    r.AnnualisedVolatility,
    r.SharpeRatio,
    dd.MaximumDrawdown
FROM dbo.FactStockPerformance AS p
INNER JOIN dbo.FactStockRisk AS r
    ON p.CompanyID = r.CompanyID
INNER JOIN dbo.FactStockDrawdown AS dd
    ON p.CompanyID = dd.CompanyID
INNER JOIN dbo.DimCompany AS d
    ON p.CompanyID = d.CompanyID
ORDER BY r.SharpeRatio DESC;