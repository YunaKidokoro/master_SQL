SELECT
	employee,
	COUNT(child) AS child_cnt
FROM
	(
	SELECT 
		employee,
		child_1 AS child
	FROM
		Personnel
	-- 重複を許さずに統合する
	UNION ALL
		SELECT
			employee,
			child_2 AS child
		FROM
			Personnel
	UNION ALL
		SELECT
			employee, 
			child_3 AS child
		FROM
			Personnel
	)x
GROUP BY
	employee
ORDER BY
	child_cnt DESC
;
