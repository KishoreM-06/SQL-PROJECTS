 select *from Games;
    --
select distinct(genre)from games;
--
select distinct(platform)from games;
--

select * from games 
where rating>=4.8;
--

SELECT * 
FROM Games
WHERE title LIKE '% cricket%';

--

select * from games 
order by rating desc;

--

select*from games order by rating desc limit 5;

--

select *, case 

when rating>4.8 then 'Masterpiece'
when rating>4.5 then 'Excellent'
when rating>4.0 then 'Great' else 'good' end as ratingcat
from games;