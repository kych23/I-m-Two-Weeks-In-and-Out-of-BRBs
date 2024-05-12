(* @author Khoa Nguyen (ktn9) Kyle Chu (kgc42) Vail Chen (vac68)*)
type account = {
  balance : float ref;
  username : string;
  password : string;
  txns_file : string;
}
(** Type representing user account information *)

exception AccountNotFound of string
(** Exception raised when an account cannot be found *)

val create_account : float -> string -> string -> account
(** [create_account bal usrnm pw] creates a new account with balance [bal],
    username [usrnm], password [pw] *)

val add_account : account -> account list -> account list
(** [add_account acc acc_list] adds a new account [acc] to the existing account
    list [acc_list] *)

val save_accounts : string -> account list -> unit
(** [save_accounts filename acc_list] saves the current account list [acc_list]
    to the CSV file [filename] *)

val load_accounts : string -> account list
(** [load_accounts filename] loads accounts from a CSV file [filename] and
    converts it into an account list *)

val find_account : string -> account list -> account
(** [find_account username acc_list] returns the account with username
    [username] in the list of accounts [acc_list] *)

val update_account : account -> account list -> account list
(** [update_account acc acc_list] replaces the old account with the new updated
    account [acc] in the existing account list [acc_list]*)

val delete_account : string -> account list -> account list
(** [delete_account usrnm acc_list] deletes the account with username [usrnm]
    from the account list [acc_list] *)

val get_acc_bal : account -> float
(** [get_acc_bal account] returns the accounts balance *)

val get_acc_username : account -> string
(** [get_acc_username account] returns the accounts username *)

val get_acc_password : account -> string
(** [get_acc_password account] returns the accounts password *)

val get_acc_txns_file : account -> string
(** [get_acc_txns_file account] returns the accounts transactions file name *)

val clear_users_csv : string -> unit
(** [clear_users_csv filename] deletes all entries in the users.csv file *)
