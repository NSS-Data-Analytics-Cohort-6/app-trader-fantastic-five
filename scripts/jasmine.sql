--Pi Day apps lifespan revenue (I, P, J)
SELECT app,
	ROUND(lifespan_years * total_revenue) AS ls_total_rev,
	lifespan_years,
	total_revenue,
	app_price,
	game_price
FROM
	(SELECT DISTINCT a.name AS app,
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
	 	AND (ROUND((a.rating+p.rating)/2*2+1,1)) >=9.5
		 AND a.name ILIKE any(array['%farm%','%pizza%','%egg%','%fruit%','%flour%','%recipe%','%dessert%','%cook%','%bake%','%PAC-MAN%', '%pie%', '%food%', '%pinterest%', '%jam%'])
		ORDER BY lifespan_years DESC
		LIMIT 10) AS subquery
ORDER BY ls_total_rev DESC;

--Phil's top 10
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
	LIMIT 10;
	
--Iulia's query for apps over $1 limit 10
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
FROM(select DISTINCT a.name as app_store_name,
	p.name as play_store_name,
	a.price as app_price,
	p.price::money::decimal as game_price,
	a.rating as app_rating,
	p.rating as game_rating,
	a.primary_genre as app_store_genre,
	p.genres as play_store_genre,
	round((a.rating+p.rating)/2*2+1,1) as lifespan_years,	
	round(((a.rating+p.rating)/2*2+1)*12,1) AS lifespan_months
	FROM app_store_apps as a
JOIN play_store_apps as p
ON a.name = p.name
WHERE a.price > 1 AND p.price::money::decimal >1
	AND CAST(a.review_count as decimal) >=100
	AND CAST(p.review_count as decimal) >= 100
	AND a.rating >= 3.5 AND p.rating>= 3.5
	ORDER BY lifespan_months DESC) as subquery
	LIMIT 10;
	
--Iulia's query for free apps by lifespan limit 10
SELECT
	app_store_name,
	play_store_name,
	lifespan_years,
	lifespan_months,
	(lifespan_months*5000) as estimated_revenue,
	(lifespan_months*1000)+10000 as estimated_spending,
	(lifespan_months*5000) - (lifespan_months*1000)+10000 as
	total_revenue
FROM
	(select DISTINCT a.name as app_store_name,
	p.name as play_store_name,
	a.price as app_price,
	p.price::money::decimal as game_price,
	a.rating as app_rating,
	p.rating as game_rating,
	a.primary_genre as app_store_genre,
	p.genres as play_store_genre,
	round((a.rating+p.rating)/2*2+1,1) as lifespan_years,	
	round(((a.rating+p.rating)/2*2+1)*12,1) lifespan_months
	FROM app_store_apps as a
	JOIN play_store_apps as p
	ON a.name = p.name
	WHERE a.price <= 1 AND p.price::money::decimal <= 1
		AND CAST(a.review_count as decimal) >=100
		AND CAST(p.review_count as decimal) >= 100
		AND a.rating >= 3.5 AND p.rating>= 3.5
	ORDER BY lifespan_months DESC, app_store_genre,play_store_genre) as subquery
LIMIT 10;

--Subquery to pull lifespan_total_rev because main select didn't work (J)
SELECT app,
	ROUND(lifespan_years * total_revenue) AS ls_total_rev
FROM
	(SELECT DISTINCT a.name AS app,
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
	ORDER BY lifespan_years DESC) AS subquery
ORDER BY ls_total_rev DESC;

--Joining tables for free apps (K)
SELECT name, 
	a.price AS app_price, 
	p.price::money::decimal AS play_price,
	a.rating AS app_rating,
	p.rating AS play_rating,
	a.review_count AS app_reviews,
	p.review_count AS play_reviews,
	p.content_rating,
	((ROUND((a.rating + p.rating) / 2*2+1,0) *12) *5000) -11000 AS estimated_revenue
FROM app_store_apps AS a
	INNER JOIN play_store_apps AS p
	USING (name)
WHERE a.price <= 1
	AND p.price::money::decimal <= 1
ORDER BY play_rating DESC;

--Longevity (P)
SELECT name, a.price AS app_price,
p.price::money::decimal AS play_price,
a.rating AS app_rating,
p.rating AS play_rating,
a.review_count AS app_reviews,
p.review_count AS play_reviews,
p.content_rating,
p.genres AS play_genre,
a.primary_genre AS app_genre,
ROUND((a.rating + p.rating)/2*2+1,1) AS lifespan_years,
TRIM(trailing '+' FROM p.install_count) AS play_installs
FROM App_store_apps AS a
	INNER JOIN play_store_apps AS p
	USING (name)
	ORDER BY lifespan_years DESC

--Top revenue earning apps by genre (S)
SELECT *
FROM (SELECT DISTINCT app_store_genre,
	  ROW_NUMBER() OVER (PARTITION BY app_store_genre ORDER BY total_revenue DESC) AS genre_rank,
	name,
	total_revenue
	FROM (
--table join for free apps
		SELECT DISTINCT a.name,
			a.price as app_price,
			p.price::money::decimal as play_price,
			a.rating as app_rating,
			p.rating as play_rating,
	 		a.primary_genre as app_store_genre,
			p.genres as play_store_genre,
			round((a.rating+p.rating)/2*2+1,1) as lifespan_years,
			(((round((a.rating+p.rating)/2*2+1,0))*12)*5000) as estimated_revenue,
			(((round((a.rating+p.rating)/2*2+1,0))*12)*1000)+10000 as estimated_spending,
			((((round((a.rating+p.rating)/2*2+1,0))*12)*5000))
			-(((round((a.rating+p.rating)/2*2+1,0))*12)*1000)+10000 as
			total_revenue
		FROM app_store_apps as a
		JOIN play_store_apps as p
		ON UPPER(a.name) = UPPER(p.name)
	--above formula changes if paid app equal to 10000*price
		WHERE a.price <= 1 AND p.price::money::decimal <= 1
			AND CAST(a.review_count as decimal) >=100
			AND CAST(p.review_count as decimal) >= 100
			AND a.rating >= 3.5 AND p.rating>= 3.5
			order by lifespan_years DESC) AS freeboth) AS ranks
WHERE genre_rank = 1
ORDER BY total_revenue DESC
LIMIT 10;