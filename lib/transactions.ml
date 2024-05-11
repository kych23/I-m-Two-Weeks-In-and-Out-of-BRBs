(* type transaction = { id : int; date : string; amount : float; category :
   string; }

   let ensure_directory_exists path = if not (Sys.file_exists path) then
   Unix.mkdir path 0o755

   let create_and_save_csv_in_folder folder filename = ensure_directory_exists
   folder; let path = Filename.concat folder filename in Csv.save path []

   let create_new_transaction_file username = create_and_save_csv_in_folder
   "/data" username

   let create_transaction id date amount category = { id; date; amount; category
   }

   let load_transactions filename = let table = Csv.load filename in List.map
   (function | [ id; date; amount; category ] -> { id = int_of_string id; date;
   amount = float_of_string amount; category; } | _ -> failwith "error with
   csv") table

   let save_transactions filename transactions = let data = List.map (fun txn ->
   [ string_of_int txn.id; txn.date; string_of_float txn.amount; txn.category;
   ]) transactions in Csv.save filename data

   let add_transaction new_txn transactions = if List.exists (fun txn -> txn.id
   = new_txn.id) transactions then failwith "Transaction ID already exists" else
   new_txn :: transactions

   let delete_transaction txn_id transactions = List.filter (fun txn -> txn.id
   <> txn_id) transactions *)
