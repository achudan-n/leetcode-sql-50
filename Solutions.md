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

