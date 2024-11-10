select distinct r.locality_name , c.population  from real_estate_data r left join cities c on r.locality_name =c.city_name 
;
SELECT * from cities c ;

SELECT * from real_estate_data red 

--1)Cписок квартир, где доход (avg_income) меньше 20000 и площадь квартир больше 100 квм
select *
from real_estate_data r left join cities c on r.locality_name=c.city_name 
where c.avg_income < 20000 and r.total_area >100

--2)Cписок квартир, где нет аэропорта, этаж квартиры выше 20 и цена меньше 10 000 000
SELECT *
from real_estate_data r left join cities c on r.locality_name=c.city_name
where c.airports =0 and r.floor >20 and r.last_price <10000000

--3)Cписок квартир, где население (population) больше 15000 и это апартаменты
select *
from real_estate_data r left join cities c on r.locality_name =c.city_name 
where c.population >15000 and r.is_apartment ='True'

--4)Все столбцы и все строки из обеих таблиц в одной результирующей таблице
select *
from real_estate_data r full join cities c on r.locality_name =c.city_name 

--5)Cреднее население по всем объявлениям
select r.locality_name , IFNULL( avg(c.population), 'нет информации') avg_population
from real_estate_data r full join cities c on r.locality_name =c.city_name 
group by r.locality_name ;

--6)Среднее количество населения (max), среднюю площадь по населенным пунктам
SELECT
	r.locality_name ,
	    avg(c.population) avg_population,
	    avg(r.total_area) avg_total_area
FROM
	real_estate_data r
left join cities c on
	r.locality_name = c.city_name
group by
	r.locality_name;

--7)Cреднее количество аэропортов (max), среднюю цену по этажам, где площадь квартиры больше 60 квм
SELECT r.floor, sum(c.airports) from real_estate_data r left join cities c on r.locality_name =c.city_name
where r.total_area >60
group by r.floor ;


select
	distinct r.floor ,
	c.airports ,
	r.last_price
from
	real_estate_data r
left join cities c on
	r.locality_name = c.city_name
	where r.total_area >300 and r.last_price >100000000;

--8)Количество объявлений (count), 
--среднюю цену по населенным пунктам и этажам, где количество населения меньше или равно 20 000
select r.locality_name , r.floor , count(*) count, avg(r.last_price) avg_price
from
	real_estate_data r
left join cities c on
	r.locality_name = c.city_name
where c.population <=20000	;

--9)Cписок квартир, где население (population) меньше 20000 и это не апартаменты
SELECT *
from
	real_estate_data r
left join cities c on
	r.locality_name = c.city_name
WHERE c.population <20000 and r.is_apartment ='False'

--10)Город, среднее количество квартир, среднюю цену, среднее население, где квартира находится выше 20 этажа
SELECT r.locality_name , count(*)
from
	real_estate_data r
left join cities c on
	r.locality_name = c.city_name
where r.floor >20
group by r.locality_name ;

--Напишем запрос который изменяет в таблице real_estate_data в столбце locality_name значение 'посёлок Мурино' на 'поселок Мурино'
UPDATE  real_estate_data 
set locality_name='поселок Мурино'
where locality_name='посёлок Мурино';

--Напишем запрос который изменяет в таблице cities в столбце city_name значение 'посёлок Мурино' на 'поселок Мурино'
UPDATE  cities  
set city_name='поселок Мурино'
where city_name='посёлок Мурино';

--10)Город, среднее количество квартир, среднюю цену, среднее население, где квартира находится выше 20 этажа 
--среднее количество квартир ????
SELECT r.locality_name , count(*) count_flats, avg(r.last_price) avg_price, avg(c.population) avg_population
from
	real_estate_data r
left join cities c on
	r.locality_name = c.city_name
where r.floor >20
group by r.locality_name ;

 --11)Этажи, максимальную цену, среднее население, где квартира меньше 40 кв м 
--среднее население ?????
SELECT  r.floor ,MAX(r.last_price) max_price, avg(c.population) avg_population 
from 
	real_estate_data r
left join cities c on
	r.locality_name = c.city_name
where r.total_area <40
GROUP BY r.floor;	

--12)Топ 5 городов по количеству квартир (LIMIT)
SELECT locality_name , count(*) count_flats
FROM real_estate_data red 
group by locality_name 
order by count_flats desc
limit 5;

--13)Cредняя стоимость 1 кв м общей площади по городам
SELECT locality_name , round(avg(last_price /total_area)) avg_price_one_square
FROM real_estate_data red 
group by locality_name ;

--14)Cредняя стоимость 1 кв м общей площади на 1 единицу населения




