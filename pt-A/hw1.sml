fun is_older ((y1 : int, m1 : int, d1 : int), (y2 : int, m2 : int, d2 : int)) =
    (y1 * 360 + m1 * 30 + d1) < (y2 * 360 + m2 * 30 + d2)

fun number_in_month (dates : (int * int * int) list, month : int) =
    if null dates then 0
    else
        let fun check (date : int * int * int) = #2 date = month
        in
            (if check (hd dates) then 1 else 0) + number_in_month (tl dates, month)
        end

fun number_in_months (dates : (int * int * int) list, months : int list) =
    if null months then 0
    else
        number_in_month (dates, hd months) + number_in_months (dates, tl months)

fun dates_in_month (dates : (int * int * int) list, month : int) =
    if null dates then []
    else
        let
            fun check (date : int * int * int) = #2 date = month
        in
            if check (hd dates)
            then hd dates :: dates_in_month (tl dates, month)
            else dates_in_month (tl dates, month)
        end

fun dates_in_months (dates : (int * int * int) list, months : int list) =
    if null months then []
    else
        dates_in_month (dates, hd months) @ dates_in_months (dates, tl months)

fun get_nth (strList : string list, n : int) =
    if n = 1 then hd strList
    else get_nth (tl strList, n - 1)

fun date_to_string ((year : int, month : int, day : int)) =
    let val months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    in
      get_nth(months, month) ^ " " ^ Int.toString (day) ^ ", " ^ Int.toString (year)
    end

fun number_before_reaching_sum (sum : int, nums : int list) =
    let
        fun recursive ((mySum : int, myIndex : int), myList) =
            let val newSum = mySum + hd myList
            in
                if newSum >= sum then myIndex
                else recursive ((newSum, myIndex + 1), tl myList)
            end
    in
        recursive((0, 0), nums)
    end

fun what_month (day : int) =
    let val days_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    in
        number_before_reaching_sum (day, days_in_months) + 1
    end

fun month_range (from : int, to : int) =
    if from > to then []
    else what_month (from) :: month_range (from + 1, to)

fun oldest (dates : (int * int * int) list) =
    if null dates then NONE
    else
        let
            fun recursive (x : (int * int * int), xs : (int * int * int) list) =
                if null xs then x
                else
                    recursive (
                        if is_older (hd xs, x) then hd xs else x,
                        tl xs
                    )
        in
            SOME (recursive (hd dates, tl dates))
        end

fun number_in_months_challenge (dates : (int * int * int) list, months : int list) =
    let
        fun search (element : int, source : int list) =
            if null source
            then false
            else if element = hd source
            then true
            else search (element, tl source)

        fun clean (src : int list, cleaned : int list) =
            if null src
            then cleaned
            else clean (
                tl src,
                if search (hd src, cleaned) then cleaned else cleaned @ [hd src]
            )
    in
        number_in_months (dates, clean (months, []))
    end

fun dates_in_months_challenge (dates : (int * int * int) list, months : int list) =
    let
        fun search (element : int, source : int list) =
            if null source
            then false
            else if element = hd source
            then true
            else search (element, tl source)

        fun clean (src : int list, cleaned : int list) =
            if null src
            then cleaned
            else clean (
                tl src,
                if search (hd src, cleaned) then cleaned else cleaned @ [hd src]
            )
    in
        dates_in_months (dates, clean (months, []))
    end

fun reasonable_date ((y : int, m : int, d : int)) =
    if y < 1 orelse m < 1 orelse m > 12 orelse d < 1 orelse d > 31
    then false
    else
        let
            val is_leap_year = y mod 4 = 0
            val days_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
            val days_in_months_leap = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
            fun get_nth (mons : int list, n : int) =
                if n = 1 then hd mons
                else get_nth (tl mons, n - 1)
        in
            d <= get_nth ((if is_leap_year then days_in_months_leap else days_in_months), m)
        end