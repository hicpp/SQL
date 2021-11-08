-- 第四章 数据更新
-- 4.1 插入INSERT
CREATE TABLE ProductIns
(product_id CHAR(4) NOT NULL,
product_name VARCHAR(100) NOT NULL,
product_type VARCHAR(32) NOT NULL,
sale_price INTEGER DEFAULT 0,
purchase_price INTEGER ,
regist_date DATE ,
PRIMARY KEY (product_id));

INSERT INTO ProductIns (product_id, product_name, product_type, sale_price, purchase_price, regist_date) VALUES ('0001', 'T恤衫', '衣服', 1000, 500, '2009-09-20');

-- 错误，缺少一列
INSERT INTO ProductIns (product_id, product_name, product_type, sale_price, purchase_price, regist_date) VALUES ('0001', 'T恤衫', '衣服', 1000, 500);


-- 多行插入
INSERT INTO ProductIns VALUES ('0002', '打孔器', '办公用品', 500, 320, '2009-09-11');
INSERT INTO ProductIns VALUES ('0003', '运动T恤', '衣服', 4000, 2800, NULL);
INSERT INTO ProductIns VALUES ('0004', '菜刀', '厨房用具', 3000, 2800, '2009-09-20');

-- 多行INSERT （Oracle以外）
INSERT INTO ProductIns 
VALUES ('0002', '打孔器', '办公用品', 500, 320, '2009-09-11'),
('0003', '运动T恤', '衣服', 4000, 2800, NULL),
('0004', '菜刀', '厨房用具', 3000, 2800, '2009-09-20');


-- 省略列清单
INSERT INTO ProductIns VALUES ('0005', '高压锅', '厨房用具', 6800, 5000, '2009-01-15');

-- 显式方法插入默认值
INSERT INTO ProductIns (product_id, product_name, product_type, sale_price, purchase_price, regist_date) VALUES ('0006', '擦菜板', '厨房用具', DEFAULT, 790, '2009-04-28');

-- 隐式方法插入默认值（忽略它）
INSERT INTO ProductIns (product_id, product_name, product_type, purchase_price, regist_date) VALUES ('0007', '擦菜板', '厨房用具', 790, '2009-04-28');

-- 省略INSERT语句中的列名，就会自动设定为该列的默认值（没有默认值时会设定为NULL）。


SELECT * FROM ProductIns;
DELETE FROM ProductIns
WHERE product_id = '0007';



-- 从其他表中复制数据
CREATE TABLE ProductCopy
(product_id CHAR(4) NOT NULL,
product_name VARCHAR(100) NOT NULL,
product_type VARCHAR(32) NOT NULL,
sale_price INTEGER ,
purchase_price INTEGER ,
regist_date DATE ,
PRIMARY KEY (product_id));

INSERT INTO ProductCopy 
SELECT * FROM Product;

SELECT * FROM ProductCopy;




CREATE TABLE ProductType
(product_type VARCHAR(32) NOT NULL,
sum_sale_price INTEGER ,
sum_purchase_price INTEGER ,
PRIMARY KEY (product_type));

INSERT INTO ProductType (product_type, sum_sale_price, sum_purchase_price)
SELECT product_type, SUM(sale_price), SUM(purchase_price)
FROM Product
GROUP BY product_type;

SELECT * FROM ProductType;



-- 4.2 数据的删除DELETE
DELETE FROM Product
WHERE sale_price >= 4000;

-- 删除和舍弃
TRUNCATE Product;

-- 4.3 数据的更新UPDATE
UPDATE Product
SET regist_date = '2009-10-10';

UPDATE Product
SET sale_price = sale_price * 10
WHERE product_type = '厨房用具';

UPDATE Product
SET regist_date = NULL
WHERE product_id = '0008';


-- 多列更新
-- 使用逗号对列进行分隔排列
UPDATE Product
SET sale_price = sale_price * 10,
purchase_price = purchase_price / 2
WHERE product_type = '厨房用具';

-- 将列用()括起来的清单形式
UPDATE Product
SET (sale_price, purchase_price) = (sale_price * 10, 
purchase_price / 2)
WHERE product_type = '厨房用具';


-- 4.4 事务
BEGIN TRANSACTION;
-- 将运动T恤的销售单价降低1000日元
UPDATE Product
SET sale_price = sale_price - 10
WHERE product_name = '运动T恤';
-- 将T恤衫的销售单价上浮1000日元
UPDATE Product
SET sale_price = sale_price + 100
WHERE product_name = 'T恤衫';
COMMIT;

-- 事务回滚
BEGIN TRANSACTION; ------------------- ①
-- 将运动T恤的销售单价降低1000日元
UPDATE Product
SET sale_price = sale_price - 10
WHERE product_name = '运动T恤';
-- 将T恤衫的销售单价上浮1000日元
UPDATE Product
SET sale_price = sale_price + 100
WHERE product_name = 'T恤衫';
ROLLBACK;

SELECT product_name, sale_price
FROM Product
WHERE product_name LIKE '%T%';