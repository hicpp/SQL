-- 6.1 函数
-- 算术函数、字符串函数、日期函数、转换函数、聚合函数

-- DDL ：创建表
CREATE TABLE SampleMath
(m NUMERIC (10,3),
n INTEGER,
p INTEGER);

-- DML ：插入数据
BEGIN TRANSACTION;
INSERT INTO SampleMath(m, n, p) VALUES (500, 0, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (-180, 0, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (NULL, NULL, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (NULL, 7, 3);
INSERT INTO SampleMath(m, n, p) VALUES (NULL, 5, 2);
INSERT INTO SampleMath(m, n, p) VALUES (NULL, 4, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (8, NULL, 3);
INSERT INTO SampleMath(m, n, p) VALUES (2.27, 1, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (5.555,2, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (NULL, 1, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (8.76, NULL, NULL);
COMMIT;


SELECT * FROM SampleMath;

-- ABS 绝对值
SELECT m, ABS(m) AS abs_col
FROM SampleMath;

-- MODE 取余
SELECT n, p, MOD(n, p) AS mod_col
FROM SampleMath;

SELECT n, p,
n % p AS mod_col
FROM SampleMath;

-- ROUND 四舍五入
SELECT m, n, ROUND(m, n) AS round_col
FROM SampleMath;


-- DDL ：创建表
CREATE TABLE SampleStr
(str1 VARCHAR(40),
str2 VARCHAR(40),
str3 VARCHAR(40));

-- DML ：插入数据
BEGIN TRANSACTION;
INSERT INTO SampleStr (str1, str2, str3) VALUES ('opx', 'rt', NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('abc', 'def', NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('山田', '太郎' ,'是我');
INSERT INTO SampleStr (str1, str2, str3) VALUES ('aaa', NULL, NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES (NULL, 'xyz', NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('@!#$%', NULL, NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('ABC', NULL, NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('aBC', NULL, NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('abc太郎', 'abc', 'ABC');
INSERT INTO SampleStr (str1, str2, str3) VALUES ('abcdefabc', 'abc', 'ABC');
INSERT INTO SampleStr (str1, str2, str3) VALUES ('micmic', 'i', 'I');
COMMIT;

SELECT * FROM SampleStr;

-- || 拼接
SELECT str1, str2, str1 || str2 AS str_concat
FROM SampleStr;

SELECT str1, str2, str3, str1 || str2 || str3 AS str_concat
FROM SampleStr
WHERE str1 = '山田';

SELECT str1, str2, CONCAT(str1, str2) AS str_concat
FROM SampleStr;

-- LENGTH 字符串长度
SELECT str1, LENGTH(str1) AS len_str
FROM SampleStr;

-- LOWER 小写
SELECT str1, LOWER(str1) AS low_str
FROM SampleStr;

-- UPPER 大写
SELECT str1, UPPER(str1) as up_str
FROM SampleStr;

-- REPLACE 替换
SELECT str1, str2, str3, REPLACE(str1, str2, str3) AS rep_str
FROM SampleStr;

-- SUBSTRING 字符串的截取
SELECT str1, SUBSTRING(str1 FROM 3 FOR 2) AS sub_str
FROM SampleStr;

SELECT str1, SUBSTR(str1, 3, 2) AS sub_str
FROM SampleStr;

-- CURRENT_DATE 日期
SELECT CURRENT_DATE;

-- 当前时间
SELECT CURRENT_TIME;

-- 当前日期时间
SELECT CURRENT_TIMESTAMP;

-- EXTRACT 截取日期元素
SELECT CURRENT_TIMESTAMP, 
EXTRACT(YEAR FROM CURRENT_TIMESTAMP) AS year,
EXTRACT(MONTH FROM CURRENT_TIMESTAMP) AS month,
EXTRACT(DAY FROM CURRENT_TIMESTAMP) AS day,
EXTRACT(HOUR FROM CURRENT_TIMESTAMP) AS hour,
EXTRACT(MINUTE FROM CURRENT_TIMESTAMP) AS minute,
EXTRACT(SECOND FROM CURRENT_TIMESTAMP) AS second;


-- CAST 类型转换
SELECT CAST('0001' AS INTEGER) AS int_col;
SELECT CAST('2009-12-14' AS DATE) AS date_col;

-- COALESCE NULL转换
SELECT COALESCE(NULL, 1) as col_1,
COALESCE(NULL, 'test', NULL) as col_2,
COALESCE(NULL, NULL, '2009-12-14') as col_3;

SELECT COALESCE(str2, 'NULL')
FROM SampleStr;

SELECT str2 FROM SampleStr;


-- 6.2 谓词
-- DDL ：创建表
CREATE TABLE SampleLike
(strcol VARCHAR(6) NOT NULL,
PRIMARY KEY (strcol));

-- DML ：插入数据
BEGIN TRANSACTION;
INSERT INTO SampleLike (strcol) VALUES ('abcddd');
INSERT INTO SampleLike (strcol) VALUES ('dddabc');
INSERT INTO SampleLike (strcol) VALUES ('abdddc');
INSERT INTO SampleLike (strcol) VALUES ('abcdd');
INSERT INTO SampleLike (strcol) VALUES ('ddabc');
INSERT INTO SampleLike (strcol) VALUES ('abddc');
COMMIT;


-- LIKE 部分一致查询
SELECT *
FROM SampleLike
WHERE strcol LIKE 'ddd%';

SELECT *
FROM SampleLike
WHERE strcol LIKE '%ddd%';

SELECT *
FROM SampleLike
WHERE strcol LIKE '%ddd';

SELECT *
FROM SampleLike
WHERE strcol LIKE 'abc__';

SELECT *
FROM SampleLike
WHERE strcol LIKE 'abc___';

-- BETWEEN 查询范围
SELECT product_name, sale_price
FROM Product
WHERE sale_price BETWEEN 100 AND 1000;

-- IS NULL、IS NOT NULL 判断是否为NULL
SELECT product_name, purchase_price
FROM Product
WHERE purchase_price IS NULL;

-- IN谓词 OR的简便用法
SELECT product_name, purchase_price
FROM Product
WHERE purchase_price IN (320, 500, 5000);

-- 使用子查询作为IN谓词的参数
CREATE TABLE ShopProduct
(shop_id CHAR(4) NOT NULL,
shop_name VARCHAR(200) NOT NULL,
product_id CHAR(4) NOT NULL,
quantity INTEGER NOT NULL,
PRIMARY KEY (shop_id, product_id));

BEGIN TRANSACTION;
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000A', '东京', '0001', 30);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000A', '东京', '0002', 50);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000A', '东京', '0003', 15);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000B', '名古屋', '0002', 30);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000B', '名古屋', '0003', 120);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000B', '名古屋', '0004', 20);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000B', '名古屋', '0006', 10);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000B', '名古屋', '0007', 40);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000C', '大阪', '0003', 20);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000C', '大阪', '0004', 50);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000C', '大阪', '0006', 90);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000C', '大阪', '0007', 70);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000D', '福冈', '0001', 100);
COMMIT;

SELECT product_name, sale_price
FROM Product
WHERE product_id IN (SELECT product_id
    FROM ShopProduct
    WHERE shop_id = '000C');

-- NOT IN和子查询
SELECT product_name, sale_price
FROM Product
WHERE product_id NOT IN (SELECT product_id
    FROM ShopProduct
    WHERE shop_id = '000A');

-- EXIST谓词
-- EXIST 只关心记录是否存在，因此返回哪些列都没有关系
SELECT * FROM ShopProduct;
-- 使用EXIST选取出“大阪店在售商品的销售单价”
SELECT product_name, sale_price
FROM Product
WHERE product_id IN (SELECT product_id FROM ShopProduct WHERE shop_id = '000C');

SELECT product_name, sale_price
FROM Product AS P
WHERE EXISTS(SELECT * 
    FROM ShopProduct AS SP
    WHERE SP.shop_id = '000C'
    AND SP.product_id = P.product_id);

SELECT product_name, sale_price
FROM Product AS P
WHERE EXISTS(SELECT 1 
    FROM ShopProduct AS SP
    WHERE SP.shop_id = '000C'
    AND SP.product_id = P.product_id);

SELECT product_name, sale_price
FROM Product AS P
WHERE NOT EXISTS(SELECT * 
    FROM ShopProduct AS SP
    WHERE SP.shop_id = '000A'
    AND SP.product_id = P.product_id);


-- 搜索CASE表达式
SELECT product_name,
    CASE WHEN product_type = '衣服' THEN 'A ：' || product_type
        WHEN product_type = '办公用品' THEN 'B ：' || product_type
        WHEN product_type = '厨房用具' THEN 'C ：' || product_type
        ELSE NULL
    END AS abc_product_type
FROM Product;

SELECT product_name,
    CASE product_type
        WHEN '衣服' THEN 'A ：' || product_type
        WHEN '办公用品' THEN 'B ：' || product_type
        WHEN '厨房用具' THEN 'C ：' || product_type
        ELSE NULL
    END AS abc_product_type
FROM Product;

-- GROUP BY 行形式
-- CASE 行转列
SELECT SUM(CASE WHEN product_type = '衣服' THEN sale_price ELSE 0 END) AS sum_price_clothes,
SUM(CASE WHEN product_type = '厨房用具' THEN sale_price ELSE 0 END) AS sum_price_kitchen,
SUM(CASE WHEN product_type = '办公用品' THEN sale_price ELSE 0 END) AS sum_price_office
FROM Product;


-- 练习 6.1
SELECT product_name, purchase_price
FROM Product
WHERE purchase_price NOT IN (500, 2800, 5000);

SELECT product_name, purchase_price
FROM Product
WHERE purchase_price NOT IN (500, 2800, 5000, NULL);

-- 6.2
SELECT SUM(CASE WHEN sale_price <= 1000 THEN 1 ELSE 0 END) AS low_price,
SUM(CASE WHEN sale_price >= 1001 AND sale_price <= 3000 THEN 1 ELSE 0 END) AS mid_price,
SUM(CASE WHEN sale_price >= 3001 THEN 1 ELSE 0 END) AS high_price
FROM Product;