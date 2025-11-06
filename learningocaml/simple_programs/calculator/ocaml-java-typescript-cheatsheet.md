# OCaml for Java/TypeScript Developers

## Basic Syntax Comparison

| Java/TypeScript | OCaml | Notes |
|-----------------|-------|-------|
| `int x = 5;` | `let x = 5` | Immutable by default |
| `String name = "hello";` | `let name = "hello"` | String literals same |
| `final int x = 5;` | `let x = 5` | All `let` bindings immutable |
| `int x = 5; x = 10;` | `let x = ref 5 in x := 10` | Explicit mutability |

## Data Structures

### Objects/Records
```java
// Java
class Person {
    String name;
    int age;
    Person(String name, int age) {
        this.name = name; this.age = age;
    }
}
Person p = new Person("John", 25);
```

```typescript
// TypeScript
interface Person {
    name: string;
    age: number;
}
const p: Person = { name: "John", age: 25 };
```

```ocaml
(* OCaml *)
type person = { name: string; age: int }
let p = { name = "John"; age = 25 }
let name = p.name
```

### Collections

| Java | TypeScript | OCaml |
|------|------------|-------|
| `List<Integer> list = Arrays.asList(1,2,3);` | `const list: number[] = [1,2,3]` | `let list = [1; 2; 3]` |
| `Map<String,Integer> map = new HashMap<>();` | `const map: Record<string,number> = {}` | `module M = Map.Make(String)` |
| `Set<String> set = new HashSet<>();` | `const set: Set<string> = new Set()` | `module S = Set.Make(String)` |

### Enums/Variants

```java
// Java
enum Color { RED, GREEN, BLUE }
// Limited - can't hold data
```

```typescript
// TypeScript
enum Color { Red, Green, Blue }
type Result<T> = { success: true, data: T } | { success: false, error: string }
```

```ocaml
(* OCaml - Much more powerful *)
type color = Red | Green | Blue | RGB of int * int * int
type 'a result = Success of 'a | Error of string
```

## Control Flow

### If/Else
```java
// Java
if (condition) {
    return value1;
} else {
    return value2;
}
```

```ocaml
(* OCaml - everything is an expression *)
if condition then value1 else value2
```

### Switch/Pattern Matching

```java
// Java - limited
switch (day) {
    case MONDAY: return "Start of week"; break;
    case FRIDAY: return "TGIF"; break;
    default: return "Regular day";
}
```

```ocaml
(* OCaml - very powerful *)
match day with
| Monday -> "Start of week"
| Friday -> "TGIF"
| Saturday | Sunday -> "Weekend"
| _ -> "Regular day"

(* Can destructure data *)
match result with
| Success data -> Printf.printf "Got: %s" data
| Error msg -> Printf.printf "Failed: %s" msg
```

## Functions

### Basic Functions
```java
// Java
public static int add(int a, int b) {
    return a + b;
}
```

```typescript
// TypeScript
const add = (a: number, b: number): number => a + b;
```

```ocaml
(* OCaml *)
let add a b = a + b
(* or with explicit types *)
let add (a: int) (b: int) : int = a + b
```

### Higher-Order Functions
```java
// Java
list.stream()
    .map(x -> x * 2)
    .filter(x -> x > 10)
    .collect(toList());
```

```typescript
// TypeScript
list.map(x => x * 2)
    .filter(x => x > 10);
```

```ocaml
(* OCaml *)
list 
|> List.map (fun x -> x * 2)
|> List.filter (fun x -> x > 10)

(* Or with function composition *)
let process = List.map (( * ) 2) >> List.filter (( < ) 10)
```

## Common Patterns

### Null Safety
```java
// Java
String result = getValue();
if (result != null) {
    System.out.println(result.toUpperCase());
}
```

```typescript
// TypeScript
const result = getValue();
if (result !== null && result !== undefined) {
    console.log(result.toUpperCase());
}
```

```ocaml
(* OCaml - Option type eliminates null *)
match get_value () with
| Some result -> print_endline (String.uppercase_ascii result)
| None -> ()
```

### Error Handling
```java
// Java
try {
    String result = riskyOperation();
    return result.toUpperCase();
} catch (Exception e) {
    return "ERROR: " + e.getMessage();
}
```

```ocaml
(* OCaml - Result type *)
match risky_operation () with
| Ok result -> String.uppercase_ascii result
| Error msg -> "ERROR: " ^ msg
```

## Useful OCaml Idioms

### Pipe Operator
```ocaml
(* Instead of nested function calls *)
let result = func3 (func2 (func1 data))

(* Use pipe for readability *)
let result = data |> func1 |> func2 |> func3
```

### Partial Application
```ocaml
let add x y = x + y
let add_five = add 5  (* Partially applied function *)
let result = add_five 3  (* result = 8 *)
```

### Pattern Matching Everything
```ocaml
(* Match on tuples *)
let (x, y) = get_coordinates ()

(* Match on lists *)
match my_list with
| [] -> "empty"
| [single] -> "one element"
| first :: rest -> "multiple elements"

(* Match with guards *)
match score with
| x when x >= 90 -> "A"
| x when x >= 80 -> "B"
| _ -> "Below B"
```

## I/O Comparison

| Java | TypeScript (Node) | OCaml |
|------|------------------|-------|
| `Scanner.nextLine()` | `readline.question()` | `read_line ()` |
| `Scanner.nextInt()` | `parseInt(readline.question())` | `read_int ()` |
| `System.out.println()` | `console.log()` | `print_endline` |
| `System.out.printf()` | `console.log(\`template\`)` | `Printf.printf` |

## Key Differences to Remember

1. **Immutability by default** - Use `ref` for mutable variables
2. **Everything is an expression** - No statements, everything returns a value
3. **Pattern matching is king** - Use it instead of if/else chains
4. **Type inference** - You rarely need to write types explicitly
5. **Currying** - Functions take one argument at a time by default
6. **No null** - Use `option` type instead
7. **No exceptions for control flow** - Use `result` type for error handling