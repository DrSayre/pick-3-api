SELECT second_ball, count(*) AS quanity, max(drawing_date) AS last_draw FROM pick_threes WHERE drawing_date > NOW() - INTERVAL '1000 days' GROUP BY second_ball ORDER BY second_ball;