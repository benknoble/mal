signature CONSOLE = sig
  datatype input = EOF | Line of string

  val print : string -> unit
  val println : string -> unit
  val getln : unit -> input
  val printerr : string -> unit
  val printlnerr : string -> unit
  val stdIn : TextIO.instream
end

structure Console : CONSOLE = struct
  datatype input = EOF | Line of string

  val print = TextIO.print
  fun println s = print (s ^ "\n")
  fun printerr s = TextIO.output (TextIO.stdErr, s)
  fun printlnerr s = printerr (s ^ "\n")
  val stdIn = TextIO.stdIn
  fun getln () =
    case (TextIO.inputLine stdIn)
      of NONE => EOF
       | SOME line => Line line
end
