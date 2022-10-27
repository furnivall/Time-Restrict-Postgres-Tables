CREATE OR REPLACE FUNCTION time_restrict()
    RETURNS TABLE
            (LIKE sdp_mat_view)
    SECURITY DEFINER
as
$$
    BEGIN
    IF extract(hour FROM date_trunc('hour', now())) BETWEEN 16 and 20 THEN
        RETURN;
    ELSE
        RETURN QUERY
            SELECT * from sdp_mat_view;
    END IF;
    END
-- $$ LANGUAGE plpgsql;