/* this is the beginning of 
Phil's SQL code
let's see how it plays out
You can hit F5 to only run the selected code!!!*/

SELECT distinct trim(a.name) as application,
a.price,
p.price::money::decimal AS play_price, 
a.rating AS app_rating, 
p.rating AS play_rating, 
cast(a.review_count as int) AS app_reviews, 
cast(p.review_count as int) AS play_reviews, 
p.content_rating, 
p.genres as play_genre,
a.primary_genre as app_genre,
round((a.rating+p.rating)/2*2+1,0) as lifespan_years,
round(((a.rating+p.rating/2*2+1)*12),0) as lifespan_months,
(((round((a.rating+p.rating)/2*2+1,0))*12)*5000)-11000 as estimated_revenue_years,
round((cast(a.review_count as int) + p.review_count)/(p.review_count / (cast(replace(trim(trailing '+' from p.install_count), ',','') as numeric))),0) as estimated_downloads
FROM App_store_apps AS a
	INNER JOIN play_store_apps AS p
	on trim(a.name) = trim(p.name)
	WHERE a.price = p.price::money::decimal and a.price=0 and p.price::money::decimal=0
AND CAST(a.review_count as decimal) >= 100
AND CAST(p.review_count as decimal) >= 100
AND a.rating >= 3.5 AND p.rating>= 3.5
and round((a.rating+p.rating)/2*2+1,0)>=10
order by lifespan_years DESC;

--take 1.5 just to find the good ones
SELECT DISTINCT trim(a.name) AS app,
	a.price AS app_price,
	p.price::money::decimal AS game_price,
	a.rating AS app_rating,
	p.rating AS game_rating,
	a.primary_genre AS app_store_genre,
	p.genres AS play_store_genre,
	(ROUND((a.rating+p.rating)/2*2+1,1)) AS lifespan_years,
	(((ROUND((a.rating+p.rating)/2*2+1,0))*12)*5000) AS estimated_revenue,
	(((ROUND((a.rating+p.rating)/2*2+1,0))*12)*1000)+10000 AS estimated_spending,
	((((ROUND((a.rating+p.rating)/2*2+1,0))*12)*5000))
	-(((ROUND((a.rating+p.rating)/2*2+1,0))*12)*1000)+10000 AS total_revenue
	FROM app_store_apps AS a
	JOIN play_store_apps AS p
	ON a.name = p.name
	WHERE a.price <= 1 AND p.price::money::decimal <= 1
		AND CAST(a.review_count AS decimal) >=100
		AND CAST(p.review_count AS decimal) >= 100
		AND a.rating >= 3.5 AND p.rating>= 3.5
		and (ROUND((a.rating+p.rating)/2*2+1,1))>=9.5
	ORDER BY lifespan_years DESC;
-- take two down here

SELECT distinct trim(upper(a.name)) as application,
a.rating,
cast(a.review_count as int),
case when a.price = 0 then a.price
else null end as app_price
from app_store_apps as a
inner join play_Store_apps as p
on trim(upper(a.name)) = trim(upper(p.name))
where a.price = 0 and p.price::money::decimal = 0
and a.name ilike '%PAC-MAN%'
order by review_count desc;

--take 3 with Jasmines code

SELECT DISTINCT trim(a.name) AS app,
	a.price AS app_price,
	p.price::money::decimal AS game_price,
	a.rating AS app_rating,
	p.rating AS game_rating,
	a.primary_genre AS app_store_genre,
	p.genres AS play_store_genre,
	(ROUND((a.rating+p.rating)/2*2+1,1)) AS lifespan_years,
	(((ROUND((a.rating+p.rating)/2*2+1,0))*12)*5000) AS estimated_revenue,
	(((ROUND((a.rating+p.rating)/2*2+1,0))*12)*1000)+10000 AS estimated_spending,
	((((ROUND((a.rating+p.rating)/2*2+1,0))*12)*5000))
	-(((ROUND((a.rating+p.rating)/2*2+1,0))*12)*1000)+10000 AS total_revenue
	FROM app_store_apps AS a
	JOIN play_store_apps AS p
	ON a.name = p.name
	WHERE a.price <= 1 AND p.price::money::decimal <= 1
		AND CAST(a.review_count AS decimal) >=100
		AND CAST(p.review_count AS decimal) >= 100
		AND a.rating >= 3.5 AND p.rating>= 3.5
		and (ROUND((a.rating+p.rating)/2*2+1,1))>=9.5
		AND a.name ILIKE any(array['%farm%','%jam%','%pinterest%','%pie%','%pizza%','%egg%','%food%','%fruit%','%flour%','%recipe%','%dessert%','%cook%','%bake%','%PAC-MAN%'])
	ORDER BY lifespan_years DESC
	limit 10;
	
	--Iulia's code that has the top paid apps
