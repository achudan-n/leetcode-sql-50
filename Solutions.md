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
