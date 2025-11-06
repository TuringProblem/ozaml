# OCaml Semantics Cheatsheet

## Reading OCaml Code - Syntax Meanings

### Variable Bindings

| Syntax | Meaning | Example |
|--------|---------|---------|
| `let x = 5` | Bind immutable value | `let age = 25` |
| `let x = 5 in expr` | Local binding in expression | `let temp = x + 1 in temp * 2` |
| `let f x = x + 1` | Function definition | `let double x = x * 2` |
| `let f x y = x + y` | Multi-parameter function (curried) | `let add x y = x + y` |
| `let () = expr` | Execute expression, ignore result | `let () = print_endline "hello"` |

### Function Application

| Syntax | Meaning | Notes |
|--------|---------|-------|
| `f x` | Apply function f to argument x | Space means function application |
| `f x y` | Apply f to x, then result to y | Same as `(f x) y` |
| `f (g x)` | Apply f to result of `g x` | Parentheses for grouping |
| `x |> f` | Pipe x into function f | Same as `f x`, left-to-right |
| `f @@ g x` | Apply f to `g x` | Same as `f (g x)`, avoids parens |

### Pattern Matching

| Syntax | Meaning | Example |
|--------|---------|---------|
| `match expr with` | Pattern match on expression | `match x with` |
| `| pattern -> expr` | Match pattern, execute expr | `| 0 -> "zero"` |
| `| _ -> expr` | Wildcard, matches anything | `| _ -> "other"` |
| `| x when condition -> expr` | Guard condition | `| x when x > 0 -> "positive"` |

### Data Structure Literals

| Syntax | Meaning | Type |
|--------|---------|------|
| `[1; 2; 3]` | List literal | `int list` |
| `[]` | Empty list | `'a list` |
| `[|1; 2; 3|]` | Array literal | `int array` |
| `(1, 2, 3)` | Tuple literal | `int * int * int` |
| `{ field1 = value1; field2 = value2 }` | Record literal | Custom record type |

### Operators and Their Meanings

#### Arithmetic
| Syntax | Meaning | Type |
|--------|---------|------|
| `+` | Integer addition | `int -> int -> int` |
| `+.` | Float addition | `float -> float -> float` |
| `-` | Integer subtraction | `int -> int -> int` |
| `-.` | Float subtraction | `float -> float -> float` |
| `*` | Integer multiplication | `int -> int -> int` |
| `*.` | Float multiplication | `float -> float -> float` |
| `/` | Integer division | `int -> int -> int` |
| `/.` | Float division | `float -> float -> float` |

#### Comparison
| Syntax | Meaning | Notes |
|--------|---------|-------|
| `=` | Structural equality | Works on most types |
| `<>` | Structural inequality | Opposite of `=` |
| `==` | Physical equality | Same memory location |
| `!=` | Physical inequality | Opposite of `==` |
| `<`, `>`, `<=`, `>=` | Ordering comparisons | Works on comparable types |

#### Logical
| Syntax | Meaning | Notes |
|--------|---------|-------|
| `&&` | Logical AND | Short-circuiting |
| `\|\|` | Logical OR | Short-circuiting |
| `not` | Logical NOT | Function, not operator |

#### String/List Operations
| Syntax | Meaning | Example |
|--------|---------|---------|
| `^` | String concatenation | `"hello" ^ " world"` |
| `::` | List cons (prepend) | `1 :: [2; 3]` gives `[1; 2; 3]` |
| `@` | List concatenation | `[1; 2] @ [3; 4]` gives `[1; 2; 3; 4]` |

### Type Annotations

| Syntax | Meaning | Example |
|--------|---------|---------|
| `x : int` | Variable x has type int | `let (x : int) = 5` |
| `'a` | Type parameter (generic) | `'a list` means "list of any type" |
| `->` | Function type | `int -> string` means function from int to string |
| `*` | Tuple type | `int * string` is pair of int and string |

### Module System

| Syntax | Meaning | Example |
|--------|---------|---------|
| `Module.function` | Access function from module | `List.map`, `String.length` |
| `Module.Type.constructor` | Access type constructor | `Map.Make(String)` |
| `open Module` | Import all names from module | `open List` then use `map` directly |

### Mutable References

| Syntax | Meaning | Example |
|--------|---------|---------|
| `ref value` | Create mutable reference | `let x = ref 5` |
| `!x` | Dereference (get value) | `let y = !x` |
| `x := value` | Assignment (set value) | `x := 10` |

### Common Function Patterns

| Pattern | Meaning | Example |
|---------|---------|---------|
| `fun x -> expr` | Anonymous function | `fun x -> x * 2` |
| `function | pattern -> expr` | Anonymous function with pattern matching | `function | [] -> 0 | _ -> 1` |
| `let rec f x = ...` | Recursive function | `let rec factorial n = if n = 0 then 1 else n * factorial (n-1)` |

### Conditional Expressions

| Syntax | Meaning | Notes |
|--------|---------|-------|
| `if condition then expr1 else expr2` | Conditional expression | Must have both then and else |
| `if condition then expr` | Unit-returning conditional | Same as `if condition then expr else ()` |

### Special Syntax

| Syntax | Meaning | Example |
|--------|---------|---------|
| `()` | Unit value (like void) | `print_endline "hello"` returns `()` |
| `;` | Sequence operator | `expr1; expr2` - do expr1, then expr2 |
| `;;` | Top-level separator | Used in REPL, not needed in files |

## Reading Complex Expressions

### Precedence (High to Low)
1. Function application: `f x y`
2. Unary operators: `not`, `!`
3. Multiplicative: `*`, `/`, `*.`, `/.`
4. Additive: `+`, `-`, `+.`, `-.`
5. List cons: `::`
6. Comparisons: `=`, `<>`, `<`, `>`, etc.
7. Logical AND: `&&`
8. Logical OR: `||`
9. Pipe: `|>`

### Reading Left-to-Right with Pipes
```ocaml
[1; 2; 3; 4]
|> List.map (fun x -> x * 2)
|> List.filter (fun x -> x > 4)
|> List.fold_left (+) 0
```
Reads as: "Take list [1;2;3;4], map doubling over it, filter elements > 4, then sum them"

### Reading Function Types
- `int -> string` : function that takes int, returns string
- `int -> int -> int` : function that takes int, returns function that takes int and returns int (curried)
- `(int * int) -> int` : function that takes tuple of two ints, returns int
- `'a -> 'a` : polymorphic function that takes any type and returns same type

### Reading Pattern Matches
```ocaml
match x with
| [] -> "empty list"
| [single] -> "one element: " ^ string_of_int single
| first :: rest -> "first is " ^ string_of_int first
```
Reads as: "If x is empty list, return 'empty list'. If x is single-element list, return message with that element. If x has multiple elements, return message with first element."

### Reading Type Definitions
```ocaml
type 'a binary_tree = 
  | Leaf 
  | Node of 'a * 'a binary_tree * 'a binary_tree
```
Reads as: "A binary tree of type 'a is either a Leaf (no data) or a Node containing data of type 'a and two subtrees"

### Common Idioms to Recognize

| When you see... | It means... |
|-----------------|-------------|
| `function \| ...` | Anonymous function with pattern matching |
| `let ... in ...` | Local binding |
| `... \|> ...` | Data flowing through transformations |
| `Some x` / `None` | Optional value (nullable equivalent) |
| `Ok x` / `Error msg` | Result of operation that might fail |
| `x :: xs` | List with head x and tail xs |
| `match ... with` | Checking different cases of data |
| `let rec ...` | Recursive function definition |
| `'a`, `'b` | Generic type parameters |