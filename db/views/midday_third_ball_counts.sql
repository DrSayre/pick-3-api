SELECT third_ball, count(*) AS quanity, max(drawing_date) AS last_draw FROM pick_threes WHERE drawing_time_id IN (SELECT id FROM drawing_times WHERE name ilike 'midday') AND drawing_date > NOW() - INTERVAL '500 days' GROUP BY third_ball ORDER BY third_ball;