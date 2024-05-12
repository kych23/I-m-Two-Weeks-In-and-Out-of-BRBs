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
        print_endline message
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
          print_endline "Login successful!";
          manage_transactions username
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
      manage_transactions username
  | _ -> print_endline "Invalid option selected."

let () = start ()
