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

let delete_transaction txn_id transactions =
  List.filter (fun txn -> txn.id <> txn_id) transactions
