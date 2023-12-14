-- Decorrelate this query
-- SELECT sum(l1.l_extendedprice)
-- FROM lineitem l1
-- WHERE l_extendedprice > (
--         SELECT avg(l2.l_extendedprice)
--         FROM lineitem l2
--         WHERE l2.l_orderkey = l1.l_orderkey);

SELECT sum(l1.l_extendedprice)
FROM lineitem l1, (
    SELECT avg(l_extendedprice) a, l_orderkey
    FROM lineitem 
    GROUP BY (l_orderkey)
) precomputed
WHERE l1.l_orderkey = precomputed.l_orderkey
and l1.l_extendedprice > a

-- OR name inner query
-- SELECT sum(l1.l_extendedprice)
-- FROM lineitem l1, (
--     SELECT avg(l2.l_extendedprice) avgPrice, l2.l_orderkey
--     FROM lineitem l2
--     GROUP BY (l2.l_orderkey)
-- ) precomputed
-- WHERE l1.l_orderkey = precomputed.l_orderkey
-- and l1.l_extendedprice > avgPrice

-- Inspect inner query:
-- SELECT avg(l2.l_extendedprice) a, l2.l_orderkey
--     FROM lineitem l2
--     GROUP BY (l2.l_orderkey)