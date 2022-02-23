/* this is the beginning of 
Phil's SQL code
let's see how it plays out */

SELECT name, a.price AS app_price, 
p.price::money::decimal AS play_price, 
a.rating AS app_rating, 
p.rating AS play_rating, 
a.review_count AS app_reviews, 
p.review_count AS play_reviews, 
p.content_rating, 
p.genres as play_genre,
a.primary_genre as app_genre,
trim(trailing '+' from p.install_count) AS p.play_installs
FROM App_store_apps AS a
	INNER JOIN play_store_apps AS p
	USING (name)
	order by play_price desc
	cast(p.play_installs as int)
