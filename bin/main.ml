
(*Opens password prompt for Khoas's account, can be abstracted*)
let khoa () = 
  print_endline ("Please enter your password");
  let user_input = read_line() in
    if user_input = "ktn9" then print_endline("Password accepted, hello Khoa") else
      print_endline("User or password is incorrect")
      let () = print_endline "Hello, World!"
(*Opens password prompt for Kyle's account*)
let kyle () = 
  print_endline ("Please enter your password");
  let user_input = read_line() in
    if user_input = "kgc42" then print_endline("Password accepted, hello Kyle") else
      print_endline("User or password is incorrect")
(*Opens password prompt for Vail's account*)
let vail () = 
  print_endline ("Please enter your password");
  let user_input = read_line() in
    if user_input = "vac68" then print_endline("Password accepted, hello Vail") else
      print_endline("User or password is incorrect")
(*Starts budget app*)
let rec startup () =
  print_endline ("Welcome to Pi r Squared budgeting! Please enter your name");
  let user_input = read_line () in 
    if user_input = "khoa" then khoa ()
    else if user_input = "kyle" then kyle ()
    else if user_input = "vail" then vail ()
    else 
      print_endline ("User not recognized, please try again");
      startup ()
let () = startup ()