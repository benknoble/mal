structure Step1_Repl : REPL = struct
  fun read (s : string) = s
  fun eval s = s
  fun print s = s

  val rep = print o eval o read

  local
    structure C = Console
    structure T = Tokens
  in
    fun repl () =
      let
        val instrm = Lexer.streamifyInstream C.stdIn
        val sm = AntlrStreamPos.mkSourcemap ()
        val lexer = Lexer.lex sm
        fun lex strm = lexer strm
        fun loop strm =
          case lex strm
            of (T.EOF, _, _) => ()
             | (t, _, strm') => (C.print (T.toString t); loop strm')
      in
        loop instrm
      end
  end
end
