signature REPL = sig
  val read : string -> string
  val eval : string -> string
  val print : string -> string
  val rep : string -> string

  val repl : unit -> unit
end
