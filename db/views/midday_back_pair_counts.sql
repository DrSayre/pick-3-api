SELECT back_pair, count(*) AS quanity, max(drawing_date) AS last_draw FROM pick_threes WHERE drawing_time_id IN (SELECT id FROM drawing_times WHERE name ilike 'midday') GROUP BY back_pair ORDER BY back_pair;