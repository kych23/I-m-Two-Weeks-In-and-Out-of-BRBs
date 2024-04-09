val create_users_table : Sqlite3.db -> unit
(** [create_users_table db] creates the user table database if it doesn't
    already exist when prompted *)

(* val add_user : Sqlite3.db -> string -> string -> int -> unit (** [add_user db
   username password brb_balance] inserts a user into [db] with [username],
   [password], [brb_balance]*) *)

val initialize_db : unit -> Sqlite3.db
(** [initialize_db] initializes and creates the user table database and returns
    the database *)
