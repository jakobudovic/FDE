-- select count(distinct o_custkey) from orders where o_comment like '%packages%';

-- select avg(char_length (l_orderkey::text)) from lineitem 
-- select avg(char_length(CAST(l_orderkey AS text))) from lineitem 

-- select c_name from customer
-- union all
-- select s_name from supplier

-- select c_name, n_name from customer, nation where c_nationkey = n_nationkey limit 10;


-- TPC-H Query 17
-- SELECT sum(l_extendedprice) / 7.0 as avg_yearly
-- FROM lineitem, part
-- WHERE p_partkey = l_partkey
--         and p_brand = 'Brand#23'
--         and p_container = 'MED BOX'
--         and l_quantity < (
--                 SELECT 0.2 * avg(l_quantity)
--                 FROM lineitem
--                 WHERE l_partkey = p_partkey
--         )

SELECT sum(l_extendedprice) / 7.0 as avg_yearly
FROM lineitem l, part p, (SELECT 0.2 * avg(l_quantity) avg, l_partkey
                FROM lineitem
                WHERE l_partkey = p_partkey) tmp
WHERE p.p_partkey = l.l_partkey
        and p.p_partkey = tmp.l_partkey
        and p.p_brand = 'Brand#23'
        and p.p_container = 'MED BOX'
        and l.l_quantity < tmp.avg

-- lecture
select year, revenue, cast((revenue-prev)*100/prev as numeric(10,2)) from (select year, revenue, lag(revenue, 1) over(order by year) as prev from (select year, sum(o_totalprice) from extract(year from o_orderdate) as year from orders) orders group by year) s order by year;

select o_orderdate, o_totalprice, sum(o_totalprice) over(order by o_orderdate rows between unbounded preceding and current row) from orders limit 10;

select c_custkey, year, sum(o_totalprice) sum from (select c_custkey, o_totalprice, extract(year from o_orderdate) as year from customer, nation, orders where c_nationkey=n_nationkey and n_name='GERMANY' and o_custkey=c_custkey) s group by c_custkey, year limit 10
select c_custkey, year, sum(total) over (partition by c_custkey order by year) from (select c_custkey, year, sum(o_totalprice) total from  (select c_custkey, o_totalprice, extract(year from o_orderdate) as year from customer, nation, orders where c_nationkey=n_nationkey and n_name='GERMANY' and o_custkey=c_custkey) s group by c_custkey, year) s limit 10
