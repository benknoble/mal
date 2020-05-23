structure Step0_Repl : REPL = struct
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
