--创建数据库
CREATE DATABASE shop;


-- 创建表
CREATE TABLE Product
(
    product_id      CHAR(4)         NOT NULL,   -- 商品编号
    product_name    VARCHAR(100)    NOT NULL,   -- 商品名称
    product_type    VARCHAR(32)     NOT NULL,   -- 商品种类
    sale_price      INTEGER ,                   -- 销售单价
    purchase_price  INTEGER ,                   -- 进货单价
    regist_date     DATE    ,                   -- 登记日期
    PRIMARY KEY (product_id)
);


