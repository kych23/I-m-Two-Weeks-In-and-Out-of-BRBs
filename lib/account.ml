(* @author Khoa Nguyen (ktn9) Kyle Chu (kgc42) Vail Chen (vac68)*)

type account_info = {
  username : string;
  password : string;
}

exception AccountNotFound of string

let load_accounts filename =
  let table = Csv.load filename in
  List.map
    (function
      | [ username; password ] -> { username; password }
      | _ -> failwith "Malformed CSV data")
    table

let save_accounts filename accounts =
  let data = List.map (fun acc -> [ acc.username; acc.password ]) accounts in
  Csv.save filename data

let find_account username accounts =
  try List.find (fun acc -> acc.username = username) accounts
  with Not_found -> raise (AccountNotFound username)

let add_account new_acc accounts = new_acc :: accounts

let update_account updated_acc accounts =
  updated_acc
  :: List.filter (fun acc -> acc.username <> updated_acc.username) accounts

let delete_account username accounts =
  List.filter (fun acc -> acc.username <> username) accounts
