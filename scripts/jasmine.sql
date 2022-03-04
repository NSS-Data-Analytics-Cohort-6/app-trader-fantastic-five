--Phil's Top 10
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
	ORDER BY lifespan_years DESC
	LIMIT 10;
	
--Iulia's top apps over $1 by lifespan
SELECT
	app_store_name,
	play_store_name,
	app_price,
	game_price,
	lifespan_years,
	lifespan_months,
	(lifespan_months*5000) as estimated_revenue,
	(lifespan_months*1000)+10000 as estimated_spending,
	(lifespan_months*5000) - ((lifespan_months*1000)+10000) as
	total_revenue
FROM(select DISTINCT a.name as app_store_name,
	p.name as play_store_name,
	a.price as app_price,
	p.price::money::decimal as game_price,
	a.rating as app_rating,
	round(round(p.rating/5,1)*5,1) as game_rating,
	a.primary_genre as app_store_genre,
	p.genres as play_store_genre,
	CAST(round((a.rating+p.rating)/2*2+1,1) AS int) AS lifespan_years,	
	CAST(round((a.rating+p.rating)/2*2+1,1) AS int) * 12 AS lifespan_months
	FROM app_store_apps as a
JOIN play_store_apps as p
ON a.name = p.name
WHERE a.price > 1 AND p.price::money::decimal >1
	AND CAST(a.review_count as decimal) >=100
	AND CAST(p.review_count as decimal) >= 100
	AND a.rating >= 3.5 AND p.rating>= 3.5
	ORDER BY lifespan_months DESC) as subquery
	
--Iulia's top free apps by lifespan
SELECT
	app_store_name,
	play_store_name,
	lifespan_years,
	lifespan_months,
	game_rating,
	orig_game_rating,
	app_rating,
	(lifespan_months*5000) AS estimated_revenue,
	(lifespan_months*1000)+10000 AS estimated_spending,
	(lifespan_months*5000) - ((lifespan_months*1000)+10000) AS total_revenue
FROM
	(select DISTINCT a.name as app_store_name,
	p.name as play_store_name,
	a.price as app_price,
	p.price::money::decimal as game_price,
	a.rating as app_rating,
	(round(round(p.rating/5,1)*5,1)) as game_rating,
	p.rating AS orig_game_rating,
	a.primary_genre as app_store_genre,
	p.genres as play_store_genre,
	CAST(round((a.rating+p.rating)/2*2+1,1) AS int) AS lifespan_years,	
	CAST(round((a.rating+p.rating)/2*2+1,1) AS int) * 12 AS lifespan_months
	FROM app_store_apps as a
	JOIN play_store_apps as p
	ON a.name = p.name
	WHERE a.price <= 1 AND p.price::money::decimal <= 1
		AND CAST(a.review_count as decimal) >=100
		AND CAST(p.review_count as decimal) >=100
		AND a.rating >= 3.5 AND p.rating>= 3.5
	 ORDER BY lifespan_years DESC, game_rating DESC) as subquery;