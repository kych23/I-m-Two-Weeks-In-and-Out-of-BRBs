open OUnit2
open Cs3110_final_project.Account
open Cs3110_final_project.Transactions
open Cs3110_final_project.Math

(* Function to delete a file *)
let delete_csv_file file_path =
  try
    Sys.remove file_path;
    (* Attempts to remove the file *)
    true (* Returns true if successful *)
  with Sys_error msg ->
    (* Catches system errors, e.g., file not found *)
    Printf.eprintf "Failed to delete the file: %s\n" msg;
    false (* Returns false if an error occurs *)

let ensure_directory_exists path =
  if not (Sys.file_exists path) then Unix.mkdir path 0o755

(* function to create a new empty csv file *)
let create_empty_csv path filename =
  ensure_directory_exists path;
  let full_path = Filename.concat path filename in
  let channel = open_out full_path in
  close_out channel;
  full_path

let test_account =
  [
    (* ------------------------ TESTS create_account ------------------------ *)
    ( "create_account : checking username" >:: fun _ ->
      let acc = create_account 1.0 "khoa" "ktn9" in
      assert_equal true (acc.username = "khoa") );
    ( "create_account : checking password" >:: fun _ ->
      let acc = create_account 1.0 "khoa" "ktn9" in
      assert_equal true (acc.password = "ktn9") );
    ( "create_account : checking password" >:: fun _ ->
      let acc = create_account 1.0 "khoa" "ktn9" in
      assert_equal true (acc.balance = ref 1.0) );
    ( "create_account : checking txns_file" >:: fun _ ->
      let acc = create_account 1.0 "khoa" "ktn9" in
      assert_equal true (acc.txns_file = "khoa") );
    (* ------------------------ TESTS get_acc_xxxx ------------------------ *)
    ( "create_account : checking username" >:: fun _ ->
      let acc = create_account 1.0 "khoa" "ktn9" in
      assert_equal true (get_acc_username acc = "khoa") );
    ( "create_account : checking password" >:: fun _ ->
      let acc = create_account 1.0 "khoa" "ktn9" in
      assert_equal true (get_acc_password acc = "ktn9") );
    ( "create_account : checking password" >:: fun _ ->
      let acc = create_account 1.0 "khoa" "ktn9" in
      assert_equal true (get_acc_bal acc = 1.0) );
    ( "create_account : checking txns_file" >:: fun _ ->
      let acc = create_account 1.0 "khoa" "ktn9" in
      assert_equal true (get_acc_txns_file acc = "khoa") );
    (* ------------------------ TESTS load_accounts ------------------------ *)
    ( "load_accounts : csv file content correctly converts to account list \
       (one account)"
    >:: fun _ ->
      let test_csv_file1 =
        create_empty_csv "../../../data/" "test_users1.csv"
      in
      let accounts = load_accounts test_csv_file1 in
      let test_acc_1 = create_account 100.00 "TEST" "TEST" in
      let updated_accounts = add_account test_acc_1 accounts in
      save_accounts test_csv_file1 updated_accounts;
      let accounts = load_accounts test_csv_file1 in
      let _ = delete_csv_file test_csv_file1 in
      assert_equal true
        (accounts
        = [
            {
              balance = ref (get_acc_bal test_acc_1);
              username = get_acc_username test_acc_1;
              password = get_acc_password test_acc_1;
              txns_file = get_acc_txns_file test_acc_1;
            };
          ]) );
    ( "load_accounts : csv file content correctly converts to account list \
       (two+ accounts)"
    >:: fun _ ->
      let test_csv_file = create_empty_csv "../../../data/" "test_users2.csv" in
      let accounts = load_accounts test_csv_file in
      let test_acc_1 = create_account 100.00 "TEST" "TEST" in
      let test_acc_2 = create_account 101.00 "TEST2" "TEST2" in
      let test_acc_3 = create_account 102.00 "TEST3" "TEST3" in
      let updated_accounts =
        add_account test_acc_3
          (add_account test_acc_2 (add_account test_acc_1 accounts))
      in
      save_accounts test_csv_file updated_accounts;
      let accounts = load_accounts test_csv_file in
      let test_acc_1 = find_account "TEST" accounts in
      let test_acc_2 = find_account "TEST2" accounts in
      let test_acc_3 = find_account "TEST3" accounts in
      let _ = delete_csv_file test_csv_file in
      assert_equal true
        (accounts
        = [
            {
              balance = ref (get_acc_bal test_acc_3);
              username = get_acc_username test_acc_3;
              password = get_acc_password test_acc_3;
              txns_file = get_acc_txns_file test_acc_3;
            };
            {
              balance = ref (get_acc_bal test_acc_2);
              username = get_acc_username test_acc_2;
              password = get_acc_password test_acc_2;
              txns_file = get_acc_txns_file test_acc_2;
            };
            {
              balance = ref (get_acc_bal test_acc_1);
              username = get_acc_username test_acc_1;
              password = get_acc_password test_acc_1;
              txns_file = get_acc_txns_file test_acc_1;
            };
          ]) );
    (* ------------------------ TESTS find_account ------------------------ *)
    ( "find_account : checking arbitrary account doesn't exist in users.csv"
    >:: fun _ ->
      let accounts = load_accounts "../../../data/users.csv" in
      assert_raises (AccountNotFound "SHOULD RETURN ERROR") (fun _ ->
          find_account "SHOULD RETURN ERROR" accounts) );
    ( "find_account : checking test_acc_1 exists in users.csv" >:: fun _ ->
      let test_csv_file = create_empty_csv "../../../data/" "test_users3.csv" in
      let accounts = load_accounts test_csv_file in
      let test_acc_1 = create_account 100.00 "TEST" "TEST" in
      let updated_accounts = add_account test_acc_1 accounts in
      save_accounts test_csv_file updated_accounts;
      let accounts = load_accounts test_csv_file in
      let no_exc_occurred =
        try
          ignore (find_account "TEST" accounts);
          true
        with _ -> false
      in
      begin
        let _ = delete_csv_file test_csv_file in
        assert_equal true no_exc_occurred
      end );
    (* ------------------------ TESTS update_account ------------------------ *)
    ( "update_account : updating an existing account" >:: fun _ ->
      let test_csv_file = create_empty_csv "../../../data/" "test_users4.csv" in
      let accounts = load_accounts test_csv_file in
      let test_acc_1 = create_account 100.00 "TEST" "TEST" in
      let updated_accounts = add_account test_acc_1 accounts in
      save_accounts test_csv_file updated_accounts;
      let accounts = load_accounts test_csv_file in
      let updated_test_acc_1 = create_account 500.00 "TEST" "TEST" in
      let upd_acc_lst = update_account updated_test_acc_1 accounts in
      let _ = save_accounts test_csv_file updated_accounts in
      let _ = delete_csv_file test_csv_file in
      assert_equal true
        (upd_acc_lst
        = [
            {
              balance = ref (get_acc_bal updated_test_acc_1);
              username = get_acc_username updated_test_acc_1;
              password = get_acc_password updated_test_acc_1;
              txns_file = get_acc_txns_file updated_test_acc_1;
            };
          ]) );
    ( "update_account : updating an account that\n doesn't exist" >:: fun _ ->
      let test_csv_file = create_empty_csv "../../../data/" "test_users5.csv" in
      let accounts = load_accounts test_csv_file in
      let dne_acc = create_account 1.0 "SHOULD RETURN ERROR" "pw" in
      let _ = delete_csv_file test_csv_file in
      assert_raises (AccountNotFound "SHOULD RETURN ERROR") (fun _ ->
          update_account dne_acc accounts) );
    (* ------------------------ TESTS delete_account ------------------------ *)
    ( "delete_account : delete a registered account" >:: fun _ ->
      let test_csv_file = create_empty_csv "../../../data/" "test_users6.csv" in
      let accounts = load_accounts test_csv_file in
      let test_acc_1 = create_account 100.00 "TEST" "TEST" in
      let updated_accounts = add_account test_acc_1 accounts in
      save_accounts test_csv_file updated_accounts;
      let accounts = load_accounts test_csv_file in
      let updated_accounts = delete_account "TEST" accounts in
      let _ = save_accounts test_csv_file updated_accounts in
      let _ = delete_csv_file test_csv_file in
      assert_equal true (updated_accounts = []) );
    ( "delete_account : delete a unregistered account" >:: fun _ ->
      let test_csv_file = create_empty_csv "../../../data/" "test_users7.csv" in
      let accounts = load_accounts test_csv_file in
      let _ = delete_csv_file test_csv_file in
      assert_raises (AccountNotFound "SHOULD RETURN ERROR") (fun _ ->
          delete_account "SHOULD RETURN ERROR" accounts) );
    (* ------------------------ TESTS change_username ----------------------- *)
    ( "change_username : changes username for user that exists" >:: fun _ ->
      let test_csv_file = create_empty_csv "../../../data/" "test_users8.csv" in
      let accounts = load_accounts test_csv_file in
      let test_acc_1 = create_account 100.00 "TEST" "TEST" in
      let updated_accounts = add_account test_acc_1 accounts in
      save_accounts test_csv_file updated_accounts;
      let accounts = load_accounts test_csv_file in
      let updated_acc = change_username test_acc_1 "UPDATED_USERNAME" in
      let updated_accounts =
        delete_account (get_acc_username test_acc_1) accounts
      in
      let updated_accounts = add_account updated_acc updated_accounts in
      let _ = save_accounts test_csv_file updated_accounts in
      let _ = delete_csv_file test_csv_file in
      assert_equal true
        (updated_accounts
        = [
            {
              balance = ref (get_acc_bal updated_acc);
              username = "UPDATED_USERNAME";
              password = get_acc_password updated_acc;
              txns_file = get_acc_txns_file updated_acc;
            };
          ]) );
    (* ------------------------ TESTS change_password ----------------------- *)
    ( "change_password : changes password for user that exists" >:: fun _ ->
      let test_csv_file = create_empty_csv "../../../data/" "test_users9.csv" in
      let accounts = load_accounts test_csv_file in
      let test_acc_1 = create_account 100.00 "TEST" "TEST" in
      let updated_accounts = add_account test_acc_1 accounts in
      save_accounts test_csv_file updated_accounts;
      let accounts = load_accounts test_csv_file in
      let updated_acc = change_password test_acc_1 "UPDATED_USERNAME" in
      let updated_accounts =
        delete_account (get_acc_username test_acc_1) accounts
      in
      let updated_accounts = add_account updated_acc updated_accounts in
      let _ = save_accounts test_csv_file updated_accounts in
      let _ = delete_csv_file test_csv_file in
      assert_equal true
        (updated_accounts
        = [
            {
              balance = ref (get_acc_bal updated_acc);
              username = get_acc_username updated_acc;
              password = "UPDATED_USERNAME";
              txns_file = get_acc_txns_file updated_acc;
            };
          ]) );
    (* ------------------------ TESTS add_funds ----------------------- *)
    ( "add_funds : adds funds to user that exists" >:: fun _ ->
      let test_csv_file = create_empty_csv "../../../data/" "test_users9.csv" in
      let accounts = load_accounts test_csv_file in
      let test_acc_1 = create_account 100.00 "TEST" "TEST" in
      let updated_accounts = add_account test_acc_1 accounts in
      save_accounts test_csv_file updated_accounts;
      let accounts = load_accounts test_csv_file in
      let updated_acc = add_funds test_acc_1 50.00 in
      let updated_accounts =
        delete_account (get_acc_username test_acc_1) accounts
      in
      let updated_accounts = add_account updated_acc updated_accounts in
      let _ = save_accounts test_csv_file updated_accounts in
      let _ = delete_csv_file test_csv_file in
      assert_equal true
        (updated_accounts
        = [
            {
              balance = ref 150.00;
              username = get_acc_username updated_acc;
              password = get_acc_password updated_acc;
              txns_file = get_acc_txns_file updated_acc;
            };
          ]) );
  ]

