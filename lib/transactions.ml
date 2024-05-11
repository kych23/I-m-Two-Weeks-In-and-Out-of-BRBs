type transaction = {
  id : int;
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
  create_and_save_csv_in_folder "/data" username

let create_transaction id date amount category = { id; date; amount; category }
