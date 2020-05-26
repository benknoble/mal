structure Sexp = struct
  datatype form = Nil
                | Symbol of Atom.atom
                | Bool of bool
                | Num of int
                | String of string
                | List of form list

  datatype representation = AsCode | AsText

  val sym : string -> form = Symbol o Atom.atom

  fun toString rep sexp =
    case sexp
      of Nil => "nil"
       | Symbol a => Atom.toString a
       | Bool b => Bool.toString b
       | Num n => (if n < 0 then "-" else "") ^ (Int.toString (abs n))
       | String s =>
           let
             fun makeReadable c =
               case c
                 of #"\n" => [#"\\", #"n"]
                  | #"\"" => [#"\\", #"\""]
                  | #"\\" => [#"\\", #"\\"]
                  | _ => [c]
             val pipeline = implode o List.concat o (map makeReadable) o explode
             val inner = case rep
                           of AsCode => pipeline s
                            | AsText => s
           in
             "\"" ^ inner ^ "\""
           end
       | List sexps =>
           let
             val inner_strings = map (toString rep) sexps
             val inner = String.concatWith " " inner_strings
           in
             "(" ^ inner ^ ")"
           end

  val toReplString = toString AsCode

end
