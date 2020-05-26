%name Lexer;

%let ws = [ \n\t,];
%let newline = "\n";

%let comment_start = ";";
%let comment_char = [^\n];

%let digit = [0-9];
%let int = -?{digit}+;

%let reserved = ( {ws} | "[" | "]" | [@~(){}'"`;] );
%let idchar = ~{reserved} & .;
%let id = {idchar}+;

%let doublequote = ["];
%let escape_sequence = "\\" ([n"] | "\\");

%states STRING COMMENT;

%defs (
  structure T = Tokens
  type lex_result = T.token
  fun eof () = T.EOF
  fun char1 str = T.Char (String.sub (str, 0))
  val num = T.Num o valOf o Int.fromString
);

(* skip whitespace *)
<INITIAL> {ws} => ( continue() );

(* comments *)
<INITIAL> {comment_start} => ( YYBEGIN COMMENT ; continue() );
<COMMENT> {comment_char} => ( continue() );
<COMMENT> {newline} => ( YYBEGIN INITIAL ; continue() );

(* special characters *)
<INITIAL> "(" => ( T.LParen );
<INITIAL> ")" => ( T.RParen );
<INITIAL> "[" => ( T.LSquare );
<INITIAL> "]" => ( T.RSquare );
<INITIAL> "{" => ( T.LCurly );
<INITIAL> "}" => ( T.RCurly );
<INITIAL> "'" => ( T.Quote );
<INITIAL> "`" => ( T.Backtick );
<INITIAL> "~@" => ( T.Splice );
<INITIAL> "~" => ( T.Tilde );
<INITIAL> "@" => ( T.At );
<INITIAL> "^" => ( T.Caret );

(* regular program text *)
<INITIAL> {int} => ( num yytext );
<INITIAL> true => ( T.True );
<INITIAL> false => ( T.False );
<INITIAL> nil => ( T.Nil );
<INITIAL> {id} => ( T.ID yytext );

(* strings *)
<INITIAL> {doublequote} => ( YYBEGIN STRING ; T.DoubleQuote );
<STRING> {escape_sequence} => (
  let val escaped = String.sub (yytext, 1)
  in case escaped
    of #"n" => T.Char #"\n"
     | c => T.Char c
  end
);
<STRING> {doublequote} => ( YYBEGIN INITIAL ; T.DoubleQuote );
<STRING> . => ( char1 yytext );
