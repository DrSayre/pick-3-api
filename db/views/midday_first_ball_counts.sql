SELECT first_ball, count(*) AS quanity, max(drawing_date) AS last_draw FROM pick_threes WHERE drawing_time_id IN (SELECT id FROM drawing_times WHERE name ilike 'midday') GROUP BY first_ball ORDER BY first_ball;