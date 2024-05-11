type transaction

val create_new_transaction_file : string -> unit
val create_transaction : int -> string -> float -> string -> transaction
(** [crate_transaction id date amount category] is a new [transaction] record
    with [id] id on day [date] of the amount [amount] and category [category]. *)

val load_transactions : string -> transaction list
(** [load_transactions filename] outputs the transactions of the user's
    transaction's file which has [filename]. *)

val save_transactions : string -> transaction list -> unit
(** [save_transactions filename transactions] saves the list of transactions
    [transactions] to the file [filename]. *)

val add_transaction : transaction -> transaction list -> transaction list
val delete_transaction : transaction -> transaction list -> transaction list
