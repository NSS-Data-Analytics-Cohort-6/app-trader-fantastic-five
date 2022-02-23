SELECT *
FROM play_store_apps
WHERE rating IS NOT NULL
AND content_rating <> 'Mature 17+'
ORDER BY rating DESC
LIMIT 10;