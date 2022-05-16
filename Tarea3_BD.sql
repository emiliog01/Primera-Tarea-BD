

--Tarea
--Emilio González Luna

--Cómo obtenemos todos los nombres y correos de nuestros clientes canadienses para una campaña?
select c.first_name || ' ' || c.last_name as full_name, c.email, cty.country as country_of_residence
from customer c join address ad on (c.address_id=ad.address_id) join city cit on (ad.city_id=cit.city_id) join country cty on (cit.country_id=cty.country_id)
where(cty.country='Canada');

--Qué cliente ha rentado más de nuestra sección de adultos?
select customer_id, c.first_name || ' ' || c.last_name as full_name, count(*) as num_rents
from film f join inventory using (film_id) join rental using (inventory_id) join customer c using(customer_id)
where f.rating in ('R','NC-17')
group by customer_id
order by num_rents desc limit 3;


	
--Qué películas son las más rentadas en todas nuestras stores?
select film_id, title, count(*) as num_rents
from film join inventory using(film_id) join rental using (inventory_id) join store using (store_id)
group by film_id, title
order by num_rents desc limit 5;


--Cuál es nuestro revenue por store?
select store_id, sum(p.amount)
from store s join inventory i using (store_id) join rental r using(inventory_id) join payment p using (rental_id)
group by store_id
order by store_id;






