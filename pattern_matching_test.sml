val test1_a = all_except_option("string", ["string"]) = SOME []
val test1_b = all_except_option("string", []) = NONE
val test1_c = all_except_option("int", ["string"]) = NONE
val test1_d = all_except_option("string", ["string", "int"]) = SOME ["int"]
val test1_e = all_except_option("string", ["float","string", "int"]) = SOME ["float","int"]

val test2_a = get_substitutions1([["foo"],["there"]], "foo") = []
val test2_b = get_substitutions1([["foo"],[]], "foo") = []
val test2_c = get_substitutions1([[],[]], "foo") = []
val test2_d = get_substitutions1([[],["foo"]], "foo") = []
val test2_e = get_substitutions1([["Fred", "Fredrick"],["Betty", "Elizabeth"],["Freddie","Fred","F"]], "Fred") = ["Fredrick", "Freddie","F"]


val test3_a = get_substitutions2([["foo"],["there"]], "foo") = []
val test3_b = get_substitutions1([["foo"],[]], "foo") = []
val test3_c = get_substitutions1([[],[]], "foo") = []
val test3_d = get_substitutions1([[],["foo"]], "foo") = []
val test3_e = get_substitutions1([["Fred", "Fredrick"],["Betty", "Elizabeth"],["Freddie","Fred","F"]], "Fred") = ["Fredrick", "Freddie","F"]

val test4_a = similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) =
	    [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"},
	     {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}]
val test4_b = similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"],["John"]], {first="Fred", middle="W", last="Smith"}) =
	    [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"},
	     {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}]

         
val test5_a = card_color((Clubs, Num 2)) = Black
val test5_b = card_color((Spades, Ace)) = Black
val test5_c = card_color((Diamonds, Queen)) = Red
val test5_d = card_color((Hearts, Jack)) = Red

val test6_a = card_value((Clubs, Num 2)) = 2
val test6_b = card_value((Clubs, Num 3)) = 3
val test6_c = card_value((Clubs, Num 4)) = 4
val test6_d = card_value((Clubs, Num 5)) = 5
val test6_e = card_value((Clubs, Num 6)) = 6
val test6_f = card_value((Clubs, Num 7)) = 7
val test6_g = card_value((Clubs, Num 8)) = 8
val test6_h = card_value((Clubs, Num 9)) = 9
val test6_i = card_value((Clubs, Num 10)) = 10
val test6_j = card_value((Clubs, Jack)) = 10
val test6_k = card_value((Clubs, Queen)) = 10
val test6_l = card_value((Clubs, King)) = 10
val test6_m = card_value((Clubs, Ace)) = 11

val test7_a = remove_card([(Hearts, Ace)], (Hearts, Ace), IllegalMove) = []
val test7_b = remove_card([(Hearts, Ace),(Hearts, King)], (Hearts, Ace), IllegalMove) = [(Hearts, King)]

val test8_a = all_same_color([(Hearts, Ace), (Hearts, Ace)]) = true
val test8_b = all_same_color([(Hearts, Ace), (Hearts, King), (Hearts, Ace), (Hearts, Num 10)]) = true
val test8_c = all_same_color([(Hearts, Ace), (Spades, Ace), (Hearts, Ace), (Hearts, Ace)]) = false
val test8_c = all_same_color([]) = true

val test9_a = sum_cards([(Clubs, Num 2),(Clubs, Num 2)]) = 4
val test9_b = sum_cards([]) = 0
val test9_c = sum_cards([(Clubs, Num 2),(Clubs, Ace)]) = 15
val test9_d = sum_cards([(Clubs, King),(Clubs, Num 2)]) = 14
val test9_e = sum_cards([(Clubs, Queen),(Clubs, Jack),(Clubs, Ace),(Clubs, Num 10),(Clubs, King)]) = 51

val test10_a = score([(Hearts, Num 2),(Clubs, Num 4)],10) = 4
val test10_a = score([],10) = 5
val test10_a = score([(Hearts, Num 2),(Hearts, Num 4)],10) = 2
val test10_a = score([(Clubs, Queen),(Clubs, Jack),(Clubs, Ace),(Clubs, Num 10),(Clubs, King)],10) = 20
val test10_a = score([(Clubs, Queen),(Clubs, Jack),(Spades, Ace),(Clubs, Num 10),(Clubs, King)],10) = 123

