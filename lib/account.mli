(* @author Khoa Nguyen (ktn9) Kyle Chu (kgc42) Vail Chen (vac68)*)
type account_info = {
  username : string;
  password : string;
}
(** Type representing user account information *)

exception AccountNotFound of string
(** Exception raised when an account cannot be found *)

val load_accounts : string -> account_info list
(** Load accounts from a CSV file *)

val save_accounts : string -> account_info list -> unit
(** Save accounts to a CSV file *)

val find_account : string -> account_info list -> account_info
(** Find an account by username *)

val add_account : account_info -> account_info list -> account_info list
(** Add a new account *)

val update_account : account_info -> account_info list -> account_info list
(** Update an existing account *)

val delete_account : string -> account_info list -> account_info list
(** Delete an account *)
