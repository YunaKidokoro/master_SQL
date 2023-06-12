SELECT
	dpt
FROM
	students
GROUP BY
	dpt
HAVING
	-- 学生の数と9月中に提出した人数が一致すれば学部全員が９月に提出済みになる
	COUNT(*) =
	-- 提出日が９月中のものを数える
	COUNT(sbmt_date between '2018-09-01' AND '2018-09-30'OR NULL)
;
