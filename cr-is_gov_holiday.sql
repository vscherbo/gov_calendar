CREATE OR REPLACE FUNCTION arc_energo.is_gov_holiday(arg_date date)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare 
loc_day text;
loc_month_name text;
loc_year text;
loc_res BOOLEAN;
BEGIN
    loc_day := extract(day FROM arg_date);
    loc_month_name := to_char(arg_date, 'TMMonth');
    loc_year := extract(year FROM arg_date);
    -- raise notice 'loc_day integer=%, loc_month_name=%, loc_year integer=%', loc_day, loc_month_name, loc_year;
    RETURN is_gov_holiday_dmy(loc_day, loc_month_name, loc_year);
END  
$function$
