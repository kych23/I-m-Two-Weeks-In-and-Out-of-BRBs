(* @author Khoa Nguyen (ktn9) Kyle Chu (kgc42) Vail Chen (vac68)*)
open Cs3110_final_project.Account
(* open Cs3110_final_project.Transactions *)

(* prompts the user to login/create their account *)
let startup () =
  print_endline "Welcome to the BRB Saving System!";
  print_endline
    "Do you want to (1) Login or (2) Create a new account? Enter 1 or 2:";
  match read_line () with
  | "1" -> (
      print_endline "Enter your username:";
      let username = read_line () in
      print_endline "Enter your password:";
      let password = read_line () in
      let accounts = load_accounts "data/users.csv" in
      try
        let account = find_account username accounts in
        if account.password = password then print_endline "Login successful!"
        else print_endline "Incorrect password."
      with AccountNotFound msg -> print_endline ("Login failed: " ^ msg))
  | "2" ->
      print_endline "Choose a username:";
      let username = read_line () in
      print_endline "Choose a password:";
      let password = read_line () in
      let accounts = load_accounts "data/users.csv" in
      let new_account = create_account username password in
      let updated_accounts = add_account new_account accounts in
      save_accounts "data/users.csv" updated_accounts;
      print_endline "Account created successfully."
  | _ -> print_endline "Invalid option selected."

let () = startup ()
