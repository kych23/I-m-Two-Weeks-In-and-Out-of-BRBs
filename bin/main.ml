(* @author Khoa Nguyen (ktn9) Kyle Chu (kgc42) Vail Chen (vac68)*)
open Cs3110_final_project.Account
open Cs3110_final_project.Transactions
open Cs3110_final_project.Math

(** ASCII art for the welcome message *)
let print_welcome_art () =
  let art =
    "\n\
    \ _  _  ____  __     ___  __   _  _  ____    ____  __     ____  ____  \
     ____  _ ____    ____   __   _  _  __  __ _   ___  ____ \n\
     / )( \\(  __)(  )   / __)/  \\ ( \\/ )(  __)  (_  _)/  \\   (  _ \\(  _ \
     \\(  _ \\(// ___)  / ___) / _\\ / )( \\(  )(  ( \\ / __)/ ___)\n\
     / \\/ \\ ) _) / (_/\\( (__(  O )/ \\/ \\ ) _)     )( (  O )   ) _ ( )   / \
     ) _ (  \\___ \\  \\___ \\/    \\\\ \\/ / )( /    /( (_ \\___ \\\n\
     (_/\\_)(____)\\____/ \\___)\\__/ \\_)(_/(____)   (__) \\__/   \
     (____/(__\\_)(____/  (____/  (____/\\_/\\_/ \\__/ (__)_)__) \\___/(____/\n"
  in
  print_endline art

(** ASCII art for goodbye message *)
let print_goodbye_art () =
  let art =
    "\n\
    \    ___   __    __  ____  ____  _  _  ____ \n\
    \   / __) /  \\  /  \\(    \\(  _ \\( \\/ )(  __)\n\
    \  / (_ \\(  O )(  O )) D ( ) _ ( )  /  ) _) \n\
    \   \\___/ \\__/  \\__/(____/(____/(__/  (____)\n\
    \  "
  in
  print_endline art

(** ASCII art for the menu *)
let print_menu_art () =
  let art =
    "\n\
    \ _  _   __   __  __ _    _  _  ____  __ _  _  _ \n\
     ( \\/ ) / _\\ (  )(  ( \\  ( \\/ )(  __)(  ( \\/ )( \\\n\
     / \\/ \\/    \\ )( /    /  / \\/ \\ ) _) /    /) \\/ (\n\
     \\_)(_/_/\\_/(__)\\_)__)  \\_)(_/(____)\\_)__\\____/\n"
  in
  print_endline art

(** ASCII art for the manage account *)
let manage_account_art () =
  let art =
    "\n\
    \ _  _   __   __ _   __    ___  ____     __    ___  ___  __   _  _  __ _  \
     ____ \n\
     ( \\/ ) / _\\ (  ( \\ / _\\  / __)(  __)   / _\\  / __)/ __)/  \\ / )( \
     \\(  ( \\(_  _)\n\
     / \\/ \\/    \\/    //    \\( (_ \\ ) _)   /    \\( (__( (__(  O )) \\/ \
     (/    /  )(  \n\
     \\_)(_/_/\\_/\\_)__)/_\\_/\\_/ \\___/(____)  \\_/\\_/ \\___)\\___)\\__/ \
     \\____/\\_)__) (__) \n"
  in
  print_endline art

(** ASCII art for manage transactions *)
let manage_transactions_art () =
  let art =
    "\n\
    \ _  _   __   __ _   __    ___  ____    ____  ____   __   __ _  ____   \
     __    ___  ____  __  __   __ _  ____ \n\
     ( \\/ ) / _\\ (  ( \\ / _\\  / __)(  __)  (_  _)(  _ \\ / _\\ (  ( \\/ \
     ___) / _\\  / __)(_  _)(  )/  \\ (  ( \\/ ___)\n\
     / \\/ \\/    \\/    //    \\( (_ \\ ) _)     )(   )   //    \\/    /\\___ \
     \\/    \\( (__   )(   )((  O )/    /\\___ \\\n\
     \\_)(_/_/\\_/\\_)__)/_\\_/\\_/ \\___/(____)   (__) \
     (__\\_)\\_\\_/\\_)__)(____/\\_\\_/ \\___) (__) (__)/\\__/ \\_)__)(____/\n"
  in
  print_endline art

