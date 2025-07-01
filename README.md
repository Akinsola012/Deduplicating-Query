**What I Did in This Project**

The dataset game_details contains statistics about players in basketball games. However, some records are duplicated — the same player stats for the same game might appear multiple times.

**Step 1: Identifying Duplicates**

I first check for duplicate rows by grouping the data by key columns such as:

game_id (which game)

team_id (which team)

player_id (which player)

and counting how many times each group appears. If the count is more than 1, those rows are duplicates.

**Step 2: Deduplicating Using ROW_NUMBER()**

To remove duplicates, I use a SQL technique with the ROW_NUMBER() window function. This assigns a unique number to each row within each group of duplicates.

I partition the data by all columns that define a unique record.

Then we keep only the first row (ROW_NUMBER() = 1) for each group, effectively dropping all other duplicates.

This method is efficient and preserves the first occurrence of each unique record.

**Step 3: Verifying Deduplication**

After deduplication, I run another query to confirm no duplicates remain. This ensures the data is clean and ready for analysis.

**Benefits for Organizations**

Accurate Reporting: Reliable data helps generate precise reports and dashboards.

Cost Efficiency: Reduces storage costs by eliminating unnecessary data.

Improved Decision-Making: Supports better business strategies based on clean data.

Data Integrity: Maintains the health of data systems, preventing cascading errors.

