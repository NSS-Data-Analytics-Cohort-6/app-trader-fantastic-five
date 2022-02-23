SELECT name, 
	a.price AS app_price, 
	p.price::money::decimal AS play_price,
	a.rating AS app_rating,
	p.rating AS play_rating,
	a.review_count AS app_reviews,
	p.review_count AS play_reviews,
	p.content_rating,
	p.genres
FROM App_store_apps AS a
	INNER JOIN play_store_apps AS p
	USING (name)
WHERE a.price = 0 AND p.price::money::decimal = 0