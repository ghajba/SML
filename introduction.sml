fun is_older(pr1 : int*int*int, pr2 : int*int*int) =
    if(#1 pr1 < #1 pr2)
    then true
    else
        if(#1 pr1 = #1 pr2 andalso #2 pr1 < #2 pr2)
        then true
        else
            if(#2 pr1 = #2 pr2 andalso #3 pr1 < #3 pr2)
            then true
            else false
    
fun number_in_month(dates : (int*int*int) list, month : int) = 
    if null dates
    then 0
    else if #2(hd dates) = month
    then 1 + number_in_month(tl dates, month)
    else number_in_month(tl dates, month)
        
fun number_in_months(dates : (int*int*int) list, months : int list) = 
    if null months
    then 0
    else number_in_month(dates, hd months) + number_in_months(dates, tl months)
    
fun dates_in_month(dates : (int*int*int) list, month : int) = 
    if null dates
    then []
    else if #2(hd dates) = month
    then hd dates :: dates_in_month(tl dates, month)
    else dates_in_month(tl dates, month)
    
fun dates_in_months(dates : (int*int*int) list, months : int list) = 
    if null months
    then []
    else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)
    
fun get_nth(strings : string list, n : int) = 
    if null strings
    then ""
    else
        if n = 1
        then hd strings
        else get_nth(tl strings, n-1)
    
val month_names = ["January ","February ","March ","April ","May ","June ","July ","August ","September ","October ","November ","December "]
fun date_to_string(date : int * int * int) = 
    get_nth(month_names, #2date) ^ Int.toString(#3date) ^ ", " ^ Int.toString(#1date)
    
fun number_before_reaching_sum(sum : int, numbers : int list) = 
    let
        fun iterate_sum(i : int, sum : int, max : int, numbers : int list) =
            if sum + hd numbers >= max
            then i - 1
            else iterate_sum(i + 1, sum + hd numbers, max, tl numbers)
    in 
        if null numbers
        then 0
        else iterate_sum(1, 0, sum, numbers)
    end 
    
val days_in_months = [31,28,31,30,31,30,31,31,30,31,30,31]    
fun what_month(day : int) =
    if day = 0
    then 0
    else 1 + number_before_reaching_sum(day, days_in_months)
    
fun month_range(day1 : int, day2 : int) = 
    if day1 > day2
    then []
    else what_month(day1) :: month_range(day1+1,day2)
    
fun oldest(dates : (int*int*int) list) = 
    if null dates
    then NONE
    else
    	let 
            val tl_ans = oldest(tl dates)
        in 
            if(isSome tl_ans andalso is_older(valOf tl_ans, hd dates))
            then tl_ans
            else SOME(hd dates)
        end

 fun contains(values : int list, value : int) = 
    if null values
    then false
    else 
        if (hd values) = value
        then true
        else contains(tl values, value)

fun remove_duplicates(values : int list) = 
    if null values
    then []
    else 
        if contains(tl values, hd values)
        then remove_duplicates(tl values)
        else (hd values) :: remove_duplicates(tl values)
        
fun number_in_months_challenge(dates : (int*int*int) list, months : int list) = 
    number_in_months(dates, remove_duplicates months)
    
fun dates_in_months_challenge(dates : (int*int*int) list, months : int list) =
    dates_in_months(dates, remove_duplicates months)
    
fun reasonable_date(date : int*int*int) = 
    let
        val days_in_months_leap = [31,29,31,30,31,30,31,31,30,31,30,31]
        fun is_appropriate_date(date : int*int*int) = 
            if #1date > 0 andalso #2date > 0 andalso #2date < 13 andalso #3date > 0 andalso #3date < 32
            then true
            else false
        
        fun is_leap_year(year : int) =
            year mod 400 = 0 orelse year mod 100 <> 0 andalso year mod 4 = 0
            
        fun get_nth_int(int_list : int list, n : int) = 
            if null int_list
            then 0
            else
                if n = 1
                then hd int_list
                else get_nth_int(tl int_list, n-1)
    in
        if is_appropriate_date(date)
        then 
            if is_leap_year(#1date)
            then (#3date) <= get_nth_int(days_in_months_leap, (#2date))
            else (#3date) <= get_nth_int(days_in_months, (#2date))
        else false
    end

    

    