SELECT
	num AS prime
FROM
	numbers_ AS n1
WHERE
	-- 素数は1より大きい
	num > 1
	And 
	-- 割り切れるような自然数、でないものを選ぶ
	NOT EXISTS
		(
		SELECT
			*
		FROM -- n2からは割る数を取得
			numbers_ AS n2
		WHERE
			-- 自分の半分より小さい値で約数を持つ
			n2.num <= n1.num/2
		AND
			-- 1以外の値で割り切れる
			n2.num <> 1
		AND
			-- n1.numはn2.numで割り切れる
			mod(n1.num, n2.num)=0
		)
;
