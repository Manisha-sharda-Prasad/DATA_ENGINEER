# PostgreSQL SQL Cheat Sheet

## 🧱 Data Types
| Category     | Data Types |
|--------------|------------|
| Integer      | `SMALLINT`, `INTEGER`, `BIGINT` |
| Decimal      | `DECIMAL(p, s)`, `NUMERIC`, `REAL`, `DOUBLE PRECISION` |
| Serial       | `SMALLSERIAL`, `SERIAL`, `BIGSERIAL` |
| Text/String  | `CHAR(n)`, `VARCHAR(n)`, `TEXT` |
| Date/Time    | `DATE`, `TIME`, `TIMESTAMP`, `INTERVAL` |
| Boolean      | `BOOLEAN` (TRUE/FALSE) |
| UUID         | `UUID` |
| JSON         | `JSON`, `JSONB` |

---

## 📋 Table Operations

### Create Table
```sql
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  email TEXT UNIQUE,
  age INT,
  created_at TIMESTAMP DEFAULT NOW()
);
```

### Drop Table
```sql
DROP TABLE users;
```

---

## ✏️ CRUD Operations

### INSERT
```sql
INSERT INTO users (name, email, age) 
VALUES ('Alice', 'alice@example.com', 25);
```

### SELECT
```sql
SELECT * FROM users;
SELECT name, age FROM users WHERE age > 21;
```

### UPDATE
```sql
UPDATE users 
SET age = 26 
WHERE id = 1;
```

### DELETE
```sql
DELETE FROM users 
WHERE id = 1;
```

---

## 🔗 Joins

### INNER JOIN
```sql
SELECT users.name, orders.total 
FROM users 
INNER JOIN orders ON users.id = orders.user_id;
```

### LEFT JOIN
```sql
SELECT users.name, orders.total 
FROM users 
LEFT JOIN orders ON users.id = orders.user_id;
```

---

## 📌 Constraints
- `PRIMARY KEY`
- `UNIQUE`
- `NOT NULL`
- `CHECK (age >= 18)`
- `FOREIGN KEY (user_id) REFERENCES users(id)`

---

## ⚙️ Indexes
```sql
CREATE INDEX idx_users_email ON users(email);
```

---

## 🔍 Useful Commands

### Show All Databases
```sql
\l
```

### Connect to Database
```sql
\c dbname
```

### Show All Tables
```sql
\dt
```

### Describe Table
```sql
\d tablename
```

---

## 🧠 Other Tips

### Limit and Offset
```sql
SELECT * FROM users LIMIT 10 OFFSET 20;
```

### Aliases
```sql
SELECT u.name FROM users AS u;
```

### Aggregate Functions
```sql
SELECT COUNT(*), AVG(age), MAX(age) FROM users;
```

---
