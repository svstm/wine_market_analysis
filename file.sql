/*markdown
We want to highlight 10 wines to increase our sales, which ones should we choose and why?
*/

SELECT NAME, ROUND((ratings_average / (bottle_volume_ml/price_euros)), 3) AS Rate_per_price, ratings_average, ratings_count, price_euros
FROM vintages
WHERE ratings_count > 1000
ORDER BY (ratings_average / (bottle_volume_ml/price_euros)) ASC
LIMIT 10

/*markdown
We have a marketing budget for this year, which country should we prioritise and why?
*/

SELECT name
FROM countries
ORDER BY users_count DESC
LIMIT 1

/*markdown
We would like to give a price to the best winery, which one should we choose and why?
*/

SELECT wineries.name, wines.ratings_count
FROM wines
	INNER JOIN wineries ON  wines.winery_id = wineries.id 
ORDER BY ratings_count DESC
LIMIT 1

/*markdown
We has detected that a big cluster of customers like a specific combination of tastes. We have identified few `primary` `keywords` that matches this and we would like you to **find all the wines that have those keywords**. To ensure accuracy of our selection, ensure that **more than 10 users confirmed those keywords**. Also, identify the `flavor_groups` related to those keywords.
	- Coffee
	- Toast
	- Green apple
	- cream
	- citrus
*/

SELECT wines.name,  keywords_wine.count, keywords_wine.group_name, wines.id
FROM wines
	JOIN keywords_wine ON  wines.id = keywords_wine.wine_id
	JOIN keywords ON keywords.id = keywords_wine.keyword_id

WHERE keywords.name IN ('coffee', 'toast', 'green apple', 'cream', 'citrus')	
AND keywords_wine.count > 10
AND keywords_wine.keyword_type = 'primary'
GROUP BY wines.name 
HAVING COUNT(wines.id) = 5;




-- SELECT wines.name,  keywords_wine.count, keywords_wine.group_name
-- FROM wines
-- 	JOIN keywords_wine ON  wines.id = keywords_wine.wine_id
-- 	JOIN keywords ON keywords.id = keywords_wine.keyword_id

-- WHERE keywords.name IN ('coffee', 'toast', 'green apple', 'cream', 'citrus')	
-- AND keywords_wine.count > 10
-- AND keywords_wine.keyword_type = 'primary'
-- GROUP BY wines.name


/*markdown
 We would like to do a selection of wines that are easy to find all over the world. **Find the top 3 most common `grape` all over the world** and **for each grape, give us the the 5 best rated wines**.
*/

SELECT DISTINCT(grapes.name) AS most_common_grape
	FROM most_used_grapes_per_country
	JOIN grapes
	ON grapes.id = most_used_grapes_per_country.grape_id
ORDER BY most_used_grapes_per_country.wines_count DESC
LIMIT 3

SELECT 
FROM w

/*markdown
We would to give create a country leaderboard, give us a visual that shows the **average wine rating for each `country`**. Do the same for the `vintages
*/

SELECT countries.name, ROUND(AVG(wines.ratings_average), 2) AS average_rating
FROM wines
JOIN regions
ON wines.region_id = regions.id
JOIN countries
ON regions.country_code = countries.code
GROUP BY countries.name
ORDER BY ROUND(AVG(wines.ratings_average), 2) DESC



/*markdown
Do the same for the `vintages
*/

SELECT countries.name, ROUND(AVG(vintages.ratings_average), 2) AS average_rating
FROM wines
JOIN vintages
ON vintages.wine_id = wines.id
JOIN regions
ON wines.region_id = regions.id
JOIN countries
ON regions.country_code = countries.code
GROUP BY countries.name
ORDER BY average_rating DESC

