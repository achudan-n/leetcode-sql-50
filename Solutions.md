# Leetcode SQL 50

### 1 - 1757. Recyclable and Low Fat Products
```sql
SELECT
    product_id
FROM
    Products
WHERE
    low_fats = 'Y'
    AND recyclable = 'Y'
```

<br>

---

### 2 - 584. Find Customer Referee
```sql
SELECT
    name
FROM
    Customer
WHERE
    referee_id != 2
    OR referee_id IS NULL
```
<br>

---
### 3 - 595. Big Countries
```sql
SELECT
    name, population, area
FROM
    World
WHERE
    area >= 3000000
    OR population >= 25000000
```
<br>

---
### 4 - 1683. Invalid Tweets
```sql
SELECT 
    tweet_id
FROM
    Tweets
WHERE 
    -- LENGTH(content) > 15
    CHAR_LENGTH(content) > 15
```

`CHAR_LENGTH(string)` returns the number of characters. <br>
`LENGTH(string)` returns the number of bytes (for multi-byte characters, this can differ).

<br>

---

### 5 - 1148. Article Views I
```sql
SELECT DISTINCT
    author_id AS id
FROM
    Views
WHERE
    author_id = viewer_id
ORDER BY
    id
```

<br>

---

### 6 - 1378. Replace Employee ID With The Unique Identifier
```sql
SELECT
    unique_id,
    name
FROM
    Employees e
    LEFT JOIN EmployeeUNI eu ON e.id = eu.id
```

<br>

---

### 7 - 1068. Product Sales Analysis I
```sql
SELECT
    product_name, year, price
FROM 
    Sales s
    JOIN Product p ON s.product_id = p.product_id
```
<br>

---

### 8 - 1581. Customer Who Visited but Did Not Make Any Transactions
```sql
SELECT
    customer_id, 
    COUNT(v.visit_id) AS count_no_trans
FROM
    Visits v
    LEFT JOIN Transactions t ON v.visit_id = t.visit_id
WHERE 
    transaction_id IS NULL
GROUP BY
    customer_id
```
<br>

---
### 9 - 197. Rising Temperature
```sql
SELECT
    w2.Id
FROM
    Weather w1
    JOIN Weather w2 ON DATEDIFF(w2.recordDate, w1.recordDate) = 1
WHERE
    w1.temperature < w2.temperature
```

Using LAG:
```sql
WITH 
    previous AS (
        SELECT
            id, 
            recordDate,
            temperature,
            LAG(recordDate, 1) OVER (ORDER BY recordDate) AS prev_date,
            LAG(temperature, 1) OVER (ORDER BY recordDate) AS prev_temp
        FROM 
            Weather
    )

SELECT 
    Id
FROM
    previous
WHERE 
    DATEDIFF(recordDate, prev_date) = 1
    AND temperature > prev_temp
```

`DATEDIFF` is needed here even though LAG is used to calculate the previous date, because there might be missing dates in the table.

<br>

---

### 10 - 1661. Average Time of Process per Machine

```sql
SELECT
    a1.machine_id,
    ROUND(
        AVG(a2.timestamp - a1.timestamp)    
    ,3) AS processing_time
FROM
    Activity a1
    JOIN Activity a2 ON 
        a1.machine_id = a2.machine_id
        AND a1.process_id = a2.process_id
        AND a1.activity_type = 'start' 
        AND a2.activity_type = 'end'
GROUP BY
    machine_id
```

<br>

---

