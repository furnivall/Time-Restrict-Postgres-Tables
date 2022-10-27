CREATE OR REPLACE FUNCTION time_restrict()
    RETURNS TABLE
--     our implementation was focused to control access to a materialized view but feel free to utilise any view or table you like here.
-- if the LIKE statement is not used, you will need to include each column name individually
            (LIKE your_mat_view_here)
--  The below line allows the function executor to inherit the permissions of the creator (within the scope of the function alone).
    SECURITY DEFINER
as
$$
    BEGIN
--     logic can be altered for your given date parameters using postgres date functions. 
-- Importantly, the solution works based on the local time of the postgres instance (including timezone)
    IF extract(hour FROM date_trunc('hour', now())) BETWEEN 16 and 20 THEN
        RETURN;
    ELSE
        RETURN QUERY
            SELECT * from your_mat_view_here;
    END IF;
    END
-- $$ LANGUAGE plpgsql;
