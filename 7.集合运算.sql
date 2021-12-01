-- 7.1表的加减法

-- UNION 表的加法（并集）
CREATE TABLE Product2
(product_id CHAR(4) NOT NULL,
product_name VARCHAR(100) NOT NULL,
product_type VARCHAR(32) NOT NULL,
sale_price INTEGER ,
purchase_price INTEGER ,
regist_date DATE ,
PRIMARY KEY (product_id));

BEGIN TRANSACTION;
INSERT INTO Product2 VALUES ('0001', 'T恤衫' ,'衣服', 1000, 500, '2008-09-20');
INSERT INTO Product2 VALUES ('0002', '打孔器', '办公用品', 500, 320, '2009-09-11');
INSERT INTO Product2 VALUES ('0003', '运动T恤', '衣服', 4000, 2800, NULL);
INSERT INTO Product2 VALUES ('0009', '手套', '衣服', 800, 500, NULL);
INSERT INTO Product2 VALUES ('0010', '水壶', '厨房用具', 2000, 1700, '2009-09-20');
COMMIT;


SELECT product_id, product_name
FROM Product
UNION
SELECT product_id, product_name
FROM Product2
ORDER BY product_id;

-- 列数不一致时会发生错误
SELECT product_id, product_name
FROM Product
UNION
SELECT product_id, product_name, sale_price
FROM Product2;

-- 数据类型不一致时会发生错误
SELECT product_id, sale_price
FROM Product
UNION
SELECT product_id, regist_date
FROM Product2;

-- ORDER BY子句只在最后使用一次

-- 包含重复行的集合运算 ALL选项
SELECT product_id, product_name
FROM Product
UNION ALL
SELECT product_id, product_name
FROM Product2;

-- 选取表中公共部分 INTERSECT（交集）
SELECT product_id, product_name
FROM Product
INTERSECT
SELECT product_id, product_name
FROM Product2;

-- 记录的减法 EXCEPT（差集）
SELECT product_id, product_name
FROM Product
EXCEPT
SELECT product_id, product_name
FROM Product2;

SELECT product_id, product_name
FROM Product2
EXCEPT
SELECT product_id, product_name
FROM Product;


-- 7.2 联结
-- 内联结 INNER JOIN
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price
FROM ShopProduct AS SP
INNER JOIN Product AS P 
ON SP.product_id = P.product_id;

SELECT P.product_name, P.sale_price, P.product_id, SP.shop_id, SP.shop_name
FROM Product AS P INNER JOIN ShopProduct AS SP
ON P.product_id = SP.product_id;


-- 外联结 OUTER JOIN
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price
FROM ShopProduct AS SP
RIGHT OUTER JOIN Product AS P 
ON SP.product_id = P.product_id;

SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price
FROM ShopProduct AS SP
LEFT OUTER JOIN Product AS P 
ON SP.product_id = P.product_id;

-- 外联结要点① ——选取出单张表中全部的信息


-- 3张以上的表的联结

-- DDL ：创建表
CREATE TABLE InventoryProduct
(
    inventory_id CHAR (4) NOT NULL ,
    product_id CHAR (4) NOT NULL ,
    inventory_quantity INTEGER NOT NULL ,
    PRIMARY KEY (inventory_id, product_id)
);

-- DML ：插入数据
BEGIN TRANSACTION;
INSERT INTO InventoryProduct VALUES ('P001', '0001', 0);
INSERT INTO InventoryProduct VALUES ('P001', '0002', 120);
INSERT INTO InventoryProduct VALUES ('P001', '0003', 200);
INSERT INTO InventoryProduct VALUES ('P001', '0004', 3);
INSERT INTO InventoryProduct VALUES ('P001', '0005', 0);
INSERT INTO InventoryProduct VALUES ('P001', '0006', 99);
INSERT INTO InventoryProduct VALUES ('P001', '0007', 999);
INSERT INTO InventoryProduct VALUES ('P001', '0008', 200);
INSERT INTO InventoryProduct VALUES ('P002', '0001', 10);
INSERT INTO InventoryProduct VALUES ('P002', '0002', 25);
INSERT INTO InventoryProduct VALUES ('P002', '0003', 34);
INSERT INTO InventoryProduct VALUES ('P002', '0004', 19);
INSERT INTO InventoryProduct VALUES ('P002', '0005', 99);
INSERT INTO InventoryProduct VALUES ('P002', '0006', 0);
INSERT INTO InventoryProduct VALUES ('P002', '0007', 0);
INSERT INTO InventoryProduct VALUES ('P002', '0008', 18);
END TRANSACTION;


SELECT * FROM inventoryproduct;


SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price, IP.inventory_quantity
FROM ShopProduct AS SP
INNER JOIN Product AS P 
ON SP.product_id = P.product_id
INNER JOIN InventoryProduct AS IP
ON SP.product_id = IP.product_id;


-- 交叉联结 CROSS JOIN
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price
FROM ShopProduct AS SP
CROSS JOIN Product AS P;
-- 交叉联结是对两张表中的全部记录进行交叉组合，因此结果中的记录数通常是两张表中行数的乘积。



-- 专栏
-- DDL ：创建表
CREATE TABLE Skills (
    skill VARCHAR(32), 
    PRIMARY KEY(skill)
);
CREATE TABLE EmpSkills (
    emp VARCHAR(32),
    skill VARCHAR(32),
    PRIMARY KEY(emp, skill)
);

-- DML ：插入数据
BEGIN TRANSACTION;
INSERT INTO Skills VALUES('Oracle');
INSERT INTO Skills VALUES('UNIX');
INSERT INTO Skills VALUES('Java');
INSERT INTO EmpSkills VALUES('相田', 'Oracle');
INSERT INTO EmpSkills VALUES('相田', 'UNIX');
INSERT INTO EmpSkills VALUES('相田', 'Java');
INSERT INTO EmpSkills VALUES('相田', 'C#');
INSERT INTO EmpSkills VALUES('神崎', 'Oracle');
INSERT INTO EmpSkills VALUES('神崎', 'UNIX');
INSERT INTO EmpSkills VALUES('神崎', 'Java');
INSERT INTO EmpSkills VALUES('平井', 'UNIX');
INSERT INTO EmpSkills VALUES('平井', 'Oracle');
INSERT INTO EmpSkills VALUES('平井', 'PHP');
INSERT INTO EmpSkills VALUES('平井', 'Perl');
INSERT INTO EmpSkills VALUES('平井', 'C++');
INSERT INTO EmpSkills VALUES('若田部', 'Perl');
INSERT INTO EmpSkills VALUES('渡来', 'Oracle');
COMMIT;

SELECT * FROM Skills;
SELECT * FROM EmpSkills;

-- 选取出掌握所有3个领域的技术的员工
SELECT DISTINCT emp
FROM EmpSkills AS ES
WHERE NOT EXISTS (
    SELECT skill FROM Skills
    EXCEPT
    SELECT skill FROM EmpSkills AS ES2
    WHERE ES.emp = ES2.emp
);

