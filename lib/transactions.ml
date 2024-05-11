type transaction = {
  id : int;
  date : string;
  amount : float;
  category : string;
}

let create_transaction id date amount category = { id; date; amount; category }

let load_transactions filename =
  let table = Csv.load filename in
  List.map
    (function
      | [ id; date; amount; category ] ->
          {
            id = int_of_string id;
            date;
            amount = float_of_string amount;
            category;
          }
      | _ -> failwith "error with csv")
    table

let save_transactions filename transactions =
  let data =
    List.map
      (fun txn ->
        [
          string_of_int txn.id;
          txn.date;
          string_of_float txn.amount;
          txn.category;
        ])
      transactions
  in
  Csv.save filename data

let add_transaction new_txn transactions =
  if List.exists (fun txn -> txn.id = new_txn.id) transactions then
    failwith "Transaction ID already exists"
  else new_txn :: transactions

let delete_transaction txn_id transactions =
  List.filter (fun txn -> txn.id <> txn_id) transactions

let view_transactions transactions =
  List.iter
    (fun txn ->
      Printf.printf "Transaction ID: %d\n" txn.id;
      Printf.printf "Date: %s\n" txn.date;
      Printf.printf "Amount: %.2f\n" txn.amount;
      Printf.printf "Category: %s\n\n" txn.category)
    transactions
