type transaction = {
  date : string;
  amount : float;
  category : string;
}

let ensure_directory_exists path =
  if not (Sys.file_exists path) then Unix.mkdir path 0o755

let create_and_save_csv_in_folder folder filename =
  ensure_directory_exists folder;
  let path = Filename.concat folder filename in
  Csv.save path []

let create_new_transaction_file username =
  create_and_save_csv_in_folder "data" (username ^ ".csv")

let create_transaction date amount category = { date; amount; category }

let load_transactions filename =
  let table = Csv.load filename in
  match table with
  | [] -> []
  | _ ->
      List.map
        (function
          | [ date; amount; category ] ->
              { date; amount = float_of_string amount; category }
          | _ -> failwith "error with csv")
          (* Error handling for incorrect format *)
        table

let save_transactions filename transactions =
  let data =
    List.map
      (fun txn -> [ txn.date; string_of_float txn.amount; txn.category ])
      transactions
  in
  Csv.save filename data

let add_transaction new_txn transactions = new_txn :: transactions

let view_transactions transactions =
  List.iter
    (fun txn ->
      Printf.printf "Date: %s\n" txn.date;
      Printf.printf "Amount: %.2f\n" txn.amount;
      Printf.printf "Category: %s\n\n" txn.category)
    transactions

let filter_transactions_by_date transactions start_date end_date =
  List.filter
    (fun txn -> txn.date >= start_date && txn.date <= end_date)
    transactions

let filter_transactions_by_category transactions category =
  List.filter (fun txn -> txn.category = category) transactions

let sum_transactions transactions =
  List.fold_left (fun acc txn -> acc +. txn.amount) 0.0 transactions

let get_txn_date transaction = transaction.date
let get_txn_amt transaction = transaction.amount
let get_txn_category transaction = transaction.category
let get_txn_amounts transaction_lt = List.map get_txn_amt transaction_lt
