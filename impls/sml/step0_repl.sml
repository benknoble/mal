signature REPL = sig
  val read : string -> string
  val eval : string -> string
  val print : string -> string
  val rep : string -> string

  val repl : unit -> unit
end

structure Repl : REPL = struct
  fun read (s : string) = s
  fun eval s = s
  fun print s = s

  val rep = print o eval o read

  local
    structure C = Console
  in
  fun repl () =
    (
    C.print "user> "
    ; case C.getln ()
        of C.EOF => ()
         | C.Line line => (C.print (rep line); repl ())
    )
  end
end
