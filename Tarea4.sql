--1. Cuál es el promedio, en formato human-readable, de tiempo entre cada pago por cliente de la BD Sakila?

with dates as (
	select payment_id, payment_date, customer_id
	from payment
	where payment_id>1
),
date_diff as (
	select avg(age(dates.payment_date, p.payment_date)) as promedio, p.customer_id --para que no agrupemos por dates hacemos sum
	from payment p join dates on (p.payment_id=dates.payment_id-1)
	where p.customer_id=dates.customer_id
	group by p.customer_id
)
select c1.customer_id, c1.first_name ||' ' || c1.last_name as full_name, date_diff.promedio
from customer c1 join date_diff using(customer_id)

--2. Sigue una distribución normal?
create table promedio_de_tiempo_entre_pagos as (with dates as (
	select payment_id, payment_date, customer_id
	from payment
	where payment_id>1
),
date_diff as (
	select avg(age(dates.payment_date, p.payment_date)) as promedio, p.customer_id
	from payment p join dates on (p.payment_id=dates.payment_id-1)
	where p.customer_id=dates.customer_id
	group by p.customer_id
)
select c1.customer_id, c1.first_name ||' ' || c1.last_name as full_name, date_diff.promedio
from customer c1 join date_diff using(customer_id));

select * from histogram('promedio_de_tiempo_entre_pagos', 'extract(epoch from promedio)')

--a mi criterio sí sigue una distribución normal, aunque no sea perfecta, porque entre el primer y tercer quartil se concentra la mayoría de los datos


--3. Qué tanto difiere ese promedio del tiempo entre rentas por cliente?

create table promedio_de_tiempo_entre_rentas as (
with t as (
	select customer_id, rental_date, row_number() over w as row_num, cast(concat(customer_id, row_number() over w) as integer) as id_temp
	from rental
	window w as (partition by customer_id)
	order by customer_id
),
t2 as (
	select customer_id, rental_date, row_number() over w as row_num, cast(concat(customer_id, row_number() over w) as integer) as id_temp
	from rental
	window w as (partition by customer_id)
	order by customer_id
)
select avg(age(t.rental_date, t2.rental_date)) as promedio, t.customer_id
from t2 join t on (t2.id_temp=t.id_temp-1)
where t.customer_id=t2.customer_id
group by t.customer_id
);

select p.full_name, p.promedio as prom_pagos, r.promedio prom_rentals, (p.promedio- r.promedio) as diferencia
from promedio_de_tiempo_entre_pagos p join promedio_de_tiempo_entre_rentas r  on (p.customer_id=r.customer_id);
