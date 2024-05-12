(* @author Khoa Nguyen (ktn9) Kyle Chu (kgc42) Vail Chen (vac68)*)
open Cs3110_final_project.Account
open Cs3110_final_project.Transactions

(** [user_filepath username] returns filename data/[username].csv *)
let user_filepath username = "data/" ^ username ^ ".csv"

(** [manage_transactions] gives the user options to manipulate their
    transactions csv file *)
let manage_transactions username =
  let rec options () =
    let transactions = ref (load_transactions (user_filepath username)) in
    print_endline "What would you like to do?";
    print_endline "1: Add a transaction";
    print_endline "2: View transactions";
    print_endline "3: View balance";
    print_endline "4: Exit and save";
    print_endline "Enter your choice (1-4): ";
    let choice = read_line () in
    match choice with
    | "1" -> begin
        print_endline "Enter the date (e.g., YYYY-MM-DD):";
        let date = read_line () in
        print_endline "Enter the amount ($$.¢¢):";
        let amount = read_float () in
        print_endline "Enter the category:";
        let category = read_line () in
        let new_transaction = create_transaction date amount category in
        (try
           transactions := add_transaction new_transaction !transactions;
           let new_transaction_amount = amount in
           (* find a way to get the account list from the csv file *)
           let acc_list = ref (load_accounts "data/users.csv") in
           let old_acc = find_account username !acc_list in
           let curr_balance = get_acc_bal old_acc in
           let updated_acc =
             create_account
               (curr_balance -. new_transaction_amount)
               username (get_acc_password old_acc)
           in
           acc_list := update_account updated_acc !acc_list;
           save_accounts "data/users.csv" !acc_list;
           print_endline "Transaction added successfully."
         with Failure msg -> print_endline ("Error: " ^ msg));
        save_transactions (user_filepath username) !transactions;
        options ()
      end
    | "2" -> begin
        let () = view_transactions !transactions in
        options ()
      end
    | "3" -> begin
        let acc_list = ref (load_accounts "data/users.csv") in
        let acc = find_account username !acc_list in
        let balance = acc.balance in
        let string_balance = string_of_float !balance in
        let message = "Your current balance is " ^ string_balance in
        print_endline message;
        options ()
      end
    | "4" -> begin
        save_transactions (user_filepath username) !transactions;
        print_endline "Transactions saved and exiting."
      end
    | _ ->
        print_endline "Invalid choice, please enter 1, 2, or 3.";
        options ()
  in
  options ()

let manage_account username =
  let rec options () =
    print_endline "Welcome to account settings";
    print_endline "What would you like to do?";
    print_endline "Enter a choice (1-3)";
    print_endline "1: Manage funds";
    print_endline "2: Change username";
    print_endline "3: Change password";
    print_endline "4. Exit and save";
    let choice = read_line () in
    match choice with
    | "1" -> begin
        print_endline "How much would you like to add to your balance?";
        let extra = read_float () in
        let acc_list = ref (load_accounts "data/users.csv") in
        let acc = find_account username !acc_list in
        let acc_with_new_bal = add_funds acc extra in
        acc_list := update_account acc_with_new_bal !acc_list;
        save_accounts "data/users.csv" !acc_list
      end
    | "2" -> begin
        print_endline "What do you want your new username to be?";
        let new_name = read_line () in
        let acc_list = ref (load_accounts "data/users.csv") in
        let acc = find_account username !acc_list in
        let acc_new_name = change_username acc new_name in
        acc_list := delete_account (get_acc_username acc) !acc_list;
        acc_list := add_account acc_new_name !acc_list;
        save_accounts "data/users.csv" !acc_list
      end
    | "3" -> begin
        print_endline "What do you want your new password to be?";
        let new_pw = read_line () in
        let acc_list = ref (load_accounts "data/users.csv") in
        let acc = find_account username !acc_list in
        let acc_new_pw = change_password acc new_pw in
        acc_list := update_account acc_new_pw !acc_list;
        save_accounts "data/users.csv" !acc_list
      end
    | "4" -> begin
        let acc_list = ref (load_accounts "data/users.csv") in
        save_accounts "data/users.csv" !acc_list
      end
    | _ -> begin
        print_endline "Invalid choice, please enter 1, 2, 3 or 4.";
        options ()
      end
  in
  options ()

let rec home username =
  print_endline "What would you like to do?";
  print_endline "1. Manage account";
  print_endline "2. Manage transactions";
  print_endline "3. Logout";
  let choice = read_line () in
  match choice with
  | "1" ->
      manage_account username;
      home username
  | "2" ->
      manage_transactions username;
      home username
  | "3" -> print_endline "Goodbye"
  | _ -> print_endline "Log in again and choose 1, 2, or 3"

(** [start] starts the program and prompts the user to login/create their
    account *)
let start () =
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
        if account.password <> password then print_endline "Incorrect password."
        else begin
          home username
        end
      with AccountNotFound msg -> print_endline ("Login failed: " ^ msg))
  | "2" ->
      print_endline "Choose a username:";
      let username = read_line () in
      print_endline "Choose a password:";
      let password = read_line () in
      print_endline "How many BRB's do you have ($$.¢¢)";
      let balance = read_line () in
      let accounts = load_accounts "data/users.csv" in
      let new_account =
        create_account (float_of_string balance) username password
      in
      let updated_accounts = add_account new_account accounts in
      save_accounts "data/users.csv" updated_accounts;
      print_endline "Account created successfully.";
      create_new_transaction_file username;
      home username
  | _ -> print_endline "Invalid option selected."

let () = start ()
