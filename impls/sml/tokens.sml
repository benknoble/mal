structure Tokens = struct
  datatype token = EOF
                 (* punctutation *)
                 | LParen | RParen
                 | LSquare | RSquare
                 | LCurly | RCurly
                 | Quote | Backtick
                 | Splice
                 | Tilde
                 | At
                 | Caret
                 (* comments *)
                 | CommentStart | CommentEnd
                 (* regular program text *)
                 | StringStart | StringEnd
                 | Char of char
                 | Num of int
                 | True | False
                 | Nil

  fun toString t =
    case t
      of LParen => "(" | RParen => ")"
       | LSquare => "[" | RSquare => "]"
       | LCurly => "{" | RCurly => "}"
       | Quote => "'" | Backtick => "`"
       | Splice => "~@"
       | Tilde => "~"
       | At => "@"
       | Caret => "^"
       | CommentStart => ";" | CommentEnd => "\n"
       | StringStart => "\"" | StringEnd => "\""
       | Char c => Char.toString c
       | Num i => Int.toString i
       | True => "true" | False => "false"
       | Nil => "nil"
       | EOF => "eof"
end
