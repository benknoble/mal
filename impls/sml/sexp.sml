structure Sexp : sig
  datatype form = Nil
                | Keyword of Atom.atom
                | Symbol of Atom.atom
                | Bool of bool
                | Num of int
                | String of string
                | List of form list
  datatype representation = AsCode | AsText

  val sym : string -> form
  val kw : string -> form
  val toString : representation -> form -> string
  val toReplString : form -> string
end = struct
  datatype form = Nil
                | Keyword of Atom.atom
                | Symbol of Atom.atom
                | Bool of bool
                | Num of int
                | String of string
                | List of form list

  datatype representation = AsCode | AsText

  val sym = Symbol o Atom.atom
  val kw = Keyword o Atom.atom

  fun mkDelimitedString {left, right} innerFun data =
    left ^ (innerFun data) ^ right

  fun mkStringToString rep s =
    let
      val delims = {left="\"", right="\""}
      fun makeReadable c =
        case c
          of #"\n" => [#"\\", #"n"]
           | #"\"" => [#"\\", #"\""]
           | #"\\" => [#"\\", #"\\"]
           | _ => [c]
      val pipeline = implode o List.concat o (map makeReadable) o explode
      val inner = (fn s => case rep
                             of AsCode => pipeline s
                              | AsText => s)
    in
      mkDelimitedString delims inner s
    end

  fun mkListLikeToString delims toString rep =
    let val innerFun = (String.concatWith " ") o (map (toString rep))
    in mkDelimitedString delims innerFun
    end

  fun mkListToString toString rep =
    mkListLikeToString {left="(", right=")"} toString rep

  fun toString rep sexp =
    let
      val listToString = mkListToString toString rep
      val stringToString = mkStringToString rep
    in
      case sexp
        of Nil => "nil"
         | Keyword k => ":" ^ Atom.toString k
         | Symbol s => Atom.toString s
         | Bool b => Bool.toString b
         | Num n => (if n < 0 then "-" else "") ^ (Int.toString (abs n))
         | String s => stringToString s
         | List sexps => listToString sexps
    end

  val toReplString = toString AsCode

end
