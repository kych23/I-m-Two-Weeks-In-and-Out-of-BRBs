(* @author Khoa Nguyen (ktn9) Kyle Chu (kgc42) Vail Chen (vac68)*)
type account = {
  username : string;
  password : string;
  txns_file : string;
}
(** Type representing user account information *)

exception AccountNotFound of string
(** Exception raised when an account cannot be found *)

val create_account : string -> string -> account

val load_accounts : string -> account list
(** Load accounts from a CSV file *)

val save_accounts : string -> account list -> unit
(** Save accounts to a CSV file *)

val find_account : string -> account list -> account
(** Find an account by username *)

val add_account : account -> account list -> account list
(** Add a new account *)

val update_account : account -> account list -> account list
(** Update an existing account *)

val delete_account : string -> account list -> account list
(** Delete an account *)
