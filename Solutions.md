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

JOIN calculations:

| Join Type       | Row Count Range       |
| --------------- | --------------------- |
| CROSS JOIN      | **m × n**             |
| INNER JOIN      | **0 → m × n**         |
| LEFT JOIN       | **m → m × n**         |
| RIGHT JOIN      | **n → m × n**         |
| FULL OUTER JOIN | **max(m, n) → m × n** |
| SELF JOIN       | **0 → m²**            |

<br>

---

### 11 - 577. Employee Bonus
```sql
SELECT 
    name, 
    bonus
FROM 
    Employee e
    LEFT JOIN Bonus b ON e.empId = b.empId 
WHERE
    bonus < 1000 
    OR bonus IS NULL
```

The below query is syntactically valid but **incorrect**.
```sql
SELECT 
    name, 
    bonus
FROM 
    Employee e
    LEFT JOIN Bonus b ON e.empId = b.empId AND b.bonus < 1000
```


The condition `b.bonus < 1000` in the `ON` clause filters out rows from the `Bonus` table that do not meet this condition before the join occurs. As a result, if an employee has a bonus of 1000 or more, they will not have a matching row in the `Bonus` table, leading to a `NULL` value for the `bonus` column in the result set.

This means that employees with a bonus of 1000 or more will still be included in the result set, but their `bonus` value will be `NULL`. This is not the intended behavior if we want to exclude employees with bonuses of 1000 or more entirely.

To correctly filter out employees with bonuses of 1000 or more, the condition should be placed in the `WHERE` clause, as shown in the first query. This ensures that only employees with bonuses less than 1000 or no bonus at all are included in the final result set.

<br>

---

### 12 - 1280. Students and Examinations
```sql
SELECT 
    st.student_id, st.student_name, su.subject_name,
    COUNT(e.subject_name) attended_exams
FROM
    Students st CROSS JOIN Subjects su
    LEFT JOIN Examinations e 
    ON st.student_id = e.student_id 
    AND su.subject_name = e.subject_name
GROUP BY
    student_id, student_name, subject_name
ORDER BY
    student_id, 
    subject_name
```

Joins students × subjects with all raw examinations rows before aggregating.

If a student wrote 100 exams in the same subject, you’ll carry all 100 rows until the final GROUP BY.

More straightforward to read, but potentially heavier.

```sql
SELECT
    st.student_id, st.student_name, su.subject_name, IFNULL(cnt, 0) AS attended_exams 
FROM
    students st CROSS JOIN subjects su
    LEFT JOIN (
        SELECT student_id, subject_name, count(subject_name) AS cnt
        FROM examinations GROUP BY student_id, subject_name
    ) e
    ON st.student_id = e.student_id AND su.subject_name = e.subject_name
ORDER BY 
    student_id, subject_name
```
Subquery (g) reduces the size of examinations first by grouping → much smaller intermediate result.

Outer join just has to look up at most one row per (student, subject) instead of all raw examinations rows.

Very efficient if examinations is large.

<br>

---

### 13 - 570. Managers with at Least 5 Direct Reports
```sql
SELECT
    name
FROM
    Employee e JOIN (
        SELECT managerId FROM Employee GROUP BY managerId HAVING COUNT(managerId) > 4
    ) m
    ON e.id = m.managerId
```

```sql
select name from employee
where id in (select managerid id from employee group by managerid having count(*) > 4) 

select e1.name from employee e1 
join (select managerid id from employee group by managerid having count(*) > 4) as e2
on e1.id = e2.id

SELECT e1.name
FROM employee e1
JOIN employee e2 ON e1.id = e2.managerid
GROUP BY e1.id, e1.name
HAVING COUNT(e2.id) > 4;
```

<br>

---

### 14 - 1934. Confirmation Rate
```sql
SELECT
    s.user_id, 
    IFNULL(ROUND(AVG(c.action = 'confirmed') ,2) , 0) AS confirmation_rate
FROM
    Signups s LEFT JOIN Confirmations c ON s.user_id = c.user_id
GROUP BY
    s.user_id
```

<br>

---

### 15 - 620. Not Boring Movies
```sql
SELECT
    id, movie, description, rating
FROM
    Cinema 
WHERE
    mod(id, 2) <> 0
    AND description <> 'boring'
ORDER BY
    rating DESC
```

<br>

---

### 16 - 1251. Average Selling Price
```sql
