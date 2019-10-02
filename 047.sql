/*Please add ; after each select statement*/
CREATE PROCEDURE localCalendar()
BEGIN
    SELECT 
        dataFormat.event_id,
        CASE dataFormat.hours 
        WHEN 24 THEN DATE_FORMAT(dataFormat.date, '%Y-%m-%d %H:%i')
        WHEN 12 THEN DATE_FORMAT(dataFormat.date, '%Y-%m-%d %h:%i %p')
        END as formatted_date
    FROM (
        SELECT 
        e.event_id,
        -- e.date,
        DATE_ADD(e.date, INTERVAL s.timeshift MINUTE) as date, -- formatted_date,
        s.hours,
        e.user_id
        FROM events e INNER JOIN settings s ON e.user_id = s.user_id
    ) dataFormat
    ORDER BY 
    dataFormat.event_id;
END