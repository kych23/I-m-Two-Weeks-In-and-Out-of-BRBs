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
(** [add_transaction txn txn_lst] adds a transaction [txn] to the transaction
    list [txn_lst] *)

val view_transactions : transaction list -> unit
(** [view_transactions txn_lst] prints the current user's transaction list
    [txn_lst] *)

val filter_transactions_by_date :
  transaction list -> string -> string -> transaction list
(** [filter_transactions_by_date txn_lst s_date e_date] filters and returns the
    list of transactions [txn_lst] that started after date [s_date] and ended
    before date [e_date] *)

val filter_transactions_by_category :
  transaction list -> string -> transaction list
(** [filter_transactions_by_category txn_lst category] filters and returns the
    list of transactions [txn_lst] that are categorized with [category] *)

val sum_transactions : transaction list -> float
(** [sum_transactions txn_lst] returns the sum of all of the transaction amounts
    from transaction list [txn_lst] *)

val get_txn_date : transaction -> string
(** [get_txn_date transaction] returns the date of the transaction *)

val get_txn_amt : transaction -> float
(** [get_txn_amt transaction] returns the amount of the transaction *)

val get_txn_category : transaction -> string
(** [get_txn_category transaction] returns the category of the transaction *)

val get_txn_amounts : transaction list -> float list
(** [get_txn_category transactions] is the list of all the transactions' amounts *)

val rename_transaction_file : string -> string -> unit
(** [rename_transaction_file old_name new_name] changes the transaction file's
    name from [old_name] to [new_name]*)
