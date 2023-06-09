-- x,yの最大値を考える
SELECT
	key_name AS 'key',
	CASE 
		WHEN x>y THEN x
		ELSE y END AS 'greatest'
FROM
	greatests
;
-- x,y,zの最大値を考える
SELECT
	key_name AS 'key',
	CASE 
		WHEN x>y AND x>z THEN x
		WHEN y>z		 THEN y
		ELSE z END AS 'greatest'
FROM
	greatests
;