let test_transactions =
  [
    (* ---------------------- TESTS create_transaction ---------------------- *)
    ( "create_transaction : creates a new valid transaction" >:: fun _ ->
      let txn = create_transaction "2024-05-16" 100.0 "Food" in
      assert_equal (get_txn_date txn) "2024-05-16";
      assert_equal (get_txn_amt txn) 100.0;
      assert_equal (get_txn_category txn) "Food" );
    (* ------------------------TESTS add_transaction ------------------------ *)
    ( "add_transaction : adds a transaction to a transaction file" >:: fun _ ->
      let test_csv_file = create_empty_csv "../../../data/" "test_user1.csv" in
      let transactions = load_transactions test_csv_file in
      let txn1 = create_transaction "2024-05-16" 100.0 "Food" in
      let txn2 = create_transaction "2024-05-17" 200.0 "Transport" in
      let upd_txns = add_transaction txn2 (add_transaction txn1 transactions) in
      save_transactions test_csv_file upd_txns;
      let transactions = load_transactions test_csv_file in
      let _ = delete_csv_file test_csv_file in
      assert_equal 2 (List.length transactions);
      assert_equal true (transactions = [ txn2; txn1 ]) );
    (* ------------------------TESTS sum_transactions ----------------------- *)
    ( "sum_transactions" >:: fun _ ->
      let test_csv_file = create_empty_csv "../../../data/" "test_user2.csv" in
      let transactions = load_transactions test_csv_file in
      let txn1 = create_transaction "2024-05-16" 100.0 "Food" in
      let txn2 = create_transaction "2024-05-17" 200.0 "Transport" in
      let upd_txns = add_transaction txn2 (add_transaction txn1 transactions) in
      save_transactions test_csv_file upd_txns;
      let transactions = load_transactions test_csv_file in
      let _ = delete_csv_file test_csv_file in
      assert_equal 300.0 (sum_transactions transactions) );
    (* ------------------ TESTS filter_transactions_by_category ------------- *)
    ( "filter_transactions_by_category" >:: fun _ ->
      let test_csv_file = create_empty_csv "../../../data/" "test_user3.csv" in
      let transactions = load_transactions test_csv_file in
      let txn1 = create_transaction "2024-05-16" 100.0 "Food" in
      let txn2 = create_transaction "2024-05-17" 200.0 "Transport" in
      let upd_txns = add_transaction txn2 (add_transaction txn1 transactions) in
      save_transactions test_csv_file upd_txns;
      let transactions = load_transactions test_csv_file in
      let food_txns = filter_transactions_by_category transactions "Food" in
      let _ = delete_csv_file test_csv_file in
      assert_equal 1 (List.length food_txns);
      assert_equal "Food" (get_txn_category (List.hd food_txns));
      assert_equal true (food_txns = [ txn1 ]) );
    (* ------------------ TESTS filter_transactions_by_date ----------------- *)
    ( "filter_transactions_by_date" >:: fun _ ->
      let test_csv_file = create_empty_csv "../../../data/" "test_user4.csv" in
      let transactions = load_transactions test_csv_file in
      let txn1 = create_transaction "2024-05-16" 100.0 "Food" in
      let txn2 = create_transaction "2024-05-17" 200.0 "Transport" in
      let txn3 = create_transaction "2024-05-19" 50.0 "Food" in
      let upd_txns =
        add_transaction txn3
          (add_transaction txn2 (add_transaction txn1 transactions))
      in
      save_transactions test_csv_file upd_txns;
      let transactions = load_transactions test_csv_file in
      let date_filtered_txns =
        filter_transactions_by_date transactions "2024-05-16" "2024-05-17"
      in
      let _ = delete_csv_file test_csv_file in
      assert_equal 2 (List.length date_filtered_txns);
      assert_equal "Transport" (get_txn_category (List.hd date_filtered_txns));
      assert_equal true (date_filtered_txns = [ txn2; txn1 ]) );
    (* --------------- TESTS test_create_new_transaction_file --------------- *)
    ( "create_new_transaction_file" >:: fun _ ->
      let username = "testuser" in
      create_new_transaction_file username;
      let path = Filename.concat "data" (username ^ ".csv") in
      assert_bool "File should exist" (Sys.file_exists path) );
  ]

