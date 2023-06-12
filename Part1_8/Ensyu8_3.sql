MERGE INTO
	Class_A AS ca
USING(
		SELECT
			id,
			name
		FROM
			class_B AS b
	)
ON ( ca.id = b.id )
	WHEN MATCHED THEN 
		UPDATE SET 
		ca.name = b.name,
		ca.id   = b.id
	WHEN NOT MATCHED THEN
		INSERT
			(id,name)
		VALUES
			(b.id, b.name)
;
-- mySQLではMERGE文は使えないので代替方法を考える
REPLACE INTO 
	Class_A(id, name)
VALUES
	/* class_Aのid=2のレコードがdeleteされて
		新しくinsertされる*/
	( 2,'内海'),
	/* class_Aにid=4のレコードは無いので単純にinsertされる*/
	( 4,'西園寺')
;
