---
tags: ["data-types", "typescript", "variables", "week1/Day2"]
---
tags: #typescript #variables #data-types #week1/Day2

Now that you've mastered **Python variables & data types**, let's see how **TypeScript** compares!

---
description: React notes and reference about Week 1, Day 2 Variables & Data Types in TypeScript.

## **📌 Concept Overview**

TypeScript is a **statically typed** language, meaning you must declare variable types. Unlike Python, TypeScript enforces **type safety at compile time**, reducing runtime errors.

### **🔹 Declaring Variables in TypeScript**

#### **1️⃣ Basic Variable Declaration**

TypeScript variables use **`let`**, **`const`**, and **`var`** (though `var` is outdated).

```typescript
let name: string = "Luis";  // Explicit type declaration
const age: number = 33;  // `const` for values that don’t change
let isDeveloper: boolean = true;
```

🔹 **Key Differences from Python:**

- **Type must be explicitly declared** (`name: string` instead of `name = "Luis"`).
- **`const` prevents reassignment**, similar to Python's convention of using uppercase (`PI = 3.14`).

---

#### **2️⃣ Type Inference (Let TypeScript Infer Types Automatically)**

TypeScript can infer types without explicit annotations.

```typescript
let city = "New York";  // TypeScript infers `string`
let score = 95;         // TypeScript infers `number`
```

🔹 **Best Practice:** Use type annotations when function parameters or complex data structures are involved.

---

#### **3️⃣ Multiple Assignments**

```typescript
let firstName: string = "Luis", lastName: string = "Doe", age: number = 33;
console.log(firstName, lastName, age);
```

---

#### **4️⃣ Arrays & Tuples**

```typescript
let favoriteFoods: string[] = ["Pizza", "Tacos", "Wings"];  // String array
let person: [string, number] = ["Alice", 25];  // Tuple with fixed types
```

🔹 **Key Difference from Python:**

- TypeScript enforces a **single type per array** (`string[]`), unlike Python lists, which can mix types.

---

#### **5️⃣ Objects & Interfaces**

```typescript
let user: { name: string; age: number } = {
  name: "Luis",
  age: 33,
};
```

🔹 **In Python**, we use dictionaries (`dict`) instead of interfaces.

---

## **🛠 5 Exercises to Practice**

### **✅ Exercise 1: Declare Basic Variables**

- Create variables for your **name, age, and whether you like coding**.
- Print them to the console.

### **✅ Exercise 2: Type Inference & Reassignment**

- Declare a variable `x = 10`.
- Try to change `x` to a string (`x = "hello"`).
- See what error TypeScript gives you.

### **✅ Exercise 3: Arrays & Tuples**

- Create an array of your **top 3 favorite programming languages**.
- Create a tuple for a **user profile (name, age, isDeveloper)**.
- Print both.

### **✅ Exercise 4: Object Type**

- Create an object with **your name, age, and favorite language**.
- Print the object.

### **✅ Exercise 5: Open-Ended Challenge**

Write a small **TypeScript function** that takes a user's birth year and returns their **age**.

---

### **💡 Go Further (Optional Challenges)**

- Convert user input to different types.
- Experiment with TypeScript’s **`enum`** for predefined values.
- Use **interfaces** to define a structured user type.

---

### **✅ Exercise 1 Review**

✔ **Great use of string interpolation (``${}`)** ✔ **Ternary operator (`? :`)** for a conditional message is a nice touch!

🔧 **Minor Fix:** Add a period (`.`) for readability in the console message.

```typescript
console.log(`${name} here is ${age} years old and ${iLikeCoding ? "loves coding." : "hates coding."}`)
```

✅ **Final Verdict:** **Perfect solution!** ✅

---

### **✅ Exercise 2 Review (Error Handling)**

✔ **Correct observation!** TypeScript **does not allow** changing `x` from `number` to `string`, unlike Python.

🔹 **What You Learned:**

- **Type safety prevents accidental reassignments.**
- If you really need a flexible type, use **`any`** (not recommended unless necessary):
    
    ```typescript
    let x: any = 10;
    x = "hello";  // No error
    ```
    

✅ **Final Verdict:** **Understood the error correctly!** ✅

---

### **✅ Exercise 3 Review (Arrays & Tuples)**

✔ **Defined an array of strings correctly.**  
✔ **Tuple correctly enforces types `[string, number, boolean]`.**  
✔ **Used `console.log()` properly.**

🔧 **Optional Improvement:** Add labels when printing for clarity.

```typescript
console.log("Favorite Languages:", favoriteProgrammingLang);
console.log("User Profile:", userProfile);
```

✅ **Final Verdict:** **Perfect execution!** ✅

---

### **✅ Exercise 4 Review (Objects & Type Annotations)**

✔ **Defined an object with proper type annotations.**  
✔ **Used a structured template (`person: { firstName: string; ... }`).**  
✔ **Great use of string interpolation for a natural console output.**

🔧 **Optional Improvement:** Use `.join(", ")` to format the array better.

```typescript
console.log(`Welcome ${person.firstName}, we've been waiting for your arrival. 
So it says you are ${person.age} years old. Your chart also states that your favorite programming languages are ${person.favoriteProgrammingLang.join(", ")}.`);
```

✅ **Final Verdict:** **Looks great, just improved formatting!** ✅

---

### **🛠 Exercise 5 Review (Function to Calculate Birth Year)**



```typescript
interface UserBirthInfo {
    birthYear: number;
    yearTurning100: number;
}

function getUserBirthYear(year: number): UserBirthInfo {
    return {
        birthYear: year,
        yearTurning100: year + 100  // Simply add 100
    };
}

let louAge = getUserBirthYear(1992);
console.log(`Luis was born in ${louAge.birthYear} and will turn 100 in the year ${louAge.yearTurning100}.`);
```

---

### **🚀 Final Verdict**

✅ **Your 100th birthday is in 2092, not 2059.**  
✅ **Fixed the formula to be much simpler.**  
✅ **Now we can confidently move forward!**

---
