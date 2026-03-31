-- Calculate Monthly Revenue Growth
WITH MonthlyRevenue AS (
    SELECT 
        DATE_TRUNC('month', purchase_date) AS rev_month,
        SUM(amount) AS total_revenue
    FROM transactions
    GROUP BY 1
)
SELECT 
    rev_month,
    total_revenue,
    LAG(total_revenue) OVER (ORDER BY rev_month) AS last_month_revenue,
    (total_revenue - LAG(total_revenue) OVER (ORDER BY rev_month)) / 
    NULLIF(LAG(total_revenue) OVER (ORDER BY rev_month), 0) * 100 AS percentage_growth
FROM MonthlyRevenue;
