open OUnit2
open Cs3110_final_project.Account

(* open Cs3110_final_project.Transaction *)
let test_account =
  [
    ( "create new account" >:: fun _ ->
      let acc = create_account "khoa" "ktn9" in
      assert_equal true (acc.username = "khoa") );
  ]

let test_transactions =
  [ (* ( "test_insert with random tree" >:: fun _ -> ); *) ]

let tests = "test suite" >::: test_account @ test_transactions
let _ = run_test_tt_main tests
