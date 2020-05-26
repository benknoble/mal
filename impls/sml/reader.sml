structure Reader = struct

  structure Parser = ParseFn (Lexer)

  exception ParseErrors of string list

  fun readString s =
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
end
