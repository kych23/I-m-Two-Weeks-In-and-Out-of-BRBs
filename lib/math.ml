(* @author Khoa Nguyen (ktn9) Kyle Chu (kgc42) Vail Chen (vac68) *)

let () = Random.self_init ()

(* [last_day] is an approximation for the amount of days in a school year *)
let last_day = 286

(* [sum lst] returns the sum of the values in [lst]*)
let rec sum (lst : float list) =
  match lst with
  | [] -> 0.0
  | h :: t -> h +. sum t

(* [average lst] returns the average value of the entries in [lst] *)
let average_list (lst : float list) : float =
  let summation = sum lst in
  let number = float_of_int (List.length lst) in
  if summation = 0.0 then 0.0 else summation /. number

(* [average_over_days_list lst days] returns the division of the sum of the
   entries in [lst] divided by [days]*)
let average_over_days_list (lst : float list) days =
  let summation = sum lst in
  summation /. days

(* [brb_venders] is a list of all places on Cornell's campus that accept brbs *)
let brb_venders =
  [
    ( "Trillium",
      "Terrace",
      "Dairy Bar",
      "Mac's",
      "Jennie",
      "Martha's",
      "Ivy",
      "Nasties",
      "Bus Stop Bagels",
      "Libe",
      "Goldie's",
      "Mattin's" );
  ]

(* [choose_number_from_list lst] randomly chooses an index in [lst]*)
let choose_number_from_list lst =
  let length = List.length lst in
  Random.int length

exception EmptyList

let rec get_element_helper lst index count =
  match lst with
  | [] -> raise EmptyList
  | h :: t -> if count = index then h else get_element_helper t index (count + 1)

(* [get_element lst index] returns the element at index [index] in list [lst]*)
let get_element lst index = get_element_helper lst index 0

(* [get_brb_spot] returns a random brb spot *)
let get_brb_spot =
  let random_spot = choose_number_from_list brb_venders in
  get_element brb_venders random_spot

(* [desirability probability] generates a random integer from 0 to 100 and
   returns whether or not [probability] is greater than the random number*)
let desirability probability =
  let random_number = Random.int 101 in
  probability > random_number

(* [desire_relative balance price probability] generates a random integer from 0
   to 100 and scales [probability] by how big [price] is relative to [balance],
   then calculates whether or not this scaled number is greater than the random
   number calculated*)
let desire_relative balance price probability =
  let random_number = Random.int 101 in
  let scaled_probability =
    float_of_int probability *. (1.0 -. (price /. balance))
  in
  scaled_probability > float_of_int random_number

(* [optimize_future_spending balance days] calculates how much money can be
   spent per day given the remaining balance [balance] over days [days]*)
let optimize_future_spending balance days =
  let per_day = balance /. days in
  per_day

(* [rate_of_spending starting ending days_remaining] calculates the rate of
   spending given the starting balance [starting], current balance [ending] and
   the numbers of days passed [days]*)
let rate_of_spending starting ending days =
  let money_spent = starting -. ending in
  let rate = money_spent /. days in
  rate

(* [days_until_broke starting ending days_passed] returns how many days until
   money will run out given the users current rate of spending based on their
   starting balance [starting], current balance [ending] and the numbers of days
   passed [days_passed]*)
let days_until_broke starting ending days_passed =
  let rate = rate_of_spending starting ending days_passed in
  let days_left = ending /. rate in
  days_left

(* [calculate_percentages_category total_spent category_spent] calculates the
   percentage of spending that occurred in a specific category by dividing money
   spent in [category_spent] by total spending [total_spent]*)
let calculate_percentages_category total_spent category_spent =
  let percentage = category_spent /. total_spent in
  percentage

(* [calculate_money_needed starting ending days_passed days_remaining]
   calculates how much money is is needed based for the remaining days
   [days_remaining] on the users current spending rate as given by their
   starting balance [starting], current balance [ending], over days passed
   [days_passed] *)
let calculate_money_needed starting ending days_passed days_remaining =
  let rate = rate_of_spending starting ending days_passed in
  let days_until_broke = days_until_broke starting ending days_passed in
  let broke_days = days_remaining -. days_until_broke in
  let money_needed = broke_days *. rate in
  money_needed

(* [allocate_by_category total_spent category_spent current] calculates how much
   of the remaining balance [current] needs to be allocated to a specific
   category given by the total money spent [total_spent] and money spent in that
   specific category [category_spent]*)
let allocate_by_category total_spent category_spent current =
  let percentage = calculate_percentages_category total_spent category_spent in
  let recommendation = current *. percentage in
  recommendation

(* [consistent_day starting ending day_spent days_passed] returns whether or not
   a days spending [day_spent] is close to previous daily spending rate based on
   starting balance [starting] current balance [ending] and days passed
   [days_passed] *)
let consistent_day starting ending day_spent days_passed =
  let rate = rate_of_spending starting ending days_passed in
  let truth = day_spent -. rate < 10. || day_spent -. rate > -10. in
  truth

(* [you're_broke balance target] returns true if you're balance is below the
   target and false if it is above*)
let you're_broke balance target = balance < target

(* [calculate_remaining_money starting ending days_passed days_remaining]
   calculates the estimated money remaining at the end of [days_remaining] based
   on the rate of spending as given by starting balance [starting] current
   balance [ending] and days passed [days_passed] *)
let calculate_remaining_money starting ending days_passed days_remaining =
  let rate = rate_of_spending starting ending days_passed in
  let estimated_future_spent = rate *. days_remaining in
  let estimated_remaining = ending -. estimated_future_spent in
  estimated_remaining
