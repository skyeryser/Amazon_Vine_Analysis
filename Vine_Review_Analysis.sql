-- Total votes are greater than or equal to 20:
CREATE TABLE top_reviews
AS (SELECT * FROM vine_table
WHERE total_votes >=20);

SELECT * FROM top_reviews;

-- Find where the percentage of helpful votes to total votes is greater than 50%:
CREATE TABLE helpful_reviews
AS (SELECT * FROM top_reviews
WHERE CAST(helpful_votes AS FLOAT)/(total_votes)>=.5);

SELECT * FROM helpful_reviews;

-- Find all paid reviews
CREATE TABLE paid_reviews
AS (SELECT * FROM helpful_reviews
WHERE vine = 'Y');

SELECT * FROM paid_reviews;

-- Find all unpaid reviews
CREATE TABLE unpaid_reviews
AS (SELECT * FROM helpful_reviews
WHERE vine = 'N');

SELECT * FROM unpaid_reviews;

-- Determine the total number of paid reviews
SELECT SUM(total_votes) AS reviews
INTO total_paid_reviews
FROM paid_reviews;

DROP TABLE total_paid_reviews;
SELECT * FROM total_paid_reviews;

-- Determine the total number of unpaid reviews
SELECT SUM(total_votes) AS reviews
INTO total_unpaid_reviews
FROM unpaid_reviews;

DROP TABLE total_unpaid_reviews;
SELECT * FROM total_unpaid_reviews;

-- Determine the total number of 5 star paid reviews
SELECT SUM(total_votes) AS reviews
INTO paid_five_star_reviews
FROM paid_reviews
WHERE star_rating=5;

DROP TABLE paid_five_star_reviews;
SELECT * FROM paid_five_star_reviews;

-- Determine the total number of 5 star unpaid reviews
SELECT SUM(total_votes) AS reviews
INTO unpaid_five_star_reviews
FROM unpaid_reviews
WHERE star_rating=5;

DROP TABLE unpaid_five_star_reviews;
SELECT * FROM unpaid_five_star_reviews;

-- Determine the percentage of 5 star reviews for paid reviewers
SELECT paid_five_star_reviews.reviews::DECIMAL / total_paid_reviews.reviews::DECIMAL
INTO percent_paid_five_stars
FROM paid_five_star_reviews
JOIN total_paid_reviews
ON 1=1;

DROP TABLE percent_paid_five_stars;
SELECT * FROM percent_paid_five_stars;

-- Determine the percentage of 5 star reviews for unpaid reviewers
SELECT unpaid_five_star_reviews.reviews::DECIMAL / total_unpaid_reviews.reviews::DECIMAL
INTO percent_unpaid_five_stars
FROM unpaid_five_star_reviews
JOIN total_unpaid_reviews
ON 1=1;

SELECT * FROM percent_unpaid_five_stars;