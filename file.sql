/*markdown
We want to highlight 10 wines to increase our sales, which ones should we choose and why?
*/

SELECT NAME, (ratings_average / (bottle_volume_ml/price_euros)) AS Rate_per_price, ratings_average, ratings_count, price_euros
FROM vintages
WHERE ratings_count > 100
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

SELECT wines.name
FROM wines
	JOIN keywords_wine ON  wines.id = keywords_wine.wine_id
	JOIN keywords ON keywords.id = keywords_wine.keyword_id

WHERE keywords.name IN ('coffee', 'toast', 'green apple', 'cream', 'citrus')	
GROUP BY wines.name
HAVING COUNT(DISTINCT keywords.name) = 5;

/*markdown

*/