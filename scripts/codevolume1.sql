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
(((round((a.rating+p.rating)/2*2+1,0))*12)*5000)-11000 as estimated_revenue,
round((cast(a.review_count as int) + p.review_count)/(p.review_count / (cast(replace(trim(trailing '+' from p.install_count), ',','') as numeric))),0) as estimated_downloads
FROM App_store_apps AS a
	INNER JOIN play_store_apps AS p
	on trim(a.name) = trim(p.name)
	WHERE a.price = p.price::money::decimal and a.price=0 and p.price::money::decimal=0
	-- how can i get this to not be dumb looking
	and a.name ilike any(array['%farm%','%pizza%','%egg%','%fruit%','%flour%','%recipe%','%dessert%','%cook%','%farm%','%bake%','%PAC-MAN%'])
AND CAST(a.review_count as decimal) >= 100
AND CAST(p.review_count as decimal) >= 100
AND a.rating >= 3.5 AND p.rating>= 3.5
order by lifespan_years DESC;

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
and a.name ilike '%Pizza%'
	or p.name ilike '%Pie%' 
	or p.name ilike '%Egg%' 
	or p.name ilike '%Fruit%' 
	or p.name ilike '%Flour%' 
	or p.name ilike '%Recipe%' 
	or p.name ilike '%Dessert%' 
	or p.name ilike '%Calculat%' 
	or p.name ilike '%Butter%'
	or p.name ilike '%Cook%' 
	or p.name ilike '%Farm%' 
	or p.name ilike '%Bake%' 
	or p.name ilike '%PAC-MAN%'
order by review_count desc;