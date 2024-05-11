type transaction

val create_new_transaction_file : string -> unit
(** [create_new_transaction_file name] creates a new csv file in /data folder
    with filename [user], associating with that user's transactions. *)

val create_transaction : string -> float -> string -> transaction
(** [crate_transaction id date amount category] is a new [transaction] record
    with [id] id on day [date] of the amount [amount] and category [category]. *)

val load_transactions : string -> transaction list
(** [load_transactions filename] outputs the transactions of the user's
    transaction's file which has [filename]. *)

val save_transactions : string -> transaction list -> unit
(** [save_transactions filename transactions] saves the list of transactions
    [transactions] to the file [filename]. *)

val add_transaction : transaction -> transaction list -> transaction list
val view_transactions : transaction list -> unit

val filter_transactions_by_date :
  transaction list -> string -> string -> transaction list

val filter_transactions_by_category :
  transaction list -> string -> transaction list

val sum_transactions : transaction list -> float

val get_txn_date : transaction -> string
(** [get_txn_date transaction] returns the date of the transaction *)

val get_txn_amt : transaction -> float
(** [get_txn_amt transaction] returns the amount of the transaction *)

val get_txn_category : transaction -> string
(** [get_txn_category transaction] returns the category of the transaction *)
