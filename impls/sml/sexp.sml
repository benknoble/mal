structure Sexp = struct
  datatype form = Symbol of Atom.atom
                | Bool of bool
                | Num of int
                | String of string
                | List of form list
end
