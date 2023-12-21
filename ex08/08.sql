-- check: ROLLUP, CUBE


-- Exercise 1
-- Solution 5.1.1:
SELECT sum(1_quantity * 1_extendedprice)
FROM lineitem, orders, customer, nation
WHERE 1_orderkey = o_orderkey
    and o_custkey = c_custkey
    and c_nationkey = n_nationkey
    and c_mktsegment = 'AUTOMOBILE'
    and n_name = 'UNITED STATES';

-- Solution 5.1.2:
SELECT sum(1_quantity * 1_extendedprice)
FROM lineitem, orders, customer, supplier
    WHERE 1_orderkey = o_orderkey
    and o_custkey = c_custkey
    and l_suppkey = s_suppkey
    and s_nationkey = c_nationkey;


-- 2
-- CREATE TABLE volume_cube(
--     volume bigint,
--     c_mktsegment character(10),
--     c_nationkey integer,
--     s_nationkey integer
-- );

-- INSERT INTO volume_cube
-- SELECT sum(l_quantity * l_extendedprice), c_mktsegment, c_nationkey, s_nationkey
-- FROM lineitem, orders, customer, supplier
-- WHERE l_orderkey = o_orderkey
--     and o_custkey = c_custkey
--     and l_suppkey = s_suppkey
-- GROUP BY cube(c_mktsegment, c_nationkey, s_nationkey);



-- 3
SELECT sum(l_quantity * l_extendedprice), c_mktsegment, c_nationkey, s_nationkey
FROM lineitem, orders, customer, supplier
WHERE l_orderkey = o_orderkey
    and o_custkey = c_custkey
    and l_suppkey = s_suppkey
GROUP BY cube(p_partkey, ps_partkey, o_orderkey, c_custkey);

