-- @head_cnt = 3をSETしている
SET
  @head_cnt ＝ '3';
  
-- 行に折り返しが無い場合
SELECT
  S1.seat AS start,-- 始点
  '～',
  S2.seat AS end_ -- 終点
-- cross joinしたテーブルのようにする
FROM
  Seats S1,
  Seats S2,
  Seats S3
WHERE
  -- 終点の条件
  S2.seat = S1.seat + (@head_cnt -1)
  AND -- 始点と終点の間を移動する点
  S3.seat BETWEEN S1.seat AND S2.seat
GROUP BY
  -- 始点～終点の組み合わせで
  S1.seat,
  S2.seat
HAVING
  -- 座席数（3席）
  COUNT(*) -- 空席の数を数える
  = SUM(
    CASE
      -- 移動する点が全て空席であるときに１
      WHEN S3.status = '空' THEN 1
      -- 空席でなければ0
      ELSE 0
    END
  );
-- 行に折り返しがある場合
SELECT
  S1.seat AS start,-- 始点
  ' ～ ',
  S2.seat AS end_ -- 終点
FROM
  Seats2 S1,
  Seats2 S2,
  Seats2 S3
WHERE
  -- 終点の条件
  S2.seat = S1.seat + (@head_cnt -1)
  AND 
  -- 始点と終点の間を移動する点
  S3.seat BETWEEN S1.seat AND S2.seat
GROUP BY
  -- 始点～終点の組み合わせで
  S1.seat,
  S2.seat
HAVING
  -- 必要な座席数と空席数が等しいとき
  COUNT(*) = SUM(
    CASE
      -- 移動する点が全て空席
      WHEN S3.status = '空'
      AND 
      -- ラインIDが等しいならば１
      S3.line_id = S1.line_id THEN 1
      -- 異なるIDならば0
      ELSE 0
    END
  );
