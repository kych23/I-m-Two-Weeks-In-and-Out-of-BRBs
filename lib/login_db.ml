(* login_db.ml *)
open Sqlite3

(** [create_users_table db] creates the user table database if it doesn't
    already exist when prompted *)
let create_users_table db =
  let create_user_table =
    "CREATE TABLE IF NOT EXISTS users (\n\
    \      id INTEGER PRIMARY KEY AUTOINCREMENT,\n\
    \      username TEXT NOT NULL UNIQUE,\n\
    \      password TEXT NOT NULL,\n\
    \      brb_balance INTEGER DEFAULT 0\n\
    \    );"
  in
  (* Pass a callback that takes both row and headers and does nothing with
     them *)
  let callback _ _ = () in
  (* This matches the expected type of the callback *)
  match exec db ~cb:callback create_user_table with
  | Rc.OK -> Printf.printf "Users table created successfully\n"
  | Rc.ERROR -> Printf.printf "Could not create users table\n"
  | _ -> Printf.printf "Unexpected error when creating users table\n"

(**[add_user db username password brb_balance] inserts a user into [db] with
   [username], [password], [brb_balance]*)
(* let add_user db username password brb_balance = db; username; password;
   brb_balance; failwith "TODO" *)

(** [initialize_db] initializes and cretes the user table database and returns
    the database*)
let initialize_db () =
  let db = db_open "my_database.db" in
  create_users_table db;
  db
