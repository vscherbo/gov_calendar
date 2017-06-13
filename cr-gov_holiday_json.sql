create table gov_holiday_json(values text);
-- wget http://data.gov.ru/api/json/dataset/7708660670-proizvcalendar/version/20151123T183036/content/?access_token=XXXXXXXXXXX -O res-version-20151123T183036-content.txt

-- sed ':a;N;$!ba;s/\n/ /g' res-version-20151123T183036-content.txt > json-version-20151123T183036-content.txt

-- \copy gov_holiday_json from json-version-20151123T183036-content.txt;

