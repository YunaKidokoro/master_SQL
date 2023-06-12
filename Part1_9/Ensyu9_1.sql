-- 行数が分からない場合のSQL
SELECT
	CASE WHEN (-- UNIONで統合した行数と個々テーブルの行数を比較する
			   count(*) = (select count(*) FROM tbl_A)
			   AND
		 	   count(*) = (SELECT COUNT(*) FROM tbl_B)
		 	  )
		 -- それぞれの行数が等しいならば等しいテーブル
		 THEN '等しい'
		 -- 異なる場合は違うテーブル
		 ELSE '等しくない' END AS compare
FROM
	-- ２つのテーブルを重複を排除して統合する
	(SELECT
		*
	FROM
		tbl_A
	UNION
	SELECT
		*
	FROM
		tbl_B
	)TMP
;
		
-- あらかじめ行数が分かっている場合
SELECT
	COUNT(*) AS row_cnt
FROM
	(
		SELECT
			*
		FROM
			tbl_A
	UNION
		SELECT
			*
		FROM
			tbl_B
	)TMP
;
