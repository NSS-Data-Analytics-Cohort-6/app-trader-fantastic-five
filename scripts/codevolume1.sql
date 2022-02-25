/* this is the beginning of 
Phil's SQL code
let's see how it plays out */

SELECT distinct p.name, 
a.price AS app_price, 
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
round((cast(a.review_count as int) + p.review_count)*(p.review_count / (cast(replace(trim(trailing '+' from p.install_count), ',','') as numeric)+1)),0) as estimated_downloads
FROM App_store_apps AS a
	INNER JOIN play_store_apps AS p
	on a.name = p.name
	WHERE a.price <= 1 AND p.price::money::decimal <= 1
AND CAST(a.review_count as decimal) >=100
AND CAST(p.review_count as decimal) >= 100
AND a.rating >= 3.5 AND p.rating>= 3.5
order by lifespan_years DESC;