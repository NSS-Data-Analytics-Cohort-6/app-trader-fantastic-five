--Group full code (from Iulia):
SELECT DISTINCT a.name,
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
ORDER BY lifespan_years DESC;

--Subquery to pull lifespan_total_rev because select it didn't work
SELECT app,
	lifespan_years * total_revenue AS ls_total_rev
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

--Jasmine: Rating desc
SELECT DISTINCT a.name, 
	a.price AS app_price, 
	p.price::money::decimal AS play_price,
	a.rating AS app_rating,
	p.rating AS play_rating,
	a.review_count AS app_reviews,
	p.review_count AS play_reviews,
	p.content_rating,
	round((a.rating+p.rating)/2*2+1,1) AS lifespan_years,
	(((round((a.rating+p.rating)/2*2+1,0))*12)*5000) as estimated_revenue,
	(((round((a.rating+p.rating)/2*2+1,0))*12)*1000)+10000 as estimated_spending,
	((((round((a.rating+p.rating)/2*2+1,0))*12)*5000))-(((round((a.rating+p.rating)/2*2+1,0))*12)*1000)+10000 AS
total_revenue
FROM app_store_apps AS a
JOIN play_store_apps AS p
USING (name)
WHERE (a.price <= 1 AND p.price::money::decimal <= 1)
ORDER BY estimated_revenue DESC, lifespan_years DESC, play_rating DESC

--Kamal: Joining tables for free
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
	
--Phil: Code for longevity
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
	
--Iulia: Projection of gains based on app lifespan
-- 11k = 10k app price + 1k marketing in both stores
((ROUND((a.rating + p.rating) / 2*2+1,0) *12) *5000) -11000 AS estimated_revenue
(((ROUND((a.rating+p.rating)/2*2+1,0))*12)*5000)-11000 AS estimated_revenue --Fixed