create database pizzeria;

create table pizza (
pizza_id int not null AUTO_INCREMENT,
pizza_name varchar(50),
pizza_price decimal(4,2),
primary key (`pizza_id`)
);

insert into pizza(pizza_name, pizza_price)
values('Pepperoni & Cheese', 7.99);
insert into pizza(pizza_name, pizza_price)
values('Vegetarian ', 9.99);
insert into pizza(pizza_name, pizza_price)
values('Meat Lovers', 14.99);
insert into pizza(pizza_name, pizza_price)
values('Hawaiian', 12.99);

create table customer (
customer_id int not null AUTO_INCREMENT,	
customer_phone varchar(12) not null,
customer_name varchar(50),
primary key (`customer_id`)
);

insert into customer(customer_phone, customer_name)
values('226-555-4982', 'Trevor Page');
insert into customer(customer_phone, customer_name)
values('555-555-9498', 'John Doe');

create table `order`(
order_id int not null AUTO_INCREMENT, 
order_time DATETIME NOT NULL,
primary key (`order_id`)
);

insert into `order`(order_time)
values('2014-10-09 09:47:00');
insert into `order`(order_time)
values('2014-10-09 13:20:00');
insert into `order`(order_time)
values('2014-10-09 09:47:00');

create table customer_order(
customer_id int not null,
order_id int not null, 
foreign key (customer_id) REFERENCES `customer`(customer_id),
foreign key (order_id) REFERENCES `order`(order_id)
);

insert into customer_order(customer_id, order_id)
values(1,1),
(1,3),
(2,2);

create table pizza_order(
pizza_id int not null,
order_id int not null, 
foreign key (pizza_id) REFERENCES `pizza`(pizza_id),
foreign key (order_id) REFERENCES `order`(order_id)
);

insert into pizza_order(pizza_id, order_id)
values(1,1),
(3,1),(2,2),
(3,2),(3,2),
(3,3),(4,3);

-- Q4 --

select
customer.customer_id,
customer.customer_name,
sum(pizza_price) as `total`
from pizza 
join pizza_order using (pizza_id)
join `order` using (order_id)
join customer_order using (order_id)
join customer using (customer_id)

group by customer.customer_id
order by `total` desc ;

-- Q5 --

select
customer.customer_id,
customer.customer_name,
cast(order_time as date) as `order_date`,
sum(pizza_price) as `total2`
from
`order` 
join pizza_order using (order_id)
join pizza using (pizza_id)
join customer_order on customer_order.order_id = `order`.order_id
join customer on customer.customer_id = customer_order.customer_id

group by customer.customer_id, cast(order_time as date)
order by `total2` desc;