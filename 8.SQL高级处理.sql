-- 8.1 窗口函数
-- 窗口函数大体可以分为以下两种。
-- ① 能够作为窗口函数的聚合函数（SUM、AVG、COUNT、MAX、MIN）
-- ② RANK、DENSE_RANK、ROW_NUMBER 等专用窗口函数

-- 使用RANK函数
-- 按照商品种类分组后的排序
SELECT product_name, product_type, sale_price, 
    RANK() OVER (PARTITION BY product_type ORDER BY sale_price) AS ranking
FROM product;
-- PARTITION BY 能够设定排序的对象范围
-- ORDER BY 能够指定按照哪一列、何种顺序进行排序
-- PARTITION BY 在横向上对表进行分组，而ORDER BY决定了纵向排序的规则

-- 窗口函数兼具分组和排序两种功能。

-- 全部商品的排序
SELECT product_name, product_type, sale_price,
    RANK() OVER (ORDER BY sale_price) AS ranking
FROM product;


-- 比较RANK、DENSE_RANK、ROW_NUMBER的结果
SELECT product_name, product_type, sale_price,
    RANK() OVER (ORDER BY sale_price) AS ranking,
    DENSE_RANK() OVER (ORDER BY sale_price) AS dense_ranking,
    ROW_NUMBER() OVER (ORDER BY sale_price) AS row_num
FROM product;


-- 将SUM函数作为窗口函数使用
SELECT product_id, product_name, sale_price,
    SUM(sale_price) OVER (ORDER BY product_id) AS current_sum
FROM Product;


-- 将AVG函数作为窗口函数使用
SELECT product_id, product_name, sale_price,
    AVG (sale_price) OVER (ORDER BY product_id) AS current_avg
FROM Product;

-- 指定“最靠近的3行”作为汇总对象
SELECT product_id, product_name, sale_price,
    AVG (sale_price) OVER (ORDER BY product_id ROWS 2 PRECEDING) AS moving_avg
FROM Product;

-- 将当前记录的前后行作为汇总对象
SELECT product_id, product_name, sale_price,
    AVG (sale_price) OVER (ORDER BY product_id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS moving_avg
FROM Product;

-- 在语句末尾使用ORDER BY子句对结果进行排序
SELECT product_name, product_type, sale_price,
    RANK () OVER (ORDER BY sale_price) AS ranking
FROM Product
ORDER BY ranking;



-- 8.2 GROUPING运算符

-- 合计        16780
-- 厨房用具    11180
-- 衣服        5000
-- 办公用品    600

-- 使用GROUP BY无法得到合计行
SELECT product_type, SUM(sale_price) as sum
FROM product
GROUP BY product_type;

-- UNION ALL实现需要两次SELECT，开销大
SELECT '合计' AS product_type, SUM(sale_price)
FROM product
UNION ALL 
SELECT product_type, SUM(sale_price) as sum
FROM product
GROUP BY product_type;


-- ROLLUP的使用方法(超级分组记录默认使用NULL作为聚合键。)
SELECT product_type, SUM(sale_price) AS sum_price
FROM Product
GROUP BY ROLLUP(product_type);

SELECT product_type, regist_date, SUM(sale_price) AS sum_price
FROM Product
GROUP BY product_type, regist_date;

SELECT product_type, regist_date, SUM(sale_price) AS sum_price
FROM Product
GROUP BY ROLLUP(product_type, regist_date);

-- 使用GROUPING函数来判断NULL
SELECT GROUPING(product_type) AS product_type,
    GROUPING(regist_date) AS regist_date,
    SUM(sale_price) AS sum_price
FROM Product
GROUP BY ROLLUP(product_type, regist_date);

SELECT 
    CASE WHEN GROUPING(product_type) = 1 
        THEN '商品种类 合计' 
        ELSE product_type END AS product_type,
    CASE WHEN GROUPING(regist_date) = 1 
        THEN '登记日期 合计' 
        ELSE CAST(regist_date AS VARCHAR(16)) END AS regist_date,
    SUM(sale_price) AS sum_price
FROM Product
GROUP BY ROLLUP(product_type, regist_date);
-- CAST（regist_date AS VARCHAR（16） CASE 表达式所有分支的返回值必须一致

-- CUBE，就是将GROUP BY 子句中聚合键的“所有可能的组合”的汇总结果集中到一个结果中
SELECT 
    CASE WHEN GROUPING(product_type) = 1 
        THEN '商品种类 合计' 
        ELSE product_type END AS product_type,
    CASE WHEN GROUPING(regist_date) = 1 
        THEN '登记日期 合计' 
        ELSE CAST(regist_date AS VARCHAR(16)) END AS regist_date,
    SUM(sale_price) AS sum_price
FROM Product
GROUP BY CUBE(product_type, regist_date);


-- 使用GROUPING SETS取得部分组合的结果
SELECT 
    CASE WHEN GROUPING(product_type) = 1 
        THEN '商品种类 合计' 
        ELSE product_type END AS product_type,
    CASE WHEN GROUPING(regist_date) = 1 
        THEN '登记日期 合计' 
        ELSE CAST(regist_date AS VARCHAR(16)) END AS regist_date,
    SUM(sale_price) AS sum_price
FROM Product
GROUP BY GROUPING SETS(product_type, regist_date);



-- 练习 8.1
SELECT product_id, product_name, sale_price,
    MAX (sale_price) OVER (ORDER BY product_id) AS current_max_price
FROM Product;

-- 8.2
SELECT regist_date, product_name, sale_price, 
    SUM(sale_price) OVER(ORDER BY regist_date NULLS FIRST) AS sum
FROM product;

SELECT regist_date, product_name, sale_price,
    SUM (sale_price) OVER (ORDER BY COALESCE(regist_date, CAST('0001-01-01' AS DATE))) AS current_sum_price
FROM Product;