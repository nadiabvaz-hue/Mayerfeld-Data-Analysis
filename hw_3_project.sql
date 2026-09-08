-- 1.  List the last names of actors (alphabetically), as well as how many actors have that last name.

select 
	last_name as actors_last_names,
	count(actor_id) as actor_count
from 
	actor
group by 
	last_name
order by 
	last_name asc;


-- 2.  List last names of actors and the number of actors who have that last name, but only for names 
-- that are shared by at least three actors, sort so that last name with the highest number of actors appears at the top.

select 
	last_name as actors_last_names,
	count(actor_id) as actor_count
from 
	actor
group by 
	last_name
having 
	count(actor_id) >=3
order by 
	actor_count desc;



-- 3.  List all comedy films (regardless of other genres) by displaying the title and film year and 
-- sort by revenue_mils so that the highest appears first.

select
    *
from
    information_schema.columns
where
    column_name = 'revenue_mils';

select 
	*
from 
	movies;

select
    title,
    film_year
from
    movies
where
    genre like '%Comedy%'
order by
    revenue_mils desc;


-- 4.  Display how many films there are in the database for each year. Output should only contain the
-- year and number of films with oldest films appearing first.

select
    film_year,
    count(film_rank) as film_count
from
    movies
group by
    film_year
order by
    film_year asc;

-- 5.  Show all directors who have directed more than 4 films. The output should contain their names and
-- number of films they have directed. The output should show directors with more films at the top, and if
-- there is a tie, sort alphabetically.

select
    director,
    count(film_rank) as films_directed
from
    movies
group by
    director
having
    count(film_rank) > 4
order by
    films_directed desc,
    director asc;

-- 6.  Display the highest revenue amount for each year – output should show the film_year and revenue_mils
-- and it should show oldest films first.

select 
	film_year, 
	max(revenue_mils) as highest_revenue
from
	movies
group by
	film_year
order by 
	film_year asc;

-- 7.  List highest postal codes for all districts staring with either A, B, C, or D ordered by the starting letter.

select 
	district,
	max(postal_code) as highest_postal_code
from 
	address
where 
	upper(left(district,1)) in ('A','B','C','D')
group by
    district
order by
    left(district,1) asc;

-- 8.  Show the ID and average money spent, rounded to 3 decimal points, from 15 top spending customers 
-- (by average spent) that spent below 4.5 so that customers who spent more appear at the top.

select 
	customer_id,
	round(avg(amount), 3) as average_money_spent
from 
	payment
group by
    customer_id
having
    avg(amount) < 4.5
order by
    average_money_spent desc
limit 15;

-- 9.  Show the total number of actors who share their last name with 3 or more other actors.

select
    count(actor_id)
from 
	actor
where 
	last_name in (
    	select
        	last_name
    	from 
    		actor
    	group by 
    		last_name
   	 	having 
   	 		count(actor_id) >= 3
);


-- 10. Show the total revenue by month. Hint: Research “EXTRACT”.

select 
	*
from
	payment;

select
    extract(month from payment_date) as month,
    sum(amount) as total_revenue
from
    payment
group by
    month
order by
    month asc;