let test_math =
  [
    (* -------------------------- TESTS average_list ------------------------ *)
    ( "average_list : returns average values from list of integers" >:: fun _ ->
      let lst = [ 1.0; 2.0; 3.0; 4.0; 5.0; 6.0; 7.0 ] in
      assert_equal true (average_list lst = 4.0) );
    ( "average_list : returns average values from list of floats" >:: fun _ ->
      let lst = [ 1.0; 2.5; 5.5; 7.5 ] in
      assert_equal true (average_list lst = 4.125) );
    ( "average_list : returns 0 if list is empty" >:: fun _ ->
      let lst = [] in
      assert_equal true (average_list lst = 0.) );
    (* -------------------- TESTS average_over_days_list -------------------- *)
    ( "average_over_days_list : average from list of integers over 4 days"
    >:: fun _ ->
      let lst = [ 1.0; 2.0; 3.0; 4.0; 5.0; 6.0; 7.0 ] in
      assert_equal true (average_over_days_list lst 4.0 = 7.0) );
    ( "average_over_days_list : average from list of floats over 5 days"
    >:: fun _ ->
      let lst = [ 1.0; 2.5; 5.5; 7.5 ] in
      assert_equal true (average_over_days_list lst 5. = 3.3) );
    ( "average_over_days_list : divide by 0 days" >:: fun _ ->
      let lst = [ 1.0; 2.5; 5.5; 7.5 ] in
      assert_raises DivideByZero (fun () -> average_over_days_list lst 0.0) );
    ( "average_over_days_list : returns 0 if list is empty" >:: fun _ ->
      let lst = [] in
      assert_equal true (average_over_days_list lst 1.0 = 0.) );
    (* --------------------- TESTS get_brb_spot ----------------------------- *)
    ( "get_brb_spot : checks if the random spot is one from the vendor list"
    >:: fun _ -> assert_equal true (List.mem (get_brb_spot ()) brb_venders) );
    (* --------------------- TESTS get_brb_item ----------------------------- *)
    ( "get_brb_item : checks if the random item is one from the food list"
    >:: fun _ -> assert_equal true (List.mem (get_brb_item ()) brb_items) );
    (* --------------------- TESTS optimize_future_spending ----------------- *)
    ( "optimize_future_spending : integers " >:: fun _ ->
      assert_equal true (optimize_future_spending 100.0 10.0 = 10.0) );
    ( "optimize_future_spending : floats " >:: fun _ ->
      assert_equal true (optimize_future_spending 105.0 10.0 = 10.5) );
    ( "optimize_future_spending : zero " >:: fun _ ->
      assert_raises DivideByZero (fun () -> optimize_future_spending 105.0 0.)
    );
  ]

let tests = "test suite" >::: test_account @ test_transactions @ test_math
let _ = run_test_tt_main tests
