select 
DISTINCT a.name,
a.price as app_price,
p.price::money::decimal as game_price,
a.rating as app_rating,
p.rating as game_rating,
a.primary_genre as app_store_genre,
p.genres as play_store_genre,
round((a.rating+p.rating)/2*2+1,1) lifespan_years,
(((round((a.rating+p.rating)/2*2+1,0))*12)*5000) as estamated_revenue,
(((round((a.rating+p.rating)/2*2+1,0))*12)*1000)+10000 as estemated_spending,
((((round((a.rating+p.rating)/2*2+1,0))*12)*5000))
-(((round((a.rating+p.rating)/2*2+1,0))*12)*1000)+10000 as
total_revenue
from app_store_apps as a
JOIN play_store_apps as p
ON a.name = p.name
WHERE a.price <= 1 AND p.price::money::decimal <= 1
AND CAST(a.review_count as decimal) >=100 
AND CAST(p.review_count as decimal) >= 100
AND a.rating >= 3.5 AND p.rating>= 3.5
order by lifespan_years DESC;
