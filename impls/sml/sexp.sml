structure Sexp = struct
  datatype form = Symbol of Atom.atom
                | Bool of bool
                | Num of int
                | String of string
                | List of form list

  fun toString sexp =
    case sexp
      of Symbol a => Atom.toString a
       | Bool b => Bool.toString b
       | Num n => Int.toString n
       | String s => "\"" ^ s ^ "\""
       | List sexps =>
           let
             val inner_strings = map toString sexps
             val inner = String.concatWith " " inner_strings
           in
             "(" ^ inner ^ ")"
           end

end
