-- NOT EXISTSバージョン
SELECT
  seq
FROM
  Sequence AS Se
WHERE
  -- 1から12の連番になるような条件づけ
  seq BETWEEN 1 AND 12
  AND 
  -- SeqTblとSequenceにない数字
  NOT EXISTS (
    SELECT
      seq
    FROM
      SeqTbl AS ST
    WHERE
      -- 2つのテーブルを相関させる
      Se.seq = ST.seq
  );

-- 外部結合バージョン
SELECT
  Se.seq
FROM
  Sequence AS Se 
  -- SeqTblにない数字がNULLになるように結合
  LEFT OUTER JOIN SeqTbl AS ST ON ST.seq = Se.seq
WHERE
  -- 1から12の連番になるような条件づけ
  SE.seq BETWEEN 1 AND 12
  AND
  -- SeqTblがNULLのSequenceの数字
  ST.seq IS NULL;