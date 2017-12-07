(* destructured variables from function arguments *)
fun is_older (
        (y1 : int, m1 : int, d1 : int),
        (y2 : int, m2 : int, d2 : int)
    ) =
    (* comparing the total number of days of both dates *)
    (y1 * 360 + m1 * 30 + d1) < (y2 * 360 + m2 * 30 + d2)

fun number_in_month (dates : (int * int * int) list, month : int) =
    let
        fun check_equality (date : int * int * int) =
            if #2 date = month then SOME else NONE
    in
        if null (tl dates)
        then check_equality (hd dates)
        else check_equality (hd dates) + number_in_month(tl dates, month)
    end
