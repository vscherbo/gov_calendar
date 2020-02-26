CREATE OR REPLACE FUNCTION arc_energo.bill_valid_until(arg_bill_created timestamp without time zone, arg_num_days integer)
 RETURNS date
 LANGUAGE plpgsql
AS $function$
DECLARE
cnt integer := 0;
next_date date;
BEGIN
    next_date := date_trunc('day', arg_bill_created);
    WHILE cnt < arg_num_days LOOP
       next_date := next_date + '1 day'::INTERVAL;
       CONTINUE WHEN is_gov_holiday(next_date); -- extract(isodow FROM start_date::timestamp) > 5;
       cnt := cnt + 1;
       -- raise notice 'cnt=%, next_date=%', cnt, next_date;
    END LOOP;
    RETURN next_date;
end 
$function$;
