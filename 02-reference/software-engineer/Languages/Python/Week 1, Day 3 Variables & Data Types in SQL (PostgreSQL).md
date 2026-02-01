---
tags: ["SQL", "data-types", "postgreSQL", "variables", "week1/Day3"]
---
tags: #variables #data-types #SQL #postgreSQL #week1/Day3
### **🚀 Week 1, Day 3: Variables & Data Types in SQL (PostgreSQL)**

Now that you've mastered **Python & TypeScript variables**, let's explore how SQL handles **data storage & types**. Unlike programming languages, SQL is **declarative**—you describe what you want, and the database executes it.

---
description: React notes and reference about Week 1, Day 3 Variables & Data Types in SQL (PostgreSQL).

## **📌 Concept Overview**

- **SQL (Structured Query Language)** stores and retrieves data in databases.
- Variables in SQL are typically used in **stored procedures, functions, or scripts** rather than in standard queries.
- **PostgreSQL** supports **explicit data types** for strong typing, much like TypeScript.

---

## **🔹 Declaring Variables in SQL (PostgreSQL Syntax)**

### **1️⃣ Simple Variable Declaration (PL/pgSQL)**

PostgreSQL doesn’t have traditional variables in standard queries, but in functions and scripts, you declare them like this:

```sql
DO $$  
DECLARE my_name TEXT := 'Luis';  
BEGIN  
    RAISE NOTICE 'Hello, %', my_name;  
END $$;
```

✔ **`DECLARE my_name TEXT`** → Declares a variable of type `TEXT`.  
✔ **`RAISE NOTICE`** → Prints the value (like `console.log` in TypeScript).

---

### **2️⃣ Data Types in PostgreSQL**

Like TypeScript, SQL requires you to define data types. Common ones:

|SQL Data Type|Description|Example Value|
|---|---|---|
|`INTEGER`|Whole numbers|`33`|
|`TEXT`|String|`'Luis'`|
|`BOOLEAN`|True/false values|`TRUE`|
|`NUMERIC(5,2)`|Decimal numbers|`99.99`|
|`DATE`|Stores dates|`'1992-06-15'`|

---

### **3️⃣ Using Variables in Queries (WITH Clause)**

SQL doesn’t allow direct variables in queries, but we can **simulate them**:

```sql
WITH vars AS (
    SELECT 'Luis'::TEXT AS my_name, 33::INTEGER AS my_age
)
SELECT * FROM vars;
```

✔ **`WITH vars AS (...)`** → Creates a temporary table of variables.  
✔ **`'Luis'::TEXT`** → Type casts `'Luis'` as `TEXT`.  
✔ **`33::INTEGER`** → Type casts `33` as `INTEGER`.

---

### **4️⃣ Assigning Values in Functions (PL/pgSQL)**

If you're writing a function, you declare variables **inside**:

```sql
CREATE FUNCTION get_age(birth_year INTEGER) RETURNS INTEGER AS $$
DECLARE current_year INTEGER := EXTRACT(YEAR FROM NOW());
BEGIN
    RETURN current_year - birth_year;
END;
$$ LANGUAGE plpgsql;
```

✔ **`DECLARE current_year INTEGER`** → Stores the current year.  
✔ **`EXTRACT(YEAR FROM NOW())`** → Retrieves the current year dynamically.  
✔ **`RETURN current_year - birth_year`** → Returns the age.

---

## **🛠 5 Exercises to Practice**

### **✅ Exercise 1: Declare a Variable in a PL/pgSQL Block**

- Declare a variable `fav_color` of type `TEXT`.
- Assign `"Blue"` as its value.
- Print it using `RAISE NOTICE`.

---

### **✅ Exercise 2: Use Variables in a Query**

- Use a `WITH vars AS (...)` block to:
    - Store `"Jorge"` in a variable.
    - Store `29` as an integer.
    - Retrieve these values in a `SELECT` statement.

---

### **✅ Exercise 3: Create a Function to Calculate Age**

- Write a SQL function `calculate_age(birth_year INTEGER)` that:
    - Calculates age using the **current year**.
    - Returns the age as an `INTEGER`.

---

### **✅ Exercise 4: Create a Table & Insert Data**

- Create a table `users` with columns:
    - `id` (auto-increment `SERIAL` key)
    - `name` (`TEXT`)
    - `birth_year` (`INTEGER`)
- Insert **your own data** into it.

---

### **✅ Exercise 5: Query Data Using a Variable**

- Use `WITH vars AS (...)` to filter users born **after 1990**.

---

### **📩 Submit Your Work**

Once you complete the exercises, send me your solutions! I'll review for **correctness, readability, and efficiency**.

🚀 **Ready? Start coding!**