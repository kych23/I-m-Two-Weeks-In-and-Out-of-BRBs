exception DivideByZero

val average_list : float list -> float
(** [average lst] returns the average value of the entries in [lst] *)

val average_over_days_list : float list -> float -> float
(** [average_over_days_list lst days] returns the division of the sum of the
    entries in [lst] divided by [days]*)

val brb_venders : string list
(** [brb_venders] is a list of all places on Cornell's campus that accept brbs *)

val brb_items : string list
(** [brb_items] is a list of our favorite items on campus that can be purchased
    with brbs *)

val get_brb_spot : unit -> string
(** [get_brb_spot] returns a random brb spot *)

val get_brb_item : unit -> string
(** [get_brb_item] Returns a random brb item. *)

val desirability : int -> bool
(** [desirability probability] generates a random integer from 0 to 100 and
    returns whether or not [probability] is greater than the random number*)

val desire_relative : float -> float -> int -> bool
(** [desire_relative balance price probability] generates a random integer from
    0 to 100 and scales [probability] by how big [price] is relative to
    [balance], then calculates whether or not this scaled number is greater than
    the random number calculated*)

val optimize_future_spending : float -> float -> float
(** [optimize_future_spending balance days] calculates how much money can be
    spent per day given the remaining balance [balance] over days [days]*)

val rate_of_spending : float -> float -> float -> float
(** [rate_of_spending starting ending days_remaining] calculates the rate of
    spending given the starting balance [starting], current balance [ending] and
    the numbers of days passed [days]*)

val days_until_broke : float -> float -> float -> float
(** [days_until_broke starting ending days_passed] returns how many days until
    money will run out given the users current rate of spending based on their
    starting balance [starting], current balance [ending] and the numbers of
    days passed [days_passed]*)

val calculate_percentages_category : float -> float -> float
(** [calculate_percentages_category total_spent category_spent] calculates the
    percentage of spending that occurred in a specific category by dividing
    money spent in [category_spent] by total spending [total_spent]*)

val calculate_money_needed : float -> float -> float -> float -> float
(** [calculate_money_needed starting ending days_passed days_remaining]
    calculates how much money is needed based for the remaining days
    [days_remaining] on the users current spending rate as given by their
    starting balance [starting], current balance [ending], over days passed
    [days_passed] *)

val allocate_by_category : float -> float -> float -> float
(** [allocate_by_category total_spent category_spent current] calculates how
    much of the remaining balance [current] needs to be allocated to a specific
    category given by the total money spent [total_spent] and money spent in
    that specific category [category_spent]*)

val consistent_day : float -> float -> float -> float -> bool
(** [consistent_day starting ending day_spent days_passed] returns whether or
    not a days spending [day_spent] is close to previous daily spending rate
    based on starting balance [starting] current balance [ending] and days
    passed [days_passed] *)

val youre_broke : float -> float -> bool
(** [youre_broke balance target] returns true if you're balance is below the
    target and false if it is above*)

val calculate_remaining_money : float -> float -> float -> float -> float
(** [calculate_remaining_money starting ending days_passed days_remaining]
    calculates the estimated money remaining at the end of [days_remaining]
    based on the rate of spending as given by starting balance [starting]
    current balance [ending] and days passed [days_passed] *)
