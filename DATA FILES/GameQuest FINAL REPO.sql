# 1 Find the average rating and total number of games for each platform.
SELECT platform,
    round(AVG(rating),1) AS AvgRating,
    COUNT(*) AS TotalGames
FROM games
GROUP BY platform;

# 2 Find the average rating and game count for each genre, sorted from highest to lowest average rating.

SELECT genre,
	round(AVG(rating),1) AS AvgRating,
    COUNT(*) AS TotalGames
FROM games
GROUP BY genre
ORDER BY 2 DESC;

# 3 Show how many games were released in each decade.
select*from games;
SELECT 
    (release_year DIV 10) * 10 AS Decade,
    COUNT(*) AS TotalGames
FROM Games
GROUP BY Decade
ORDER BY decade;

# 4 List platforms that have more than 1 game.

select platform,count(*)TotalGames 
from games 
GROUP BY 1 
having count(*)>1;

# 4 Rank Games Within Each Platform

SELECT  Title,Platform ,Rating ,
DENSE_RANK() OVER (PARTITION BY platform ORDER BY rating DESC) AS PlatforRank
FROM Games;

# 5 For every game, show whether its rating is above or below the overall average rating.

SELECT title As Title,rating as Rating,
    CASE
        WHEN rating > (SELECT AVG(rating) FROM games)
            THEN 'Above Average'
        ELSE 'Below Average'
    END AS Rating_Vs_Avg
FROM games;


# 6 Return only the top-rated game(s) for each platform.

SELECT Title,Platform,Rating,Release_Year,Rnk
FROM (
    SELECT *,
           RANK() OVER (PARTITION BY platform ORDER BY rating DESC) AS Rnk
    FROM games 
) ranked
WHERE Rnk = 1;

# 7 Rank games within each platform based on rating (highest first).

SELECT *,
       RANK() OVER (PARTITION BY platform ORDER BY rating DESC) AS rnk
FROM games;

# 8  Find games whose rating is higher than the average rating of their own platform.

SELECT * FROM
 ( 
    SELECT g.*,
        AVG(rating) OVER (PARTITION BY platform) AS avg_platform_rating
    FROM Games g
) t
WHERE t.rating > t.avg_platform_rating;

# 9 Show yearly release counts and a running total of games released over time.

SELECT *, SUM(releasecount) OVER (ORDER BY release_year) AS Running_total
FROM (
    SELECT 
        Release_year,
        COUNT(*) AS Releasecount
    FROM games
    GROUP BY release_year
) t;


# 10 Classify each platform into performance tiers based on its average rating (Elite / Strong / Average).

SELECT platform, AVG(rating) AS avg_rating,
    CASE 
        WHEN AVG(rating) > 4.5 THEN 'Elite'
        WHEN AVG(rating) > 4 THEN 'Strong'
        ELSE 'Average'
    END AS Performance
FROM games
GROUP BY platform;


# 11 Percentile Ranking of Games
SELECT 
    title,
    rating,
    concat( ROUND(PERCENT_RANK() OVER (ORDER BY rating) * 100, 1),'%') AS percentile_rank_percentage
FROM Games;
