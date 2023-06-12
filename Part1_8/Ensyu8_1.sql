SELECT 
	MASTER.age_class AS age_class,
	MASTER.sex_cd AS sex_cd,
	SUM(CASE WHEN pref_name IN ('青森', '秋田')
			 THEN population ELSE NULL END
		) AS pop_tohoku,
	SUM(CASE WHEN pref_name IN ('東京', '千葉')
			 THEN population ELSE NULL END
		) AS pop_kanto
FROM
	(SELECT
		age_class,
		sex_cd
	FROM
		TblAge
	CROSS JOIN
		TblSex
	)MASTER
		
	LEFT OUTER JOIN
		TblPop AS DATA
	ON
		MASTER.age_class = DATA.age_class
	AND 
		MASTER.sex_cd = DATA.sex_cd
GROUP BY
	MASTER.age_class,
	MASTER.sex_cd
ORDER BY
	age_class ASC,
	sex_cd DESC
;
