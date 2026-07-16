# PostgreSQL SELECT Query Cheat Sheet for LeetCode

This cheat sheet is designed to help you quickly write efficient and correct SELECT queries for solving SQL problems on LeetCode.

---

## 📌 Basic SELECT Syntax
```sql
SELECT column1, column2
FROM table_name
WHERE condition
ORDER BY column1 ASC|DESC
LIMIT n OFFSET m;
```

---

## 📊 Aggregation Functions
| Function      | Description                    |
|---------------|--------------------------------|
| `COUNT(*)`    | Count rows                     |
| `SUM(column)` | Total sum                      |
| `AVG(column)` | Average value                  |
| `MIN(column)` | Minimum value                  |
| `MAX(column)` | Maximum value                  |

```sql
SELECT department, COUNT(*) FROM employees GROUP BY department;
```

---

## 🎯 Filtering and Conditions
```sql
WHERE age >= 18 AND country = 'USA'
```

### Operators:
- `=`, `!=`, `<`, `>`, `<=`, `>=`
- `BETWEEN a AND b`
- `IN (...)`
- `LIKE '%pattern%'`
- `IS NULL`, `IS NOT NULL`

---

## 🧮 GROUP BY & HAVING
```sql
SELECT department, COUNT(*) 
FROM employees 
GROUP BY department 
HAVING COUNT(*) > 5;
```

---

## 🧩 Joins
```sql
-- INNER JOIN
SELECT e.name, d.name 
FROM employees e
JOIN departments d ON e.department_id = d.id;

-- LEFT JOIN
SELECT e.name, d.name 
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id;
```

---

## ⏰ Date & Time Functions
```sql
-- Current Date & Time
SELECT CURRENT_DATE, CURRENT_TIME, NOW();

-- Extract components
SELECT EXTRACT(YEAR FROM birth_date) AS birth_year;

-- Date arithmetic
SELECT order_date + INTERVAL '1 day' AS next_day;
```

---

## 🛠 Built-in String Functions
```sql
LOWER(name), UPPER(name)
LENGTH(name)
SUBSTRING(name FROM 1 FOR 3)
TRIM(BOTH 'x' FROM 'xxxabcxxx')
CONCAT(first_name, ' ', last_name)
```

---

## 🧠 Window Functions
```sql
SELECT *,
       RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dept_rank,
       LEAD(salary) OVER (ORDER BY salary) AS next_salary
FROM employees;
```

---

## 🧪 CASE Statement
```sql
SELECT name,
       CASE 
           WHEN age >= 18 THEN 'Adult'
           ELSE 'Minor'
       END AS age_group
FROM users;
```

---

## 📅 Common Date Filters
```sql
WHERE order_date >= CURRENT_DATE - INTERVAL '30 days'
```

---

## 🚀 ORDER BY & LIMIT
```sql
ORDER BY salary DESC
LIMIT 5 OFFSET 10
```

---

## 🔄 DISTINCT & UNION
```sql
SELECT DISTINCT department FROM employees;

SELECT city FROM customers
UNION
SELECT city FROM suppliers;
```

---

## 📍 Aliases
```sql
SELECT first_name AS fname
FROM users u;
```

---

## 🔁 Subqueries
```sql
-- In SELECT
SELECT name, (SELECT COUNT(*) FROM orders o WHERE o.user_id = u.id) AS order_count
FROM users u;

-- In WHERE
SELECT name 
FROM users 
WHERE id IN (SELECT user_id FROM orders WHERE total > 100);
```

---

## 📘 Tips for LeetCode
- Use `WITH` clauses (CTEs) for readability in complex queries.
- Break down the problem into subqueries if needed.
- Check for `NULL` values explicitly using `IS NULL` or `IS NOT NULL`.
- Test the query step-by-step: start with FROM + WHERE, then add SELECT, GROUP BY, etc.
