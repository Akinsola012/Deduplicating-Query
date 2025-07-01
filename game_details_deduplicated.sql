-- 1. Preview the Table
SELECT * FROM game_details
LIMIT 5;

-- 2. Identify Duplicate Records
--    Based on game_id, team_id, player_id
SELECT 
  game_id,
  team_id,
  player_id,
  COUNT(*) AS record_count
FROM game_details
GROUP BY game_id, team_id, player_id
HAVING COUNT(*) > 1
ORDER BY record_count DESC;

-- 3. Deduplication Step
--    Keeps only the first occurrence of each duplicate
--    Partitioned by game_id, team_id, player_id, start_position, comment, min
WITH deduplicated_rows AS (
  SELECT 
    *,
    ROW_NUMBER() OVER (
      PARTITION BY 
        game_id,        
        team_id,       
        player_id,      
        start_position, 
        comment,        
        min            
      ORDER BY 
        game_id, team_id, player_id 
    ) AS duplicate_num 
  FROM game_details
)
SELECT 
  game_id,
  team_id,
  team_abbreviation,
  team_city,
  player_id,
  player_name,
  nickname,
  start_position,
  comment,
  min,
  fgm,
  fga,
  fg_pct,
  fg3m,
  fg3a,
  fg3_pct,
  ftm,
  fta,
  ft_pct,
  oreb,
  dreb,
  reb,
  ast,
  stl,
  blk,
  "TO" AS turnovers,
  pf,
  pts,
  plus_minus
FROM deduplicated_rows
WHERE duplicate_num = 1;

-- 4. Verification Step
--    Check if any duplicates remain in deduplicated data
WITH deduped_data AS (
  WITH deduplicated_rows AS (
    SELECT 
      *,
      ROW_NUMBER() OVER (
        PARTITION BY 
          game_id,
          team_id,
          player_id,
          start_position,
          comment,
          min
        ORDER BY game_id, team_id, player_id
      ) AS duplicate_num
    FROM game_details
  )
  SELECT * FROM deduplicated_rows WHERE duplicate_num = 1
)
SELECT 
  game_id,
  team_id,
  player_id,
  COUNT(*) AS record_count
FROM deduped_data
GROUP BY game_id, team_id, player_id
HAVING COUNT(*) > 1;
