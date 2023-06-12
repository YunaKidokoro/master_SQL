SELECT
	*
FROM
	Projects AS p1
WHERE
	'ok'= ALL(
		SELECT CASE
			WHEN step_nbr <= 1 AND status = '完了' THEN 'ok'
			WHEN step_nbr >= 2 AND status = '待機' THEN 'ok'
			ELSE 'ng' END
		FROM
			Projects AS p2
		WHERE
			p1.project_id = p2.project_id
		)
;
