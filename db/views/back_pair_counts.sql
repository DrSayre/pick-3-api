SELECT back_pair, count(*) AS quanity, max(drawing_date) AS last_draw FROM pick_threes GROUP BY back_pair ORDER BY back_pair;