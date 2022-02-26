/* apps with longest life span*/
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

/*top_10_apps_with_the_longest_life_span*/
SELECT
app_store_name,
play_store_name,
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
ORDER BY lifespan_months DESC, app_store_genre,play_store_genre) as subquery
LIMIT 10; 


/*apps that over a 1$ with longest life span*/
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

/* Pie Day apps recommendation*/
SELECT
app_store_name,
play_store_name,
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
AND(ROUND((a.rating+p.rating)/2*2+1,1))>=9.5
AND a.name ILIKE any(array['%farm%','%jam%','%pinterest%','%pie%','%pizza%','%egg%','%food%','%fruit%','%flour%','%recipe%','%dessert%','%cook%','%bake%','%PAC-MAN%'])
ORDER BY lifespan_months DESC, app_store_genre,play_store_genre) as subquery
LIMIT 10; 

