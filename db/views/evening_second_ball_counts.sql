SELECT second_ball, count(*) AS quanity, max(drawing_date) AS last_draw FROM pick_threes WHERE drawing_time_id IN (SELECT id FROM drawing_times WHERE name ilike 'evening') AND drawing_date > NOW() - INTERVAL '500 days' GROUP BY second_ball ORDER BY second_ball;