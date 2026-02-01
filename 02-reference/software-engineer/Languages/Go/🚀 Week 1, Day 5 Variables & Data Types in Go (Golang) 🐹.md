---
description: Notes about 🚀 Week 1, Day 5 Variables & Data Types in Go (Golang) 🐹.
---

# Go Variables & Data Types

## Basic Types

## Variables


Now that you’ve mastered Rust variables, let’s explore Go (Golang)! Go is a statically typed, compiled language like Rust but focuses on simplicity and concurrency.

📌 Concept Overview

• Go is statically typed but has type inference (like TypeScript).

• Variables are mutable by default (unlike Rust).

• Constants (const) must be explicitly typed.

  

  

  

🔹 Declaring Variables in Go

  

✅ 1. Using var (Explicit Type)

package main

import "fmt"

  

func main() {

    var name string = "Luis"

    var age int = 33

    fmt.Println(name, "is", age, "years old.")

}

✔ Explicit type (string, int).

✔ var allows re-assignment (name = "Jorge" works).

  

  

  

✅ 2. Using := (Type Inference)

func main() {

    name := "Luis"  // Type inferred as `string`

    age := 33       // Type inferred as `int`

    fmt.Println(name, "is", age, "years old.")

}

✔ := declares AND assigns (Go figures out the type).

✔ Shorter, but works only inside functions.

  



✅ 3. Constants in Go (const)

const PI float64 = 3.14159  // Explicit type required

✔ Constants are immutable and must have a type.

  

  

  

✅ 4. Data Types in Go

|   |   |   |
|---|---|---|
|Go Type|Description|Example|
|int|Integer|var x int = 42|
|float64|Decimal numbers|var y float64 = 3.14|
|bool|Boolean (true/false)|var isActive bool = true|
|string|Text values|var name string = "Luis"|


🛠 5 Exercises to Practice

✅ Exercise 1: Declare Basic Variables

• Create variables for your name, age, and whether you like Go.

• Print them to the console.

``` go
package main
import “fmt”

func main() {
    var name string = “Luis”
    var age int = 33
    fmt.Println(name, ” is ”, age,” years old.”)
}

```


✅ Exercise 2: Type Inference (:=)
• Use := to declare a variable without specifying a type.
• Print the inferred type using fmt.Printf("%T", variable).
``` go
package main
import “fmt”

func main() {
   let c := 394.78
   fmt.Printf(“%T”, c)
}
```


✅ Exercise 3: Constants in Go

• Declare a constant for the speed of light (299,792,458 m/s).
• Print it to the console.

``` go
package main
import “fmt”

func main() {
    const speedOfLight float64 = 299,792,458
    fmt.Println(“%T”, speedOfLight)
}
```

✅ Exercise 4: Convert an int to float64

## Additional Notes

• Declare an integer.
• Convert it to float64 and print it.

``` go
package main
import “fmt”

func main() {
    var c int = 4
    var d in float64 = float64(c)
    fmt.Println(“c is ”, c)
    fmt.Println(“d is “, d)
}
```
  

✅ Exercise 5: Function with Parameters & Return Value

• Write a function yearsUntil100(age int) int that:
• Takes an integer age as input.
• Returns how many years until 100.
• Call the function and print the result.

``` go
package main
import “fmt”

func yearsUntil100(age int) -> int {
    100 - age
}

func main() {
    fmt.Println(“You will turn 100 in year”, yearsUntil100(33))
}
```

  

  

📩 Submit Your Work

  

Once you complete the exercises, send me your solutions! I’ll review for correctness, readability, and efficiency.

  

🚀 Ready? Start coding! 🐹