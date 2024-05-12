open OUnit2
open Cs3110_final_project.Account

(* open Cs3110_final_project.Transaction *)
let ensure_no_existing_account username accounts =
  try
    let _ = find_account username accounts in
    let updated_accounts = delete_account username accounts in
    save_accounts "../../../data/users.csv" updated_accounts
  with AccountNotFound _ -> ()

(* resets users.csv file. WARNING - will delete all previously registered
   accounts *)
let _ = clear_users_csv "../../../data/users.csv"

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
    (* TESTS for load_account correctly converts csv file to account list *)
    ( "load_accounts : csv file content correctly converts to account list \
       (one account)"
    >:: fun _ ->
      let _ = clear_users_csv "../../../data/users.csv" in
      let accounts = load_accounts "../../../data/users.csv" in
      ensure_no_existing_account "TEST" accounts;
      let accounts = load_accounts "../../../data/users.csv" in
      let test_acc_1 = create_account 100.00 "TEST" "TEST" in
      let updated_accounts = add_account test_acc_1 accounts in
      save_accounts "../../../data/users.csv" updated_accounts;
      let accounts = load_accounts "../../../data/users.csv" in
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
      let _ = clear_users_csv "../../../data/users.csv" in
      let accounts = load_accounts "../../../data/users.csv" in
      ensure_no_existing_account "TEST" accounts;
      ensure_no_existing_account "TEST2" accounts;
      ensure_no_existing_account "TEST3" accounts;

      let accounts = load_accounts "../../../data/users.csv" in
      let test_acc_1 = create_account 100.00 "TEST" "TEST" in
      let test_acc_2 = create_account 101.00 "TEST2" "TEST2" in
      let test_acc_3 = create_account 102.00 "TEST3" "TEST3" in

      let updated_accounts =
        add_account test_acc_3
          (add_account test_acc_2 (add_account test_acc_1 accounts))
      in
      save_accounts "../../../data/users.csv" updated_accounts;

      let accounts = load_accounts "../../../data/users.csv" in
      let test_acc_1 = find_account "TEST" accounts in
      let test_acc_2 = find_account "TEST2" accounts in
      let test_acc_3 = find_account "TEST3" accounts in
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
      let _ = clear_users_csv "../../../data/users.csv" in
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
