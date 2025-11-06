let rec print_hello (num: int) = 
  match num with
  | 0 -> print_endline "it's 0!"
  | n -> print_endline "Hello, World!"; Printf.printf "%d\n" n; print_hello (n - 1)





let () = 
  let add_five (x: int) = x + 5 in
  let addition = Calculator.Math_logic.add (add_five 0) 5 in
  print_endline ("Addition is " ^ string_of_int addition);



  print_endline ("Please enter whether you'd like to add, subtract, multiply, or divide: ");
  let operation = read_line () in
  print_endline ("Please enter the first number: ");
  let x_val = read_int () in
  print_endline ("Please enter the second number: ");
  let y_val = read_int () in

  let result = Calculator.Math_logic.calculate x_val y_val operation in
  
  print_endline ("Result is " ^ string_of_int result);



  print_hello 5

