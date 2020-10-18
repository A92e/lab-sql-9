use sakila;

-- customer_id address_id city_id


select c.customer_id, city.city  from customer as c
 join address as a
 on c.address_id = a.address_id
 join city 
 on a.city_id=city.city_id
 group by customer_id
 order by customer_id;
 
 -- most rented cat

 
 select  r.customer_id,fc.category_id, c.name as 'max_cat', count(r.rental_id) as 'num_rental', 
 dense_rank() over (partition by r.customer_id order by count(r.rental_id) desc)  as 'rank' from rental as r 
join inventory as i 
on r.inventory_id = i.inventory_id
join film_category as fc
on  i.film_id = fc.film_id
join category as c
on fc.category_id=c.category_id
group by customer_id, c.name
order by customer_id;

 
 
 -- Total films rented
 select customer_id, count(rental_id) as 'total_rented_film' from rental
 group by customer_id
 order by customer_id;
 
 
 -- Total money spent
 select customer_id, sum(amount) as 'total_money' from payment
 group by customer_id
 order by customer_id;
 
 
 -- how many last month
select customer.customer_id, count(rental_id) as 'rented_last_month',rental_date from rental 
right outer join customer
on customer.customer_id=rental.customer_id
and  (rental_date >= '2005-05-15') and (rental_date <= '2005-05-30')
group by customer_id
order by customer_id;
 
 --  how many this month
select customer.customer_id, count(rental.rental_id) as 'rented_this_month',rental.rental_date from  customer
left JOIN  rental on customer.customer_id=rental.customer_id 
and  (rental.rental_date >= '2005-06-15') and (rental.rental_date <= '2005-06-30')
group by customer.customer_id
order by customer.customer_id;

