select *from film_category;
-- Q1
select film_id, title, rating, length
from film
where rating = "pg" and length > 50;

select *from payment;

-- Q2
select sum(amount) as 'total amount', payment_date from payment
where payment_date >= "2006-01-01"
group by payment_date;

--  Q3
select concat_ws(' ', first_name,last_name) as "full name", last_name from actor
where last_name = 'hopkins';

-- Q4
SELECT last_name
FROM customer
GROUP BY last_name
HAVING COUNT(last_name) = 1;

 
-- Q5
select count(distinct(last_name)) as 'unique last_name' from actor;

-- Q6
select a.actor_id, f.film_id, concat_ws(' ', first_name,last_name) as 'full name'
from actor a
join film_actor f on a.actor_id=f.actor_id
group by f.film_id, a.actor_id
order by f.film_id desc
limit 1;

-- Q7
select *from category;
select *from film;
-- Q8
select avg(length) as "average running time" from film;

--  Q9
select c.name as category,  avg(f.length) as "average running time"
from film f
join film_category fc on f.film_id =fc.film_id
join category c on fc.category_id = c.category_id
group by c.name;    

-- Q10
/* the film table typically has a primary key named film_id, and the inventory table has a primary key named inventory_id.
 These tables are not directly related through a common column,
 so a natural join won't find any matching columns, 
 resulting in an empty set.*/
 

-- Q11
select sum(p.amount) as 'total revenue'
from payment p
join staff s on s.staff_id = p.staff_id
join inventory i on i.store_id = s.store_id;

-- Q12
SELECT CONCAT(customer.first_name, ' ', customer.last_name) AS full_name
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Sci-Fi'
GROUP BY customer.customer_id
HAVING COUNT(rental.rental_id) > 2
ORDER BY full_name;



-- Q13
select sum(p.amount) as "total_revenue", ct.city
from payment p
join customer c on c.customer_id = p.customer_id
join address d on d.address_id = c.address_id
join city ct on ct.city_id = d.city_id
group by ct.city_id
order by total_revenue desc
limit 1;

-- Q14
                                        
select concat_ws(' ',first_name,last_name) as 'actor_full name'
from actor 
where first_name = (select first_name from actor where actor_id = 8)
union
select concat_ws(' ',first_name,last_name) as 'customer_full name'
from customer 
where first_name = (select first_name from actor where actor_id = 8);

-- Q15
SELECT category.name AS category_name, AVG(film.replacement_cost - film.rental_rate) AS avg_cost_difference
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
GROUP BY category_name
HAVING avg_cost_difference > 17;





