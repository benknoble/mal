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
end
