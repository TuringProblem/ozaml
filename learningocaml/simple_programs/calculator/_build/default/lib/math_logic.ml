(*
  Author: @Override
  Since: 11052025
  See: <a href="https://github.com/TuringProblem">Github Profile</a>
*)

(*Operations*)
let add (x: int) (y: int) = x + y
let sub (x: int) (y: int) = x - y
let mult (x: int) (y: int) = x * y
let divide (x: int) (y: int) = if y == 0 then failwith "Not divisible by 0" else x / y


let calculate (x: int) (y: int) (op: string): int =
  match op with
    | "add" -> add x y
    | "subtract" -> sub x y
    | "multiply" -> mult x y
    | "divide" -> divide x y
    | _ -> failwith "Please enter an operation"

