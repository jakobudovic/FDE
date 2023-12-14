-- SELECT o1.o_orderkey
-- FROM orders o1
--     WHERE o1.o_totalprice < (
--         SELECT avg (o2.o_totalprice)
--         FROM orders o2
--         WHERE o2.o_shippriority = o1.o_shippriority
--         or o2.o_orderstatus = o1.o_orderstatus);
-- ORDER BY o1.o_orderkey

-- want inner query to have avg prices for all combinations of status and priority

SELECT o1.o_orderkey
FROM orders o1, 
        (SELECT avg(o2.o_totalprice) avgprice, o3.o_shippriority, o3.o_orderstatus
        FROM orders o2, 
                (SELECT DISTINCT o_shippriority, o_orderstatus
                FROM orders
                ) o3
        WHERE o2.o_shippriority = o3.o_shippriority OR o2.o_orderstatus = o3.o_orderstatus
        GROUP BY o3.o_shippriority, o3.o_orderstatus) precomputed
WHERE o1.o_totalprice < precomputed.avgprice
AND o1.o_shippriority = precomputed.o_shippriority AND o1.o_orderstatus = precomputed.o_orderstatus
ORDER BY o1.o_orderkey