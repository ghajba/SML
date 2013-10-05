(* returns the product of all elements in an integer list *)
fun list_product(xl : int list) = 
    if null xl
    then 1
    else hd xl * list_product(tl xl)
    
val x = list_product [];
val y = list_product [5];
val z = list_product [2,4,2];
