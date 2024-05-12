open OUnit2
open Cs3110_final_project.Account

(* open Cs3110_final_project.Transaction *)

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
    (* TESTS for checking the new account constructor correctly assigns the
       right fields to inputted parameters *)
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
    (* TESTS for getter functions *)
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
    (* TESTS for load_account correctly converts csv file to account list *)
    ( "load_accounts : csv file content correctly converts to account list \
       (one account)"
    >:: fun _ ->
      let test_csv_file1 = create_empty_csv "../../../data/" "test_users1" in
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
      let test_csv_file = create_empty_csv "../../../data/" "test_users2" in
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
    (* TESTS for checking if a user exists inthe users.csv file *)
    ( "find_account : checking arbitrary account doesn't exist in users.csv"
    >:: fun _ ->
      let accounts = load_accounts "../../../data/users.csv" in
      assert_raises (AccountNotFound "SHOULD RETURN ERROR") (fun _ ->
          find_account "SHOULD RETURN ERROR" accounts) );
    ( "find_account : checking test_acc_1 exists in users.csv" >:: fun _ ->
      let test_csv_file = create_empty_csv "../../../data/" "test_users3" in
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
    (* TESTS for updating accounts *)
    ( "update_account : updating an existing account" >:: fun _ ->
      let test_csv_file = create_empty_csv "../../../data/" "test_users4" in
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
      let accounts = load_accounts "../../../data/users.csv" in
      let dne_acc = create_account 1.0 "SHOULD RETURN ERROR" "pw" in
      assert_raises (AccountNotFound "SHOULD RETURN ERROR") (fun _ ->
          update_account dne_acc accounts) );
  ]

let test_transactions =
  [ (* ( "test_insert with random tree" >:: fun _ -> ); *) ]

let tests = "test suite" >::: test_account @ test_transactions
let _ = run_test_tt_main tests
