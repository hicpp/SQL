-- 2.1 查询SELECT

-- 列的查询
SELECT product_id, product_name, purchase_price 
FROM Product;
SELECT * 
FROM Product;

-- 为列设定别名
SELECT product_id AS id, product_name AS name, purchase_price AS price 
FROM Product;
SELECT product_id AS "商品编号", product_name AS "商品名称", purchase_price AS "进货单价" 
FROM Product;

-- 常数的查询
SELECT '商品' AS string, 38 AS number, '2009-02-24' AS date, product_id, product_name 
FROM Product;

-- 从结果中删除重复行
SELECT DISTINCT product_type 
FROM Product;

SELECT DISTINCT purchase_price 
FROM Product;

SELECT DISTINCT product_type, regist_date 
FROM Product;

-- 根据WHERE语句来选择记录
SELECT product_name, product_type -- step 2
FROM Product 
WHERE product_type = '衣服'; -- step 1


-- 2.2
-- 算术运算符
SELECT product_name, sale_price, sale_price * 2 AS sale_price_x2
FROM Product;

SELECT product_name, purchase_price, purchase_price * 2 AS purchase_price
FROM Product;

-- 比较运算符(=, <>, >=, >, <=, <)
SELECT product_name, product_type
FROM Product
WHERE sale_price = 500;

SELECT product_name, product_type
FROM Product
WHERE sale_price <> 500;

SELECT product_name, product_type, sale_price
FROM Product
WHERE sale_price >= 1500;

SELECT product_name, product_type, regist_date
FROM Product
WHERE regist_date < '2009-09-27';

-- 对字符串使用不等号时的注意事项
CREATE TABLE Chars
(
    chr CHAR (3) NOT NULL ,
    PRIMARY KEY (chr)
);

BEGIN TRANSACTION;
INSERT INTO Chars VALUES('1');
INSERT INTO Chars VALUES ('2');
INSERT INTO Chars VALUES ('3');
INSERT INTO Chars VALUES ('10');
INSERT INTO Chars VALUES ('11');
INSERT INTO Chars VALUES ('222');

COMMIT ;


SELECT chr
FROM Chars
WHERE chr > '2'

-- 不能对NULL使用比较运算符