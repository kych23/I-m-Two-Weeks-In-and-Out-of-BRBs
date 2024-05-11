type transaction = {
  id : int;
  date : string;
  amount : float;
  category : string;
}

let create_transaction id date amount category = { id; date; amount; category }
