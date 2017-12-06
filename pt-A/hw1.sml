fun is_older ((y1 : int, m1 : int, d1 : int), (y2 : int, m2 : int, d2 : int)) =
    if y1 < y2
    then true
    else if y1 > y2
    then false
    else if m1 < m2
    then true
    else if m1 > m2
    then false
    else if d1 < d2
    then true
    else false

fun is_older_experimental ((y1 : int, m1 : int, d1 : int), (y2 : int, m2 : int, d2 : int)) =
    (y1 * 365 + m1 * )
