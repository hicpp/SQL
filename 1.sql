-- 1.4
-- 创建数据库
CREATE DATABASE shop;


-- 创建表
CREATE TABLE Product
(
    product_id      CHAR(4)         NOT NULL,   -- 商品编号
    product_name    VARCHAR(100)    NOT NULL,   -- 商品名称
    product_type    VARCHAR(32)     NOT NULL,   -- 商品种类
    sale_price      INTEGER ,   -- 销售单价
    purchase_price  INTEGER ,   -- 进货单价
    regist_date     DATE,   -- 登记日期
    PRIMARY KEY (product_id)
);


-- 1.5
-- 表的删除
DROP TABLE Product


-- 表定义的更新
ALTER TABLE Product ADD COLUMN product_name_pinyin VARCHAR(100);
-- ALTER TABLE Product ADD product_name_pinyin VARCHAR(100);

ALTER TABLE Product DROP COLUMN product_name_pinyin;


-- 向表中插入数据
BEGIN TRANSACTION;
INSERT INTO Product VALUES('0001', 'T恤衫', '衣服', 1000, 500, '2009-09-20');
INSERT INTO Product VALUES ('0002', '打孔器', '办公用品', 500, 320, '2009-09-11');
INSERT INTO Product VALUES ('0003', '运动T恤', '衣服', 4000, 2800, NULL);
INSERT INTO Product VALUES ('0004', '菜刀', '厨房用具', 3000, 2800, '2009-09-20');
INSERT INTO Product VALUES ('0005', '高压锅', '厨房用具', 6800, 5000, '2009-01-15');
INSERT INTO Product VALUES ('0006', '叉子', '厨房用具', 500, NULL, '2009-09-20');
INSERT INTO Product VALUES ('0007', '擦菜板', '厨房用具', 880, 790, '2008-04-28');
INSERT INTO Product VALUES ('0008', '圆珠笔', '办公用品', 100, NULL,'2009-11-11');

COMMIT;


-- 表名变更
ALTER TABLE Poduct RENAME TO Product;
-- sp_rename 'Poduct', 'Product'