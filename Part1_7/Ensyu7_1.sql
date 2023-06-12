SELECT 
	prc_date AS 処理日,
	ac1.prc_amt AS 処理金額,
	(SELECT
		AVG(prc_amt)
	FROM
		Accounts  AS ac2
	WHERE
		(ac1.prc_date >= ac2.prc_date)
	AND
		(SELECT 
			COUNT(*)
		FROM 
			Accounts AS ac3
		WHERE
			ac3.prc_date BETWEEN ac2.prc_date AND ac1.prc_date)<= 3
	)AS '移動平均'
FROM
	Accounts AS ac1
ORDER BY 
	ac1.prc_date
;
