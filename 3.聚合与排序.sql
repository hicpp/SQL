-- 第三章

-- 3.1 对表进行聚合查询
-- 聚合函数 COUNT SUM AVG MAX MIN
SELECT COUNT(*) 
FROM Product;

-- COUNT(*)会得到包含NULL的数据行数
-- 而COUNT(<列名>)会得到NULL之外的数据行数。
SELECT COUNT(purchase_price) 
FROM Product;

SELECT SUM(sale_price) 
FROM Product;

-- 对列聚合操作会先排除掉NULL值
SELECT SUM(sale_price) AS "总售价", SUM(purchase_price) AS "总进价"
FROM Product;

SELECT AVG(sale_price)
FROM Product;

SELECT AVG(sale_price) AS AVG_SALE, AVG(purchase_price) AS AVG_PURCHASE
FROM Product;

SELECT MAX(sale_price), MIN(sale_price)
FROM Product;

SELECT MAX(regist_date), MIN(regist_date)
FROM Product;

-- 使用聚合函数删除重复值
SELECT DISTINCT product_type
FROM Product;

SELECT COUNT(DISTINCT product_type)
FROM Product;

SELECT SUM(sale_price) AS SUM1, SUM(DISTINCT sale_price) AS SUM2
FROM Product;


-- 3.2 对表进行分组
-- GROUP BY 子句
SELECT DISTINCT product_type, COUNT(*)
FROM Product;

SELECT product_type, COUNT(*)
FROM Product
GROUP BY product_type;

SELECT purchase_price, COUNT(*)
FROM Product
GROUP BY purchase_price;

-- 使用WHERE子句时GROUP BY的执行结果
SELECT purchase_price, COUNT(*)
FROM Product
WHERE product_type = '衣服'
GROUP BY purchase_price;
-- 语句的执行顺序 FROM → WHERE → GROUP BY → SELECT


/* 
使用聚合函数时，SELECT 子句中只能存在以下三种
元素。
● 常数
● 聚合函数
● GROUP BY子句中指定的列名（也就是聚合键）
*/

-- 常见错误① ——在SELECT子句中书写了多余的列
SELECT product_name, purchase_price, COUNT(*)
FROM Product
GROUP BY purchase_price;

-- 常见错误② ——在GROUP BY子句中写了列的别名
SELECT product_type AS pt, COUNT(*)
FROM Product
GROUP BY pt;

-- 常见错误③ —— GROUP BY子句的结果能排序吗
-- 随机的
SELECT product_type, COUNT(*)
FROM Product
GROUP BY product_type
ORDER BY product_type DESC;

-- 常见错误④ ——在WHERE子句中使用聚合函数
SELECT product_type, COUNT(*) 
FROM Product 
WHERE COUNT(*) = 2
GROUP BY product_type;


-- 3.3 为聚合结果指定条件
-- HAVING 子句
-- 语句的执行顺序 FROM → WHERE → GROUP BY → SELECT → HAVING
SELECT product_type, COUNT(*)
FROM Product
GROUP BY product_type
HAVING COUNT(*) = 2;

SELECT product_type, AVG(sale_price)
FROM Product
GROUP BY product_type
HAVING AVG(sale_price) >= 2500;
/* 
HAVING 子句中只能存在以下三种
元素。
● 常数
● 聚合函数
● GROUP BY子句中指定的列名（也就是聚合键）
*/

-- 错误
SELECT product_type, COUNT(*)
FROM Product
GROUP BY product_type -- , product_name
HAVING product_name = '圆珠笔';