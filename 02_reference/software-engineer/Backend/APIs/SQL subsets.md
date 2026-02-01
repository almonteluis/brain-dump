---
tags: ["SQL", "subsets"]
---
tags: #SQL #subsets
SQL (Structured Query Language) is divided into subsets based on their specific functions. These subsets help organize the language's operations and clarify their use cases. Below is a breakdown of the primary SQL subsets, their commands, and practical applications:

---
description: React notes and reference about SQL subsets.

### 1. **DDL (Data Definition Language)**  
**Purpose**: Defines/modifies database structures (schema).  
**Commands**:  
- `CREATE`: Build databases, tables, indexes, or views.  
- `ALTER`: Modify existing structures (e.g., add/drop columns).  
- `DROP`: Delete databases, tables, or views.  
- `TRUNCATE`: Remove all records from a table (retains structure).  
- `RENAME`: Rename database objects.  

**Use Cases**:  
- Designing a new database schema during application setup.  
- Adding a column to a table to store profile pictures.  
- Dropping obsolete tables during a system upgrade.  

**Example**:  
```sql
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username VARCHAR(50),
    Email VARCHAR(100)
);
```

---

### 2. **DML (Data Manipulation Language)**  
**Purpose**: Manages data within existing structures (CRUD operations, excluding read).  
**Commands**:  
- `INSERT`: Add new records.  
- `UPDATE`: Modify existing records.  
- `DELETE`: Remove records.  
- `MERGE`: Upsert data (insert or update).  

**Use Cases**:  
- Adding a new product to an e-commerce catalog.  
- Updating a user’s password after a reset.  
- Deleting inactive accounts.  

**Example**:  
```sql
UPDATE Employees 
SET Salary = Salary * 1.05 
WHERE Department = 'Engineering';
```

---

### 3. **DQL (Data Query Language)**  
**Purpose**: Retrieves data from the database.  
**Command**:  
- `SELECT`: Fetch data (often with filters, joins, or aggregations).  

**Use Cases**:  
- Generating sales reports for the last quarter.  
- Displaying search results on a website.  
- Extracting data for machine learning models.  

**Example**:  
```sql
SELECT ProductName, SUM(Quantity) AS TotalSales
FROM Orders
GROUP BY ProductName
ORDER BY TotalSales DESC;
```

---

### 4. **DCL (Data Control Language)**  
**Purpose**: Manages permissions and access control.  
**Commands**:  
- `GRANT`: Allow users/roles specific privileges (e.g., read/write).  
- `REVOKE`: Remove privileges.  

**Use Cases**:  
- Granting read-only access to analytics teams.  
- Revoking write access from a contractor after project completion.  
- Restricting sensitive tables to administrators.  

**Example**:  
```sql
GRANT SELECT, INSERT ON Orders TO SalesTeam;
```

---

### 5. **TCL (Transaction Control Language)**  
**Purpose**: Ensures data integrity by managing transactions (ACID properties).  
**Commands**:  
- `COMMIT`: Save changes permanently.  
- `ROLLBACK`: Undo changes in case of errors.  
- `SAVEPOINT`: Set a checkpoint within a transaction.  

**Use Cases**:  
- Processing payments (e.g., deducting funds and crediting a merchant atomically).  
- Rolling back a bulk import if errors occur.  
- Managing multi-step workflows (e.g., order fulfillment).  

**Example**:  
```sql
BEGIN TRANSACTION;
UPDATE Accounts SET Balance = Balance - 100 WHERE AccountID = 123;
UPDATE Accounts SET Balance = Balance + 100 WHERE AccountID = 456;
COMMIT;
```

---

### Summary Table
| Subset | Purpose                     | Key Commands                | Use Case Example                     |
|--------|-----------------------------|-----------------------------|---------------------------------------|
| DDL    | Define schema               | CREATE, ALTER, DROP         | Creating a table for user data        |
| DML    | Modify data                 | INSERT, UPDATE, DELETE      | Adding a new customer record          |
| DQL    | Retrieve data               | SELECT                      | Generating a monthly sales report     |
| DCL    | Manage access               | GRANT, REVOKE               | Restricting access to sensitive data  |
| TCL    | Control transactions        | COMMIT, ROLLBACK            | Ensuring payment consistency          |

By understanding these subsets, developers and database administrators can effectively design, secure, and interact with databases while maintaining data integrity and performance.