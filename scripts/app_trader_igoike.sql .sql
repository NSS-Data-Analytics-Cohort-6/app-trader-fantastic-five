select a.name,
a.price as app_price,
p.price::money::decimal as game_price,
a.rating as app_rating,
p.rating as game_rating
from app_store_apps as a
INNER JOIN play_store_apps as p
USING (name)
WHERE a.price <= 1 AND p.price::money::decimal <= 1;