structure Main = struct
  structure Proc = OS.Process
  type args = string * string list

  fun step0_repl (_ : args) : Proc.status =
    (
    Step0_Repl.repl ()
    ; Proc.success
    )
end
