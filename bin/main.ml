let () = print_endline "Hello, World!"
let () =
  print_endline ("What would you like to do?");
  let user_input = read_line () in 
    print_endline(user_input)