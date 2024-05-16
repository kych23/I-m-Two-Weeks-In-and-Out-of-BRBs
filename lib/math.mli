exception DivideByZero

val average_list : float list -> float
(** Returns the average value of the entries in a float list. *)

val average_over_days_list : float list -> float -> float
(** Returns the division of the sum of the entries in a float list divided by
    days. *)

val brb_venders : string list
(** List of places on Cornell's campus that accept brbs. *)

val brb_items : string list
(** List of our favorite items on Cornell's campus that can be purchased using
    brbs. *)

val get_brb_spot : unit -> string
(** Returns a random brb spot. *)

val get_brb_item : unit -> string
(** Returns a random brb item. *)

val desirability : int -> bool
(** Generates a random boolean based on a probability threshold. *)

val desire_relative : float -> float -> int -> bool
(** Generates a random boolean based on a probability threshold scaled by a
    relative value. *)

val optimize_future_spending : float -> float -> float
(** Calculates how much money can be spent per day given the remaining balance
    over days. *)

val rate_of_spending : float -> float -> float -> float
(** Calculates the rate of spending given the starting and ending balances and
    days passed. *)

val days_until_broke : float -> float -> float -> float
(** Calculates how many days until money will run out given the current rate of
    spending. *)

val calculate_percentages_category : float -> float -> float
(** Calculates the percentage of spending in a specific category relative to
    total spending. *)

val calculate_money_needed : float -> float -> float -> float -> float
(** Calculates how much money is needed for the remaining days based on the
    current spending rate. *)

val allocate_by_category : float -> float -> float -> float
(** Allocates a specific amount of money to a category based on total spending
    and current balance. *)

val consistent_day : float -> float -> float -> float -> bool
(** Checks if a day's spending is consistent with the previous daily spending
    rate. *)

val youre_broke : float -> float -> bool
(** Checks if the balance is below a target amount. *)

val calculate_remaining_money : float -> float -> float -> float -> float
(** Calculates the estimated remaining money based on the current spending rate
    and remaining days. *)
