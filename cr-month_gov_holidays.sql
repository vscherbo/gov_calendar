CREATE OR REPLACE FUNCTION arc_energo.month_gov_holidays(arg_date date)
 RETURNS text[]
 LANGUAGE plpgsql
AS $function$
declare
loc_sql text;
loc_year_col text := 'Год/Месяц';
loc_delimiter text := ',';
loc_asterisk text := '*';
loc_empty text := '';
loc_valid_days text := '[^0-9,*]'; -- * предпраздничный
loc_res text[];
--arg_date date := '2020-02-01';
arg_year text;
arg_month_name text;
begin
    arg_month_name := to_char(arg_date, 'TMMonth');
    arg_year := extract(year FROM arg_date);
        
    loc_sql := format('select 
regexp_split_to_array(
regexp_replace(
    regexp_replace(ask_month, %s, %s, ''g''::text)
,''\d*\*'', ''-1'', ''g''::text)
, %s)::text[]
    from (select values->>%s as year, values->>%s as ask_month                   
    from (select json_array_elements(values::json) as values from gov_holiday_json) j) ym WHERE year=%s;',
    quote_literal(loc_valid_days)                                                
    , quote_literal(loc_empty)                                                   
    , quote_literal(loc_delimiter)                                               
    , quote_literal(loc_year_col)                                                
    , quote_literal(arg_month_name)                                              
    , quote_literal(arg_year));                                                  

    raise notice 'loc_sql=%', loc_sql;
    EXECUTE loc_sql INTO loc_res;
    loc_res := array_remove(loc_res, '-1');
    raise notice '%', loc_res;
    return loc_res;
end;
$function$
;
