SELECT * FROM full_number_counts WHERE numbers NOT IN (SELECT numbers FROM pick_threes WHERE drawing_date > NOW() - INTERVAL '500 days')