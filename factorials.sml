(* returns the product of all elements in an integer list *)
fun list_product(xl : int list) = 
    if null xl
    then 1
    else hd xl * list_product(tl xl)
    
fun countdown(n : int) =
    if n = 0
    then []
    else n :: countdown(n-1)

(* the factorial function with a simple integer *)
fun factorial(n : int) =
    if n = 0
    then 1
    else n * factorial(n-1)

(* the factorial function using list-functions *)
fun factorial_list(n : int) = 
    list_product(countdown(n))
    
val x = factorial(7) (* 5040 *)
val y = factorial_list(7) (* 5040 *)