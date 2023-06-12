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

-- 別解
SELECT
  E1.emp -- 社員を取り出す
FROM
  /* EmpSkillsにSkillsテーブルを外部結合する、
     EmpSkillsテーブルのうちSkillsテーブルにない言語はNULLになる*/
  EmpSkills AS E1
  LEFT OUTER JOIN Skills AS S1 ON E1.skill = S1.skill
WHERE
  -- 二つのスキルが一致している部分を取り出す
  E1.skill = S1.skill
-- 社員ごとにグループ化する
GROUP BY
  E1.emp
-- それぞれの数が一致する社員はだれか
HAVING
  -- 社員ごとのグループからスキルの数を数える
  COUNT(*) = (
    SELECT
      -- スキルテーブルの技術数を数える
      COUNT(skill)
    -- スキルテーブルから
    FROM
      Skills AS S2
  );
