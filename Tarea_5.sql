--Emilio Gonzalez Luna
--CU: 194888

--CTE for cylinder volume:
  with store_films as (
    select i.store_id, count(i.film_id) as num_films from inventory i group by store_id),--films per store
	
    max_movies as (
    select 100 as movies_per_cylinder),--max. films per cylinder

	height_ as (
    select 1.5*maxm.movies_per_cylinder as height_ from max_movies maxm),--cylinder height

	radius_ as (
    select sqrt(power(30/2,2) + power(21/2,2)) as rad)--cylinder radius using pythagoras

 select pi()*power(r.rad,2)*h.height_ as "volume (cm^3)" from radius_ r, height_ h;--cylinder volume



--Number of cylinders needed:
select i.store_id, ceil(count(i.film_id)/100) as number_of_cylinders_per_store
from inventory i
group by store_id;
