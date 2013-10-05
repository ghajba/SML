(* append the list ys to the list of xs *)
fun append_list(xs : int list, ys : int list) = 
    if null xs
    then ys
    else (hd xs) :: append_list((tl xs), ys)
    
    
val x = append_list([],[])
val y = append_list([1,2],[])
val z = append_list([],[1,2,3])
val w = append_list([1,2,3,4],[5,6,7,8])
