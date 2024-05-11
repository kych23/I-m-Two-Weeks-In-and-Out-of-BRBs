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
(* let rec average_list (lst : float list) : float = let summation = sum lst in
   let number = float_of_int (List.length lst) in if summation = 0.0 then 0.0
   else summation /. number *)

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
