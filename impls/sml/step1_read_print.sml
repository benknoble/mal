structure Step1_Repl = struct

  structure Parser = ParseFn (Lexer)
  structure C = Console

  exception ParseErrors of string list

  fun read s =
    let
      val strm = Lexer.streamifyInstream (TextIO.openString s)
      val sm = AntlrStreamPos.mkSourcemap ()
      val lexer = Lexer.lex sm
      val (res, _, repairs) = Parser.parse lexer strm
      val error_messages = map (AntlrRepair.repairToString Tokens.toString sm) repairs
    in
      case repairs
        of _::_ => raise ParseErrors error_messages
         | [] => case res
                   of NONE => raise ParseErrors ["unrepairable parse error"]
                              (* never observed this error in practice *)
                    | SOME s => s
    end
  fun eval s = s
  fun print s = Sexp.toString s

  val rep = print o eval o read

  fun repl () =
    ( C.print "user> "
    ; case C.getln ()
        of C.EOF => ()
         | C.Line line => (C.println (rep line); repl ()))
    handle ParseErrors msgs =>
      ( C.println (String.concatWith "\n" msgs)
      ; repl ())
end
