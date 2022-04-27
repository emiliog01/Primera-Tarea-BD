--Emilio González Luna


--TAREA 1 PRIMERA PARTE:

--1
select s.supplier_id, s.contact_name, s.contact_title from suppliers s where s.contact_title= 'Sales Representative';

--2
select s.supplier_id, s.contact_name from suppliers s where s.contact_title!='Marketing Manager';

--3
select o.order_id, o.ship_country  from orders o where o.ship_country!='USA';

--4
select c.category_id, c.category_name from categories c;
select p.product_id, p.product_name from products p where p.category_id=4;

--5
select o.order_id, o.ship_country from orders o where o.ship_country='France' or o.ship_country='Belgium';

--6
select o.order_id, o.ship_country from orders o order by o.ship_country;--que países de LATAM hay
select o.order_id, o.ship_country from orders o where o.ship_country='Argentina' or o.ship_country='Brazil' or o.ship_country='Mexico' or o.ship_country='Venezuela' order by o.ship_country;

--7
select o.order_id, o.ship_country from orders o where o.ship_country!='Argentina' and o.ship_country!='Brazil' and o.ship_country!='Mexico' and o.ship_country!='Venezuela' order by o.ship_country;

--8
select concat(e.first_name,' ', e.last_name) from employees e;


--9
select sum(total_per_product) as total_monetary_value from (select p.product_name, p.unit_price * p.units_in_stock as total_per_product from products p) total_monetary_value;


--10
select c.country, count(c.country) from customers c group by c.country order by c.country;



--TAREA 1 SEGUNDA PARTE:

--1
select e.last_name, e.first_name, age(e.birth_date) as edad from employees e order by edad;

--2
select o.customer_id, max(o.order_id) as orden_mas_reciente from orders o
group by o.customer_id order by o.customer_id;


--3
select c.contact_title , count(c.contact_title) from customers c
group by c.contact_title order by c.contact_title;


--4
select c.category_name, sum(p.units_in_stock) as amount from categories c 
inner join products p on (c.category_id=p.category_id)
group by c.category_id order by c.category_name;

--5
select p.product_id, p.product_name, p.reorder_level - p.units_in_stock as shortage from products p where p.units_in_stock < p.reorder_level
order by p.product_name;

--6
select concat(o.ship_address,', ',o.ship_city,', ',o.ship_country) as address, max(od.quantity) as units_imported
from order_details od
inner join orders o on (o.order_id = od.order_id)
group by o.ship_country, o.ship_city, o.ship_address 
order by units_imported desc limit 1;

--7 
select o.customer_id, count(o.customer_id) as number_of_orders_placed_by_customer,
(select count(o.order_id) from orders o)/(select count(c.customer_id) from customers c) as average_number_of_placed_orders
from orders o group by o.customer_id;
--Explicación: si el num de ordenes esta por debajo del promedio es malo. Si esta cerca del promedio regular. 
--Y si esta por arriba del promedio es buen cliente


--8
select o.employee_id from orders o inner join employees e on (o.employee_id=e.employee_id) 
where extract(month from o.shipped_date)=12 and extract(day from o.shipped_date)=25;

--9
select p.product_id, p.product_name from products p inner join order_details od on (p.product_id=od.product_id) join orders o on (od.order_id=o.order_id)
where extract(month from o.shipped_date)=12 and extract(day from o.shipped_date)=25
order by p.product_id;


--10
select o.ship_country as country, sum(od.quantity) as units_imported from orders o inner join order_details od on (o.order_id=od.order_id)
group by o.ship_country order by units_imported desc limit 1;