(** ASCII art for the spend analyzer *)
let spend_analyzer_art () =
  let art =
    "\n\
    \ ____  ____  ____  __ _  ____     __   __ _   __   __    _  _  ____  \
     ____  ____ \n\
     / ___)(  _ \\(  __)(  ( \\(    \\   / _\\ (  ( \\ / _\\ (  )  ( \\/ )(__  \
     )(  __)(  _ \\\n\
     \\___ \\ ) __/ ) _) /    / ) D (  /    \\/    //    \\/ (_/\\ )  /  / _/  \
     ) _)  )   /\n\
     (____/(__)  (____)\\_)__)(____/  \\_/\\_/\\_)__)\\_/\\_/\\____/(__/  \
     (____)(____)(__\\_)\n"
  in
  print_endline art

(** ASCII art for the current balance *)
let current_balance_art () =
  let art =
    "\n\
    \  ___  _  _  ____  ____  ____  __ _  ____    ____   __   __     __   __ \
     _   ___  ____ \n\
    \ / __)/ )( \\(  _ \\(  _ \\(  __)(  ( \\(_  _)  (  _ \\ / _\\ (  )   / \
     _\\ (  ( \\ / __)(  __)\n\
     ( (__ ) \\/ ( )   / )   / ) _) /    /  )(     ) _ (/    \\/ (_/\\/    \
     \\/    /( (__  ) _) \n\
    \ \\___)\\____/(__\\_(__\\_)(____)\\_)__) (__)   \
     (____/\\_/\\_/\\____/\\_/\\_/\\_)__) \\___)(____)\n"
  in
  print_endline art

(** ASCII art for days until broke *)
let days_until_broke_art () =
  let art =
    "\n\
    \  ____   __   _  _  ____    _  _  __ _  ____  __  __      ____  ____   \
     __  __ _  ____ \n\
    \ (    \\ / _\\ ( \\/ )/ ___)  / )( \\(  ( \\(_  _)(  )(  )    (  _ \\(  _ \
     \\ /  \\(  / )(  __)\n\
    \  ) D (/    \\ )  / \\___ \\  ) \\/ (/    /  )(   )( / (_/\\   ) _ ( )   \
     /(  O ))  (  ) _) \n\
    \ (____/\\_/\\_/(__/  (____/  \\____/\\_)__) (__) (__/\\____/  \
     (____/(__\\_) \\__/(__\\_)(____)\n\
    \ "
  in
  print_endline art

let transactions_art () =
  let art =
    "\n\
    \ ____  ____   __   __ _  ____   __    ___  ____  __  __   __ _  ____ \n\
     (_  _)(  _ \\ / _\\ (  ( \\/ ___) / _\\  / __)(_  _)(  )/  \\ (  ( \\/ ___)\n\
    \  )(   )   //    \\/    /\\___ \\/    \\( (__   )(   )((  O )/    /\\___ \\\n\
    \ (__) (__\\_)\\_/\\_/\\_)__)(____/\\_/\\_/ \\___) (__) (__)/\\__/ \
     \\_)__)(____/\n"
  in
  print_endline art

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
    | "1" ->
        print_endline "Enter the date (e.g., YYYY-MM-DD):";
        let date = read_line () in
        print_endline "Enter the amount ($$.¢¢):";
        let amount = read_float () in
        if
          amount
          > get_acc_bal (find_account username (load_accounts "data/users.csv"))
        then begin
          print_endline "You do not have enough funds for this transaction";
          options ()
        end
        else ();
        print_endline "Enter the category:";
        let category = read_line () in
        let new_transaction = create_transaction date amount category in
        (try
           transactions := add_transaction new_transaction !transactions;
           let new_transaction_amount = amount in
           (* find a way to get the account list fr3om the csv file *)
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
           print_endline "Transaction added successfully.";
           print_endline ""
         with Failure msg -> print_endline ("Error: " ^ msg));
        save_transactions (user_filepath username) !transactions;
        options ()
    | "2" -> begin
        transactions_art ();
        let () = view_transactions !transactions in
        options ()
      end
    | "3" -> begin
        current_balance_art ();
        let acc_list = ref (load_accounts "data/users.csv") in
        let acc = find_account username !acc_list in
        let balance = acc.balance in
        let string_balance = string_of_float !balance in
        let message = "Your current balance is " ^ string_balance in
        print_endline message;
        print_endline "";
        options ()
      end
    | "4" -> begin
        save_transactions (user_filepath username) !transactions;
        print_endline "Back to main menu";
        print_endline ""
      end
    | _ ->
        print_endline "Invalid choice, please enter 1, 2, or 3.";
        print_endline "";
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
        save_accounts "data/users.csv" !acc_list;
        print_endline "Funds added successfully";
        print_endline ""
      end
    | "2" -> begin
        print_endline "What do you want your new username to be?";
        let new_name = read_line () in
        let acc_list = ref (load_accounts "data/users.csv") in
        let acc = find_account username !acc_list in
        let acc_new_name = change_username acc new_name in
        acc_list := delete_account (get_acc_username acc) !acc_list;
        acc_list := add_account acc_new_name !acc_list;
        save_accounts "data/users.csv" !acc_list;
        rename_transaction_file username new_name;
        print_endline "Username has now changed! Log out to save your changes!";
        print_endline ""
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
        save_accounts "data/users.csv" !acc_list;
        print_endline "Back to main menu";
        print_endline ""
      end
    | _ -> begin
        print_endline "Invalid choice, please enter 1, 2, 3 or 4.";
        print_endline "";
        options ()
      end
  in
  options ()

