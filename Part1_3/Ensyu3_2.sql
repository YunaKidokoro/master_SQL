-- テーブルにレコードidを与える
CREATE TABLE products_
SELECT
	name,
	price,
	-- 名前と値段でグルーピングするようにしてみました。
	ROW_NUMBER() OVER(PARTITION BY name,price) AS row_num
FROM 
	products
;

-- 重複の削除
DELETE FROM
	Products_
WHERE 
	row_num <> 1
;
-- 重複とレコードIdのないテーブルを取得する
SELECT name, price FROM Products_; 

//*
-- 重複したレコードを挿入する
insert into products
(name, price)
Values
('バナナ',100),
('バナナ',100),
('いちご',500)
;
*/
