
fun same_string(s1 : string, s2 : string) =
    s1 = s2

fun all_except_option(str, str_lst) = 
     case str_lst of
        [] => NONE
        | x::xs => if same_string(x, str) 
            then
            SOME xs
            else
            case all_except_option(str, xs) of
                NONE => NONE
                | SOME y=> SOME (x::y) 

fun get_substitutions1(lst, s) = 
    case lst of 
      [] => []
      | x::xs => case all_except_option(s, x) of
                NONE => get_substitutions1(xs,s)
              | SOME y => y @ get_substitutions1(xs,s)
              
              
fun get_substitutions2(lst, s)=
    let
        fun aux(lst, s, acc) = 
            case lst of 
                [] => acc
              | x::xs => case all_except_option(s, x) of
                      NONE => aux(xs,s, acc)
                      | SOME y => aux(xs, s, acc @ y)
    in
        aux(lst,s,[])
    end
    
fun similar_names(lst, full_name : {first:string,middle:string,last:string})=
    let fun replace_first_names(names) =
        case names of
            [] => []
            | name::names' => case full_name of
                { first = f, middle = m, last = l } => [{ first = name, middle = m, last = l }] @replace_first_names(names')
        fun first_name() =
            case full_name of
                { first = f, middle = m, last = l } => f
    in
        case get_substitutions2(lst, first_name()) of
            [] => [full_name]
            | matched_names => [full_name] @ replace_first_names(matched_names)
    end 
                

datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

fun card_color(c)=
    case c of
        (Clubs,_) => Black
      | (Spades,_) => Black
      | _ => Red
      
fun card_value(c) =
    case c of
        (_, Num i) => i
      | (_, Ace) => 11
      | _ => 10
      
fun remove_card(cs, c, e)=
    let 
        fun all_except_card(cs, acc) =
            case cs of
            [] => raise e
            | card1::cs' => if card1 = c
                then acc @ cs'
                else all_except_card(cs', acc @ [card1])
    in
        all_except_card(cs, [])
    end 
    
fun all_same_color(cs)=
     let 
        fun aux (lst : card list, clr : color)=
            case lst of
                [] => true
                | x::xs => case clr = card_color(x) of
                    true => aux(xs, clr)
                    | _ => false
    in
        case cs of
            [] => true
            | x::xs => aux(xs, card_color(x))
    end
    
    
fun sum_cards(cs) = 
    let 
        fun aux(cs,acc)=
            case cs of
            [] => acc
            | x::xs => aux(xs,acc+card_value(x))
    in
        aux(cs,0)
    end
    
fun score(cs,goal)=
    let
        sum = sum_cards(cs)
        if sum > goal
        then
            psc = (sum-goal)*3
        else
            psc = (goal-sum)
    in
        if all_same_color(cs)
        then psc div 2
        else psc
    end
    
fun officiate(cs, ms, goal)=
    let
        fun game(cs,hcs,ms,goal) = 
            case ms of
            [] => score(hcs, goal)
            | m::xs => case m of 
                        Draw => case cs of
                            [] = > score(hcs, goal)
                            | dc::rcs => if sum_cards(dc::hcs) > goal then score(hcs, goal) else game(rcs,dc::hcs,xs,goal)
                        | Discard c => game(cs,remove_card(hcs,c,IllegalMove),xs,goal)
    in
        game(cs,[],ms,goal)
    end