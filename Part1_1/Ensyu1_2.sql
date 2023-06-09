SELECT
	CASE
		WHEN sex = 1 THEN '男'
		ELSE '女' END AS'性別',
	SUM(population) AS '全国',
	SUM(CASE pref_name WHEN '徳島' THEN population ELSE NULL END) AS '徳島',
	SUM(CASE pref_name WHEN '香川' THEN population ELSE NULL END) AS '香川',
	SUM(CASE pref_name WHEN '愛媛' THEN population ELSE NULL END) AS '愛媛',
	SUM(CASE pref_name WHEN '高知' THEN population ELSE NULL END) AS '高知',
	SUM(CASE WHEN pref_name IN ('徳島','香川','愛媛','高知') THEN population ELSE NULL END ) AS '四国'
FROM
	PopTbl2
GROUP BY
	sex
;
