SELECT *
FROM nba_teams;

-- Renaming w and l columns to Wins and Loses respectively

ALTER TABLE nba_teams
RENAME column w TO Wins;

ALTER TABLE nba_teams
RENAME column l TO Loses;


-- Which team had the most wins (Celtics)

SELECT team_name, wins
FROM nba_teams
ORDER BY wins DESC
LIMIT 1;

-- What are the top 5 teams by points per game? ( Kings, Warriors, Celtics, Jaz, Lakers)

SELECT team_name, pts_pg
FROM nba_teams
order by pts_pg DESC
LIMIT 5;

-- Which teams had a win percentage above 0.600? (Celtics, Nuggets, Bucks, Nets, 76ers, Grizzlies)

SELECT team_name, pct
FROM nba_teams
WHERE pct > 0.600;

-- Which team had the best (lowest) opponent points rank? ( Cavaliers)

SELECT team_name, opp_pts_rank
FROM nba_teams
ORDER BY opp_pts_rank ASC
LIMIT 1;

-- Compare average pts_pg between Eastern and Western conferences.

SELECT team_conference, AVG(pts_pg) AS avg_pts_pg
FROM nba_teams
GROUP BY team_conference
ORDER BY avg_pts_pg ;

-- Which team led in assists per game (ast_pg)? Warriors

SELECT team_name, ast_pg
FROM nba_teams
ORDER BY ast_pg DESC;

-- What’s the average number of rebounds per game (reb_pg) across all teams? 43.46296296296296

SELECT AVG(reb_pg) AS avg_reb_pg
FROM nba_teams;

-- How many teams are in each division?

SELECT team_division, COUNT(team_division) AS division_count
FROM nba_teams
GROUP BY team_division;

-- What's the average win percentage by conference?

SELECT team_conference, AVG(pct)
FROM nba_teams
GROUP BY team_conference;

-- Which team had the largest difference between their points per game (pts_pg) and opponent points per game (opp_pts_pg)? (celtic)

SELECT team_name, pts_pg, opp_pts_pg, (pts_pg - opp_pts_pg) AS pts_diff
FROM nba_teams
ORDER BY pts_diff DESC
LIMIT 1;

-- List teams where points rank is better (lower) than assists rank

SELECT team_name, pts_rank, ast_rank
FROM nba_teams
WHERE pts_rank < ast_rank
ORDER BY pts_rank;

-- Which teams had a low conference rank (top 8) but a lower-than-expected win percentage (below average)?



WITH avg_pct_cte AS (
	SELECT avg(pct) AS avg_pct
	FROM nba_teams)
SELECT team_name, conf_rank, pct
FROM nba_teams, avg_pct_cte
WHERE conf_rank <= 8
AND pct < avg_pct
ORDER BY conf_rank ;

-- For each division, which team had the highest points per game (pts_pg)?


WITH ranked AS (
SELECT team_name, team_division, pts_pg,
ROW_NUMBER() OVER(PARTITION BY team_division ORDER BY pts_pg DESC) AS ranked_team
FROM nba_teams)
SELECT team_name, team_division, pts_pg
FROM ranked
WHERE ranked_team = 1
ORDER BY team_division;


-- List teams whose rankings for points (pts_rank), assists (ast_rank), and rebounds (reb_rank) are all within the top 10.

SELECT team_name, pts_rank, ast_rank, reb_rank
FROM nba_teams
WHERE pts_rank <= 10
AND ast_rank <= 10
AND reb_rank <= 10
;

-- Find the top 3 teams with the largest gap between opponent rank (opp_pts_rank) and their actual opp_pts_pg, 
-- suggesting they faced stronger teams but still allowed fewer points


WITH GAP AS (
SELECT team_name, opp_pts_rank, opp_pts_pg, (opp_pts_rank - opp_pts_pg) AS rank_gap
FROM nba_teams
)
SELECT team_name, opp_pts_rank, opp_pts_pg, rank_gap
FROM GAP
ORDER BY rank_gap DESC
LIMIT 3;

-- Which team has the smallest spread (difference) between their pts_rank, reb_rank, and ast_rank?

SELECT team_name, pts_rank, reb_rank, ast_rank,
(GREATEST(pts_rank, reb_rank, ast_rank)- LEAST(pts_rank, reb_rank, ast_rank)) AS rank_spread
FROM nba_teams
ORDER BY rank_spread ASC
LIMIT 1;





