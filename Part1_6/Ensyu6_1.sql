SELECT 
	'歯抜けあり'AS gap
FROM
	SeqTbl
HAVING 
	-- 連番の最大値と連番を振った数が一致しないと歯抜けあり
	COUNT(*) <> MAX(seq)
-- 2つの結果を統合する
UNION ALL
	SELECT
		'歯抜けなし' AS gap
	FROM
		SeqTbl
	HAVING 
		-- 連番の最大値と連番を振った数が一致すれば歯抜けなし
		COUNT(*) = MAX(seq)
;

-- パフォーマンスが良い方法
SELECT
	CASE WHEN COUNT(*) <> MAX(seq)
		 THEN '歯抜けあり'
		 ELSE '歯抜けなし' END AS gap
FROM
	SeqTbl
;


-- はぬけなしを確認するためにレコード追加する
INSERT INTO SeqTbl
	(seq, name)
VALUES
	(4,'ゆな'),
	(7,'ほたか')
;
