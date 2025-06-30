# NBA SQL Analysis Project

A comprehensive SQL analysis of NBA team performance data, exploring team statistics, rankings, and conference comparisons through various queries and insights.

## 📊 Project Overview

This project analyzes NBA team data to uncover insights about team performance, including wins/losses, scoring efficiency, defensive capabilities, and comparative analysis across conferences and divisions.

## 🗂️ Project Structure

## 📈 Key Analysis Areas

### Key Analysis Questions Explored
- **Team with Most Wins**: Query to find the league leader
- **Top 5 Scoring Teams**: Highest points per game rankings
- **Elite Teams**: Which teams have win percentages above 60%
- **Best Defense**: Team with lowest opponent points rank
- **Conference Comparisons**: Average scoring between Eastern and Western conferences
- **Assists Leaders**: Teams excelling in playmaking
- **League Averages**: Overall rebounding statistics

## 🔍 SQL Queries Included

### Basic Analysis
- View all team data
- Find team with most wins
- Top 5 teams by points per game  
- Teams with win percentage above 60%
- Team with best defensive ranking

### Statistical Comparisons
- Average points per game by conference
- Top teams in assists per game
- League-wide rebounding averages
- Team counts by division
- Average win percentage by conference

### Advanced Analytics
- Teams with high conference rank but below-average win percentage (using CTEs)
- Division leaders in scoring (using window functions)
- Teams in top 10 for points, assists, AND rebounds
- Complex ranking spread analysis




## 📊 Sample Query Types

**Basic Ranking:**
```sql
SELECT team_name, wins
FROM nba_teams
ORDER BY wins DESC
LIMIT 1;
```

**Conference Analysis:**
```sql
SELECT team_conference, AVG(pts_pg) AS avg_pts_pg
FROM nba_teams
GROUP BY team_conference;
```

**Advanced with CTEs:**
```sql
WITH avg_pct_cte AS (
    SELECT avg(pct) AS avg_pct
    FROM nba_teams)
SELECT team_name, conf_rank, pct
FROM nba_teams, avg_pct_cte
WHERE conf_rank <= 8 AND pct < avg_pct;
```

## 🔧 Database Compatibility

Queries are written in standard SQL and should work with:
- PostgreSQL
- MySQL
- SQLite
- SQL Server (with minor syntax adjustments)

## 📝 Notes

- All queries are designed to work with the nba_teams.csv dataset
- Queries progress from basic filtering to advanced analytical techniques
- Some queries include comments with expected results based on the dataset
- Window functions and CTEs demonstrate advanced SQL capabilities

---

*This project demonstrates SQL proficiency in data analysis, statistical calculations, and database querying techniques applied to sports analytics.*
