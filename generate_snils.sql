create or replace function generate_snils() returns text
    language plpgsql
as
$$
declare
digits     int[];
    multiplier int[] not null default array [9,8,7,6,5,4,3,2,1];
sum        int not null default 0;
    sumText    text;
    result     text;
    i          int default 1;
begin
    result := CAST(100000000 + floor(random() * 899999999) AS bigint)::text;
    digits := string_to_array(result, NULL)::int[];
sum := 0;
    i := 1;
    while multiplier[i] is not null
        loop
            sum := sum + multiplier[i] * digits[i];
            i := i + 1;
end loop;
    result := concat(result, replace(to_char(sum % 101 % 100, '09'), ' ', ''));
return result;
end;
$$;
