SELECT
	emp -- 社員
FROM
	EmpSkills AS ES1
WHERE
	NOT EXISTS
	(-- 技術テーブルから3種類の技術を取得
		SELECT
			skill
   		FROM
   			Skills
   	-- 差を求める
 	EXCEPT
 		-- 社員技術情報テーブルから技術を取得
		SELECT
			skill
		FROM
			EmpSkills AS ES2
		WHERE
			/*この行を追加しました*/
			ES1.emp = ES2.emp
	)
GROUP BY -- 社員ごとでグループ化する
	emp
/* グループ化したものに条件を付ける,
	ここでは社員ごとの技術情報数がスキルテーブルの技術数と等しいか*/
HAVING
	(
	-- 社員ごとの技術情報数
	COUNT(*) = 
		(
		-- スキルテーブルの技術数
		SELECT
			COUNT(*)
		FROM
			Skills
		)
	)
;

-- EmpSkillsテーブルから相田さん、Oracleのレコードを削除する
DELETE FROM
	EmpSkills
WHERE
	skill = 'Oracle'
	AND
	emp = '相田'
;
