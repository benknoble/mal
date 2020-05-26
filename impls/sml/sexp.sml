structure Sexp = struct
  datatype form = Nil
                | Symbol of Atom.atom
                | Bool of bool
                | Num of int
                | String of string
                | List of form list

  val sym : string -> form = Symbol o Atom.atom

  fun toString sexp =
    case sexp
      of Nil => "nil"
       | Symbol a => Atom.toString a
       | Bool b => Bool.toString b
       | Num n => (if n < 0 then "-" else "") ^ (Int.toString (abs n))
       | String s => "\"" ^ s ^ "\""
       | List sexps =>
           let
             val inner_strings = map toString sexps
             val inner = String.concatWith " " inner_strings
           in
             "(" ^ inner ^ ")"
           end

end
