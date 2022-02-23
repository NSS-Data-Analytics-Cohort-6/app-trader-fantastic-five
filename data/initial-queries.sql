-- app store apps top rating by genre
/*select DISTINCT primary_genre, COUNT(name)
from app_store_apps
WHERE rating > 4.5
GROUP BY DISTINCT primary_genre
ORDER BY COUNT(name) DESC*/

-- play store apps top rating by genre
/*Select DISTINCT category, COUNT(name)
from play_store_apps
WHERE rating > 4.5
GROUP BY DISTINCT category
ORDER BY COUNT(name) DESC*/

-- app store avg price of apps over $1.00 by genre
/*SELECT primary_genre, avg(price)
FROM app_store_apps
WHERE price > 1
group by primary_genre
order by avg(price) DESC*/

-- play store avg price of apps over $1.00 by genre
/*SELECT primary_genre, avg(price)
FROM play_store_apps
WHERE price > 1
group by category
order by avg(price) DESC*/

SELECT name, a.price AS app_price, p.price::money::decimal AS play_price, a.rating AS app_rating, p.rating AS play_rating, a.review_count AS app_reviews, p.review_count AS play_reviews, p.content_rating, p.genres
FROM App_store_apps AS a
	INNER JOIN play_store_apps AS p
	USING (name);