-- 第五章 复杂的查询

-- 5.1 视图
-- 创建视图
CREATE VIEW ProductSum(product_type, cnt_product)
AS
SELECT product_type, COUNT(*)
FROM Product
GROUP BY product_type;

-- 使用视图
SELECT product_type, cnt_product 
FROM ProductSum;

-- 多重视图
CREATE View ProductSumJim(product_type, cnt_product)
AS
SELECT product_type, cnt_product
FROM ProductSum
WHERE product_type = '办公用品';

SELECT product_type, cnt_product
FROM ProductSumJim;

-- 视图的限制：
-- 1.定义视图时不能使用ORDER BY子句
-- 2.视图的更新，需满足：（非汇总）
-- （1）SELECT子句中未使用DISTINCT
-- （2）FROM子句中只有一张表
-- （3）未使用GROUP BY子句
-- （4）未使用HAVING子句

-- 可以更新视图的情况
CREATE VIEW ProductJim (product_id, product_name, product_type, sale_price, purchase_price, regist_date)
AS
SELECT *
FROM Product
WHERE product_type = '办公用品';

INSERT INTO ProductJim VALUES('0009', '印章', '办公用品', 95, 10, '2009-11-30');

SELECT * FROM ProductJim;

-- 删除视图
DROP VIEW ProductSum;
-- 视图被关联，使用CASCADE
DROP VIEW ProductSum CASCADE;


-- 5.2 子查询
SELECT product_type, cnt_product
FROM (
    SELECT product_type, COUNT(*) AS cnt_product
    FROM Product 
    GROUP BY product_type
) AS ProductSum;

-- 标量子查询（只返回一行一列）
SELECT product_id, product_name, sale_price
FROM Product
WHERE sale_price > AVG(sale_price);
-- 错误，WHERE子句中不能使用聚合函数

SELECT product_id, product_name, sale_price
FROM Product
WHERE sale_price > (SELECT AVG(sale_price) FROM Product);

-- SELECT子句中使用标量子查询
SELECT product_id, product_name, sale_price, (SELECT AVG(sale_price) FROM Product) AS avg_price
FROM Product;

-- HAVING子句中使用标量子查询
SELECT product_type, AVG(sale_price)
FROM Product
GROUP BY (product_type)
HAVING AVG(sale_price) > (SELECT AVG(sale_price) FROM Product);


-- 5.3 关联子查询
SELECT product_type, product_name, sale_price
FROM Product AS P1
WHERE sale_price > (
    SELECT AVG(sale_price)
    FROM Product AS P2
    WHERE P1.product_type = P2.product_type
    GROUP BY product_type
);


-- 练习题 5.1
CREATE VIEW ViewPractice5_1 
AS
SELECT product_name, sale_price, regist_date
FROM Product
WHERE sale_price >= 1000
AND regist_date = '2009-9-20';

SELECT * FROM ViewPractice5_1;

DROP VIEW ViewPractice5_1;

-- 5.2
INSERT INTO ViewPractice5_1 VALUES('刀子', 300, '2009-11-02');

-- 5.3
SELECT product_id, product_name, product_type, sale_price, (SELECT AVG(sale_price) FROM Product) AS sale_price_all
FROM Product;

-- 5.4
SELECT product_type, AVG(sale_price) 
FROM Product 
GROUP BY product_type;

CREATE VIEW AvgPriceByType AS
SELECT product_id, product_name, product_type, sale_price, 
(
    SELECT AVG(sale_price) 
    FROM Product AS P2 
    WHERE P1.product_type = P2.product_type
    GROUP BY P2.product_type
) AS avg_sale_price
FROM Product AS P1;

SELECT * FROM AvgPriceByType;