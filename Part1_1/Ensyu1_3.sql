SELECT
	key_name AS 'key'
FROM
	greatests
ORDER BY
	CASE key_name
	 WHEN 'B' THEN 1
	 WHEN 'A' THEN 2
	 WHEN 'D' THEN 3
	 WHEN 'C' THEN 4 
	 ELSE NULL END
;
