open! Import

module Word = struct
  type t =
    { id : int
    ; col : int
    ; row : int
    ; line_offset : int
    ; word : string
    ; typed : string
    ; state : [ `New | `Pending | `Active | `Success | `Failure ]
    }
  [@@deriving sexp]
end

type t = Word.t list [@@deriving sexp]

let col_row_of_cursor (t : t) ~cursor =
  let wordnum, offset = Cursor.id_offset cursor in
  List.find_map t ~f:(fun word ->
    if wordnum = word.id
    then
      Some
        ( word.line_offset
          + Int.max offset (Int.min (String.length word.word) (String.length word.typed))
        , word.row )
    else None)
;;
