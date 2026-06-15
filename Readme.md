# 🏆 Football Ticket Booking System — SQL Practice

A collection of PostgreSQL queries demonstrating core relational database concepts using a football match ticket booking schema (Users, Matches, and Bookings).

All queries are written for **PostgreSQL** and can be found in [`QUERY.sql`](./QUERY.sql).

---

## 📂 Project Overview

| Aspect | Details |
|---|---|
| **Database** | PostgreSQL |
| **Domain** | Football match ticket booking platform |
| **Tables Used** | `Users`, `Matches`, `Bookings` |
| **File** | `QUERY.sql` |

---

## 🧠 Concepts Covered

| Concept | Used In |
|---|---|
| `WHERE` with multiple conditions | Query 1 |
| `LIKE` / `ILIKE` (pattern matching) | Query 2 |
| `IS NULL` / `COALESCE` | Query 3 |
| `INNER JOIN` | Query 4 |
| `LEFT JOIN` | Query 5 |
| Subqueries / Aggregates (`AVG`) | Query 6 |
| `ORDER BY`, `LIMIT`, `OFFSET` | Query 7 |

---

## 📋 Queries & Sample Output

### Query 1 — Upcoming Champions League Matches
Retrieve all upcoming football matches belonging to the **Champions League** where the match status is **Available**.

```sql
SELECT match_id, fixture, base_ticket_price
FROM Matches
WHERE tournament_category = 'Champions League'
  AND match_status = 'Available';
```

| match_id | fixture | base_ticket_price |
|---|---|---|
| 101 | Real Madrid vs Barcelona | 150 |
| 103 | Bayern Munich vs PSG | 130 |

---

### Query 2 — Search Users by Name
Search for all users whose full names **start with 'Tanvir'** or **contain 'Haque'** (case-insensitive).

**Concepts used:** `LIKE`, `ILIKE`

```sql
SELECT user_id, full_name, email
FROM Users
WHERE full_name ILIKE 'Tanvir%' OR full_name ILIKE '%Haque%';
```

| user_id | full_name | email |
|---|---|---|
| 1 | Tanvir Rahman | tanvir@mail.com |
| 2 | Asif Haque | asif@mail.com |

---

### Query 3 — Bookings With Missing Payment Status
Retrieve all booking records where the payment status is missing (`NULL`), replacing the empty result with **'Action Required'**.

**Concepts used:** `IS NULL`, `COALESCE`

```sql
SELECT booking_id, user_id, match_id,
       COALESCE(payment_status, 'Action Required') AS systematic_status
FROM Bookings
WHERE payment_status IS NULL;
```

| booking_id | user_id | match_id | systematic_status |
|---|---|---|---|
| 504 | 2 | 101 | Action Required |

---

### Query 4 — Booking Details with User & Match Info
Retrieve match booking details along with the **user's full name** and the **scheduled match fixture**.

**Concepts used:** `INNER JOIN`

```sql
SELECT booking_id, full_name, fixture, total_cost
FROM Bookings b
INNER JOIN Matches m ON b.match_id = m.match_id
INNER JOIN Users u ON b.user_id = u.user_id;
```

| booking_id | full_name | fixture | total_cost |
|---|---|---|---|
| 501 | Tanvir Rahman | Real Madrid vs Barcelona | 150 |
| 502 | Tanvir Rahman | Man City vs Liverpool | 120 |
| 503 | Asif Haque | Real Madrid vs Barcelona | 150 |
| 504 | Asif Haque | Real Madrid vs Barcelona | 150 |
| 505 | Sajjad Rahman | Man City vs Liverpool | 120 |

---

### Query 5 — All Users, Including Those With No Bookings
Display a comprehensive list of all users and their booking IDs, ensuring that fans who have **never bought a ticket** are still listed.

**Concepts used:** `LEFT JOIN` / `FULL JOIN`

```sql
SELECT user_id, full_name, booking_id
FROM Users
LEFT JOIN Bookings USING(user_id);
```

| user_id | full_name | booking_id |
|---|---|---|
| 1 | Tanvir Rahman | 501 |
| 1 | Tanvir Rahman | 502 |
| 2 | Asif Haque | 503 |
| 2 | Asif Haque | 504 |
| 3 | Sajjad Rahman | 505 |
| 4 | Jannat Ara | NULL |

---

### Query 6 — Bookings Above Average Cost
Find all ticket bookings where the **total cost** is strictly higher than the **average cost** of all ticket bookings.

**Concepts used:** Subquery, `AVG()`

```sql
SELECT booking_id, match_id, total_cost
FROM Bookings
WHERE total_cost > (SELECT AVG(total_cost) FROM Bookings);
```

| booking_id | match_id | total_cost |
|---|---|---|
| 501 | 101 | 150 |
| 503 | 101 | 150 |
| 504 | 101 | 150 |

---

### Query 7 — Second and Third Most Expensive Matches
Retrieve the top 2 most expensive matches sorted by base ticket price, **skipping** the absolute highest premium match.

**Concepts used:** `ORDER BY`, `LIMIT`, `OFFSET`

```sql
SELECT match_id, fixture, base_ticket_price
FROM Matches
ORDER BY base_ticket_price DESC
LIMIT 2 OFFSET 1;
```

*(Skips Real Madrid vs Barcelona at 150)*

| match_id | fixture | base_ticket_price |
|---|---|---|
| 103 | Bayern Munich vs PSG | 130 |
| 102 | Man City vs Liverpool | 120 |

---

## 🚀 How to Run

1. Set up a PostgreSQL database with the `Users`, `Matches`, and `Bookings` tables.
2. Open [`QUERY.sql`](./QUERY.sql) in your preferred SQL client (psql, DBeaver, pgAdmin, etc.).
3. Execute each query individually to see the results above.

---

## 🛠️ Tech Stack

| Tool | Purpose |
|---|---|
| PostgreSQL | Database engine |
| SQL | Query language |

---

## 👤 Author

**Tamim Khan**
- GitHub: [TamimKhan-dev](https://github.com/TamimKhan-dev)
- LinkedIn: [tamimkhan-dev](https://linkedin.com/in/tamimkhan-dev/)