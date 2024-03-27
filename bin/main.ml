let rec actions () = 
  print_endline ("Would you like to add funds, deduct funds, or visualize data?");
  let user_input = read_line() in
    if user_input = "add funds" then print_endline("How much would you like to add?")
    else if user_input = "deduct funds" then print_endline("How much would you like to deduct?")
    else if user_input = "visualize data" then print_endline("What would you like to visualize?")
    else begin print_endline("Action not recognized, please try again");
      actions()
    end
(*Opens password prompt for Khoas's account, can be abstracted*)
let khoa () = 
  print_endline ("Please enter your password");
  let user_input = read_line() in
    if user_input = "ktn9" then begin print_endline("Password accepted, hello Khoa");
    actions() 
    end
    else 
      print_endline("User or password is incorrect")
(*Opens password prompt for Kyle's account*)
let kyle () = 
  print_endline ("Please enter your password");
  let user_input = read_line() in
    if user_input = "kgc42" then begin print_endline("Password accepted, hello Kyle");
    actions() 
    end 
    else
      print_endline("User or password is incorrect")
(*Opens password prompt for Vail's account*)
let vail () = 
  print_endline ("Please enter your password");
  let user_input = read_line() in
    if user_input = "vac68" then begin print_endline("Password accepted, hello Vail");
    actions() 
    end
    else
      print_endline("User or password is incorrect")


(*Starts budget app*)
let rec startup () =
  print_endline ("Welcome to Pi r Squared budgeting! Please enter your name");
  let user_input = read_line () in 
    if user_input = "khoa" then khoa ()
    else if user_input = "kyle" then kyle ()
    else if user_input = "vail" then vail ()
    else begin
      print_endline ("User not recognized, please try again");
      startup ()
    end
let () = startup ()