(** this currently is not working as intended but as a starter it does call some
    functions in math. *)
let rec spend_analyzer username =
  let options () =
    print_endline "Welcome to your spending analysis";
    print_endline "Here are some insights that you can view:";
    print_endline "1: Days until broke at the rate of spending";
    print_endline "2: Average BRBs spent";
    print_endline "3: Choose a random vender or item";
    print_endline "4: Let us decide if your purchase is wise";
    print_endline "5: Optimize future spending";
    print_endline
      "6: Calculate data and predictions based off categorical spending";
    print_endline "7: Calculate how many BRBs are needed to support your habits";
    print_endline "8: Analyze whether your spending is consistent";
    print_endline "9: Calculate how much money you will have remaining";
    let acc_list = load_accounts "data/users.csv" in
    let acc = find_account username acc_list in
    let acc_balance = get_acc_bal acc in
    let choice = read_line () in
    match choice with
    | "1" -> begin
        days_until_broke_art ();
        print_endline "How many BRB's did you start out with?";
        let start = read_line () in
        let res = days_until_broke (float_of_string start) acc_balance 5.0 in
        let message = string_of_float res ^ " days left" in
        print_endline message
      end
    | "2" -> begin
        print_endline
          "Would you like to know the average BRBs spent by transaction or by \
           day? Enter 'total' or 'days'";
        let choice = read_line () in
        match choice with
        | "total" -> begin
            let full_transactions =
              get_txn_amounts (load_transactions (user_filepath username))
            in
            let message =
              "You spend on average "
              ^ string_of_float (average_list full_transactions)
              ^ " BRBs Per transaction."
            in
            print_endline message
          end
        | "days" -> begin
            print_endline "How many days have passed? (Float Please)";
            let days_passed = read_line () in
            let full_transactions =
              get_txn_amounts (load_transactions (user_filepath username))
            in
            print_endline
              ("You spend on average "
              ^ string_of_float
                  (average_over_days_list full_transactions
                     (float_of_string days_passed))
              ^ " BRBs per day.")
          end
        | _ -> begin
            print_endline "Invalid Choice";
            print_endline "";
            spend_analyzer username
          end
      end
    | "3" -> begin
        print_endline
          "Would you like to choose a random vender (1) or a random item (2)";
        let choice = read_line () in
        match choice with
        | "1" -> begin
            let vender = get_brb_spot () in
            print_endline ("You should go to " ^ vender)
          end
        | "2" -> begin
            let item = get_brb_item () in
            print_endline ("You should get " ^ item)
          end
        | _ -> begin
            print_endline "Invalid Choice";
            print_endline "";
            spend_analyzer username
          end
      end
    | "4" -> begin
        print_endline
          "Would you like to make a decision in a vaccuum (1) or relative to \
           your balance (2)?";
        let choice = read_line () in
        match choice with
        | "1" -> begin
            print_endline
              "From 0 to 100 inclusive, how badly do you want this item? (No \
               decimals please)";
            let choice = read_line () in
            print_endline
              ("Our randomizer on if you should buy this item: "
              ^ string_of_bool (desirability (int_of_string choice)))
          end
        | "2" -> begin
            print_endline
              "From 0 to 100 inclusive, how badly do you want this item? (No \
               decimals please)";
            let desire = read_line () in
            print_endline
              "How much does this item cost? Please put in decimal form.";
            let price = read_line () in
            print_endline
              ("Our randomizer on if you should buy this item: "
              ^ string_of_bool
                  (desire_relative acc_balance (float_of_string price)
                     (int_of_string desire)))
          end
        | _ -> begin
            print_endline "Invalid Choice";
            print_endline "";
            spend_analyzer username
          end
      end
    | "5" -> begin
        print_endline
          "How many days are remaining where you can use BRBs? (Give an \
           integer please)";
        let days_remaining = read_line () in
        let spend_rate =
          optimize_future_spending acc_balance (float_of_string days_remaining)
        in
        print_endline
          ("You can spend " ^ string_of_float spend_rate ^ "over the next "
         ^ days_remaining ^ "days")
      end
    | "6" -> begin
        print_endline "What category would you like to calculate?";
        let category = read_line () in
        let total_spent =
          sum_transactions (load_transactions (user_filepath username))
        in
        let category_spent =
          sum_transactions
            (filter_transactions_by_category
               (load_transactions (user_filepath username))
               category)
        in
        let percentage =
          calculate_percentages_category total_spent category_spent
        in
        print_endline
          (string_of_float percentage ^ "% of your transactions are spent on "
         ^ category);
        print_endline
          "Would you like to know how to allocate your future funds on this \
           category? 'y' or 'n'";
        let secondary = read_line () in
        match secondary with
        | "y" -> begin
            let allocation =
              allocate_by_category total_spent category_spent acc_balance
            in
            print_endline
              ("Based on your current spending, you should allocate "
             ^ string_of_float allocation ^ " BRBs to " ^ category
             ^ " in the future.")
          end
        | _ -> ()
      end
    | "7" -> begin
        print_endline "How many BRBs did you begin with? (Float Please)";
        let starting = read_line () in
        print_endline "How many days have passed? (Float Please)";
        let days_passed = read_line () in
        print_endline "How many days are left? (Float please)";
        let days_remaining = read_line () in
        let brb_needed =
          calculate_money_needed (float_of_string starting) acc_balance
            (float_of_string days_passed)
            (float_of_string days_remaining)
        in
        print_endline
          ("You need " ^ string_of_float brb_needed
         ^ " more BRBs to support your current spending habits.")
      end
    | "8" -> begin
        print_endline "How many BRBs did you begin with? (Float please)";
        let starting = read_line () in
        print_endline "How many days have passed? (Float please!)";
        let days_passed = read_line () in
        print_endline "What day would you like to analyze? (YYYY-MM-DD)";
        let date = read_line () in
        let day_transactions =
          filter_transactions_by_date
            (load_transactions (user_filepath username))
            date date
        in
        let day_amount = sum_transactions day_transactions in
        let was_it_consistent =
          consistent_day (float_of_string starting) acc_balance day_amount
            (float_of_string days_passed)
        in
        print_endline
          ("Our calculator on if you're transactions for day " ^ date
         ^ " were consistent with previous spendings"
          ^ string_of_bool was_it_consistent)
      end
    | "9" -> begin
        print_endline "How many BRBs did you start with? (Float Please)";
        let starting = read_line () in
        print_endline "How many days have passed? (Float Please)";
        let days_passed = read_line () in
        print_endline "How many days are left to spend BRBs? (Float please)";
        let days_remaining = read_line () in
        print_endline
          ("You will have an estimated "
          ^ string_of_float
              (calculate_remaining_money (float_of_string starting) acc_balance
                 (float_of_string days_passed)
                 (float_of_string days_remaining))
          ^ " BRBs remaining based on your current spending habits.")
      end
    | _ -> print_endline "Exit"
  in
  options ()

(** [home username] is the function that leads user [username] to the main menu. *)
let rec home username =
  print_menu_art ();
  print_endline "What would you like to do?";
  print_endline "1. Manage account";
  print_endline "2. Manage transactions";
  print_endline "3. Spend analyzer";
  print_endline "4. Logout";
  let choice = read_line () in
  match choice with
  | "1" -> begin
      manage_account_art ();
      manage_account username;
      home username
    end
  | "2" -> begin
      manage_transactions_art ();
      manage_transactions username;
      home username
    end
  | "3" -> begin
      spend_analyzer_art ();
      spend_analyzer username;
      home username
    end
  | "4" -> print_goodbye_art ()
  | _ -> print_endline "Log in again and choose 1, 2, or 3"

(** [start] starts the program and prompts the user to login/create their
    account *)
let start () =
  print_welcome_art ();
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
