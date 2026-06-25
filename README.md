# Stock Portfolio & Economic Data Tracker

## Project Overview
This SQL project explores a practical business question: **How does the broader economy impact an investment portfolio?** 

I built a custom relational database to track simulated stock market trades and linked them directly to major national economic reports. The goal is to transform raw, daily transaction logs into clear insights about portfolio growth during different economic cycles.

---

## The Database
The project relies on three core tables:

* **`portfolio_trades`**: A daily log of investments, buy/sell actions, and cash flow.
* **`market_prices`**: Historical daily stock prices and trading volume.
* **`macro_indicators`**: Monthly U.S. inflation and Federal Reserve interest rates.

---

## The Analytical Challenge
Stock trades happen every day, but government economic data is only released once a month. To bridge this gap, I wrote SQL queries that:

1. **Calculate daily cash flow:** Used `CASE` statements to separate incoming profits from outgoing costs.
2. **Track a running balance:** Applied the `SUM() OVER()` window function to act like a continuously updating bank ledger.
3. **Align mismatched dates:** Used `DATE_TRUNC` to round daily trade dates down to the nearest month, allowing them to join cleanly with monthly economic reports.

---

## Code Highlight
This snippet shows the Common Table Expression (CTE) used to generate the running portfolio balance:

```sql
WITH Daily_Cashflow AS (
    SELECT 
        trade_date,
        SUM(CASE WHEN action = 'SELL' THEN total_value ELSE -total_value END) AS daily_net_cash
    FROM portfolio_trades
    GROUP BY trade_date
),
Running_Balance AS (
    SELECT 
        trade_date,
        daily_net_cash,
        SUM(daily_net_cash) OVER (ORDER BY trade_date) AS cumulative_portfolio_balance
    FROM Daily_Cashflow
)
