-- ウィンドウ関数を使う場合
SELECT
	prc_date AS 処理日,
	prc_amt  AS 処理金額,
	CASE 
		-- レコード数が3行に満たないときはNULL
		WHEN cnt < 3 THEN NULL
		-- そうでなければ平均を取得する
		ELSE avg END AS '移動平均'
FROM 
	(SELECT 
		prc_date,
		prc_amt,
		AVG(prc_amt)
		-- 処理日をもとにフレームを移動させる
		OVER(ORDER BY prc_date 
			-- 現在の行の２個前の行
			ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
			 )AS avg, -- このフレームで求めた平均
		COUNT(*) -- レコード数を数える
		OVER(ORDER BY prc_date
			ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
			)AS cnt
	FROM
		Accounts
	)as aaa
;

--相関サブクエリ

SELECT 
	prc_date AS 処理日,
	A1.prc_amt AS 処理金額,
	(SELECT
		AVG(prc_amt)
	FROM
		Accounts  AS A2
	WHERE
		A1.prc_date >= A2.prc_date
	AND
		(SELECT 
			COUNT(*)
		FROM 
			Accounts AS A3
		WHERE -- レコードの範囲
			A3.prc_date BETWEEN A2.prc_date AND A1.prc_date
		)<= 3
	HAVING 
		COUNT(*) = 3 -- レコード数が３の時
	)AS '移動平均'
FROM
	Accounts AS A1
ORDER BY 
	prc_date
;
