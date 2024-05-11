open OUnit2
open Cs3110_final_project.Account

(* open Cs3110_final_project.Transaction *)
let ensure_no_existing_account username accounts =
  try
    let _ = find_account username accounts in
    let updated_accounts = delete_account username accounts in
    save_accounts "../../../data/users.csv" updated_accounts
  with AccountNotFound _ -> ()

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
    (* TESTS for checking if the users.csv file is correctly updated *)
    ( "load_accounts : checking arbitrary account doesn't exist in users.csv"
    >:: fun _ ->
      let accounts = load_accounts "../../../data/users.csv" in
      assert_raises (AccountNotFound "SHOULD RETURN ERROR") (fun _ ->
          find_account "SHOULD RETURN ERROR" accounts) );
    ( "load_accounts : checking test_acc_1 exists in users.csv" >:: fun _ ->
      let accounts = load_accounts "../../../data/users.csv" in
      ensure_no_existing_account "TEST" accounts;
      let accounts = load_accounts "../../../data/users.csv" in
      let test_acc_1 = create_account 100.00 "TEST" "TEST" in
      let updated_accounts = add_account test_acc_1 accounts in
      save_accounts "../../../data/users.csv" updated_accounts;
      let accounts = load_accounts "../../../data/users.csv" in
      let no_exc_occurred =
        try
          ignore (find_account "TEST" accounts);
          true
        with _ -> false
      in
      begin
        assert_equal true no_exc_occurred
      end );
  ]

let test_transactions =
  [ (* ( "test_insert with random tree" >:: fun _ -> ); *) ]

let tests = "test suite" >::: test_account @ test_transactions
let _ = run_test_tt_main tests
