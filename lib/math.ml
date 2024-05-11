(* @author Khoa Nguyen (ktn9) Kyle Chu (kgc42) Vail Chen (vac68) *)

let () = Random.self_init ()

(* average [lst] returns the average value of the entries in [lst] *)
let rec average (lst : float list) : float =
  match lst with
  | [] -> 0.0
  | _ ->
      let sum = List.fold_left ( +. ) 0.0 lst in
      let count = float_of_int (List.length lst) in
      sum /. count

(* spread [remaining] [days] divides [remaining] by [days]*)
let spread remaining days = remaining /. days
let spread remaining days rate = spread remaining (days /. rate)
