(* @author Khoa Nguyen (ktn9) Kyle Chu (kgc42) Vail Chen (vac68) *)
type account = {
  balance : float ref;
  username : string;
  password : string;
  txns_file : string;
}

exception AccountNotFound of string
exception UsernameExists of string

let create_account bal name pw =
  { balance = ref bal; username = name; password = pw; txns_file = name }

let load_accounts filename =
  let table = Csv.load filename in
  List.map
    (function
      | [ balance; username; password; txns_file ] ->
          {
            balance = ref (float_of_string balance);
            username;
            password;
            txns_file;
          }
      | _ -> failwith "Malformed CSV data")
    table

let save_accounts filename accounts =
  let data =
    List.map
      (fun acc ->
        [
          string_of_float !(acc.balance);
          acc.username;
          acc.password;
          acc.txns_file;
        ])
      accounts
  in
  Csv.save filename data

let find_account username accounts =
  try List.find (fun acc -> acc.username = username) accounts
  with Not_found -> raise (AccountNotFound username)

let add_account new_acc accounts =
  let exists =
    List.exists (fun acc -> acc.username = new_acc.username) accounts
  in
  if exists then
    raise
      (UsernameExists
         "This username already exists. Please choose a different one.")
  else new_acc :: accounts

let update_account updated_acc accounts =
  updated_acc
  :: List.filter (fun acc -> acc.username <> updated_acc.username) accounts

let delete_account username accounts =
  List.filter (fun acc -> acc.username <> username) accounts

let get_acc_bal account = !(account.balance)
let get_acc_username account = account.username
let get_acc_bal account = account.password
let get_acc_txns_file account = account.txns_file
