-- 1. Create the Macroeconomic Indicators Table
CREATE TABLE macro_indicators (
    record_date DATE PRIMARY KEY,
    cpi_yoy NUMERIC(5, 2),        
    fed_funds_rate NUMERIC(5, 2), 
    gdp_growth NUMERIC(5, 2)      
);

-- 2. Create the Portfolio Trades Table
CREATE TABLE portfolio_trades (
    trade_id SERIAL PRIMARY KEY,
    trade_date DATE NOT NULL,
    ticker VARCHAR(10) NOT NULL,
    action VARCHAR(10) NOT NULL,  
    strategy VARCHAR(50),         
    quantity INT NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    total_value NUMERIC(12, 2) NOT NULL
);

-- 3. Create the Market Prices Table (for daily SPY tracking)
CREATE TABLE market_prices (
    price_date DATE PRIMARY KEY,
    ticker VARCHAR(10) NOT NULL,
    close_price NUMERIC(10, 2) NOT NULL,
    volume BIGINT
);