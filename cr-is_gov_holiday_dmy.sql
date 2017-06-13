CREATE OR REPLACE FUNCTION arc_energo.is_gov_holiday_dmy(arg_day text, arg_month_name text, arg_year text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare 
loc_sql text;
loc_year_col text := 'Год/Месяц';
loc_delimiter text := ',';
loc_asterisk text = '*';
loc_empty text = '';
loc_res BOOLEAN;
BEGIN
    loc_sql := format('select ARRAY[%s]::text[] <@ regexp_split_to_array(replace(ask_month, %s, %s), %s)::text[] 
    from (select values->>%s as year, values->>%s as ask_month 
    from (select json_array_elements(values::json) as values from gov_holiday_json) j) ym WHERE year=%s;',
    arg_day
    , quote_literal(loc_asterisk)
    , quote_literal(loc_empty)
    , quote_literal(loc_delimiter)
    , quote_literal(loc_year_col)
    , quote_literal(arg_month_name)
    , quote_literal(arg_year));
    -- raise notice 'loc_sql=%', loc_sql;
    EXECUTE loc_sql INTO loc_res;
    RETURN loc_res;
END  
$function$;

