structure Step1_Repl = struct

  structure C = Console

  val read = Reader.readString
  fun eval s = s
  fun print s = Sexp.toString s

  val rep = print o eval o read

  fun repl () =
    ( C.print "user> "
    ; case C.getln ()
        of C.EOF => ()
         | C.Line line => (C.println (rep line); repl ()))
    handle Reader.ParseErrors msgs =>
      ( C.println (String.concatWith "\n" msgs)
      ; repl ())
end