SELECT
app_store_name,
play_store_name,
app_price,
game_price,
lifespan_years,
lifespan_months,
(lifespan_months*5000) as estimated_revenue,
(lifespan_months*1000)+10000 as estimated_spending,
(lifespan_months*5000) - (lifespan_months*1000)+10000 as
total_revenue
FROM(select
DISTINCT
a.name as app_store_name,
p.name as play_store_name,
a.price as app_price,
p.price::money::decimal as game_price,
a.rating as app_rating,
p.rating as game_rating,
a.primary_genre as app_store_genre,
p.genres as play_store_genre,
round((a.rating+p.rating)/2*2+1,1) as lifespan_years,	
round(((a.rating+p.rating)/2*2+1)*12,1) lifespan_months
from app_store_apps as a
JOIN play_store_apps as p
ON a.name = p.name
WHERE a.price > 1 AND p.price::money::decimal >1
AND CAST(a.review_count as decimal) >=100
AND CAST(p.review_count as decimal) >= 100
AND a.rating >= 3.5 AND p.rating>= 3.5
order by lifespan_months DESC) as subquery;

--Iulia's code that has the top free apps

SELECT
app_store_name,
play_store_name,
lifespan_years,
app_price,
game_price,
app_rating,
game_rating,
play_rating,
app_reviews,
play_reviews,
estimated_downloads,
(lifespan_months*5000) as estimated_revenue,
(lifespan_months*1000)+10000 as estimated_spending,
(lifespan_months*5000) - (lifespan_months*1000)+10000 as
total_revenue
FROM(select
DISTINCT
a.name as app_store_name,
p.name as play_store_name,
a.price as app_price,
p.price::money::decimal as game_price,
a.rating as app_rating,
round(round(p.rating/5,1)*5,1) as game_rating,
a.review_count as app_reviews,
p.review_count as play_reviews,
p.rating as play_rating,
a.primary_genre as app_store_genre,
p.genres as play_store_genre,
round((cast(a.review_count as int) + p.review_count)/(p.review_count / (cast(replace(trim(trailing '+' from p.install_count), ',','') as numeric))),0) as estimated_downloads,
CAST(round((a.rating+p.rating)/2*2+1,0) AS int) AS lifespan_years,	
CAST(round((a.rating+p.rating)/2*2+1,1) AS int) * 12 AS lifespan_months
from app_store_apps as a
JOIN play_store_apps as p
ON a.name = p.name
WHERE CAST(a.review_count as decimal) >=100
AND CAST(p.review_count as decimal) >= 100
AND a.rating >= 3.5 AND p.rating>= 3.5
ORDER BY lifespan_years DESC, app_store_genre,play_store_genre) as subquery
LIMIT 1000;

--Iulia's code that has the top free apps x2

SELECT
app_store_name,
play_store_name,
app_store_genre,
play_store_genre,
lifespan_years,
lifespan_months,
(lifespan_months*5000) as estimated_revenue,
(lifespan_months*1000)+10000 as estimated_spending,
(lifespan_months*5000) - (lifespan_months*1000)+10000 as
total_revenue
FROM(select
DISTINCT
a.name as app_store_name,
p.name as play_store_name,
a.price as app_price,
p.price::money::decimal as game_price,
a.rating as app_rating,
p.rating as game_rating,
a.primary_genre as app_store_genre,
p.genres as play_store_genre,
round((a.rating+p.rating)/2*2+1,1) as lifespan_years,
round(((a.rating+p.rating)/2*2+1)*12,1) lifespan_months
from app_store_apps as a
JOIN play_store_apps as p
ON a.name = p.name
WHERE a.price <= 1 AND p.price::money::decimal <= 1
AND CAST(a.review_count as decimal) >=100
AND CAST(p.review_count as decimal) >= 100
AND a.rating >= 3.5 AND p.rating>= 3.5
ORDER BY lifespan_years DESC) as subquery
ORDER BY app_store_genre,play_store_genre;