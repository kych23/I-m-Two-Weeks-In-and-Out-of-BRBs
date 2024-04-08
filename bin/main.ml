(* @author Khoa Nguyen (ktn9) Kyle Chu (kgc42) Vail Chen (vac68)*)
open Cs3110_final_project.Login_db

(*[actions] Opens actions prompt for an account*)
let rec actions () =
  print_endline "Would you like to add funds, deduct funds, or visualize data?";
  let user_input = read_line () in
  if user_input = "add funds" then
    print_endline "How much would you like to add?"
  else if user_input = "deduct funds" then
    print_endline "How much would you like to deduct?"
  else if user_input = "visualize data" then
    print_endline "What would you like to visualize?"
  else (
    print_endline "Action not recognized, please try again";
    actions ())

(*[khoa] Opens password prompt for Khoas's account, can be abstracted*)
let khoa () =
  print_endline "Please enter your password";
  let user_input = read_line () in
  if user_input = "ktn9" then (
    print_endline "Password accepted, hello Khoa";
    actions ())
  else print_endline "User or password is incorrect"

(*[kyle] Opens password prompt for Kyle's account*)
let kyle () =
  print_endline "Please enter your password";
  let user_input = read_line () in
  if user_input = "kgc42" then (
    print_endline "Password accepted, hello Kyle";
    actions ())
  else print_endline "User or password is incorrect"

(*[vail] Opens password prompt for Vail's account*)
let vail () =
  print_endline "Please enter your password";
  let user_input = read_line () in
  if user_input = "vac68" then (
    print_endline "Password accepted, hello Vail";
    actions ())
  else print_endline "User or password is incorrect"

(*[startup] Starts the budget app*)
let rec startup () =
  print_endline "Welcome to Pi r Squared budgeting! Please enter your name";
  let user_input = read_line () in
  if user_input = "khoa" then khoa ()
  else if user_input = "kyle" then kyle ()
  else if user_input = "vail" then vail ()
  else (
    print_endline "User not recognized, please try again";
    startup ())

let () = startup ()

(* WORK IN PROGESS --- ACCOUNT DATABASE MANAGEMENT *)

let () = let user_db = initialize_db () in

         ignore (db_close user_db)

(* ------------------------------------------------ *)
