SELECT 
    t.transaction_id, 
    t.date, 
    b.branch_id, 
    b.branch_name, 
    b.kota, 
    b.provinsi, 
    t.product_id, 
    p.product_name, 
    t.customer_name, 
    t.price, 
    t.discount_percentage, 
    CASE 
        WHEN t.price <= 50000 THEN 0.10 
        WHEN t.price > 50000 AND t.price <= 100000 THEN 0.15 
        WHEN t.price > 100000 AND t.price <= 300000 THEN 0.20 
        WHEN t.price > 300000 AND t.price <= 500000 THEN 0.25 
        ELSE 0.30 
    END AS persentase_gross_laba,
    (t.price - (t.price * t.discount_percentage / 100)) AS nett_sales,
    ((t.price - (t.price * t.discount_percentage / 100)) * CASE 
        WHEN t.price <= 50000 THEN 0.10 
        WHEN t.price > 50000 AND t.price <= 100000 THEN 0.15 
        WHEN t.price > 100000 AND t.price <= 300000 THEN 0.20 
        WHEN t.price > 300000 AND t.price <= 500000 THEN 0.25 
        ELSE 0.30 
    END) AS nett_profit,
    b.rating AS rating_transaksi
FROM `dataset_rakamin.kf_final_transaction` t
JOIN `dataset_rakamin.kf_product` p ON t.product_id = p.product_id
JOIN `dataset_rakamin.kf_kantor_cabang` b ON t.branch_id = b.branch_id;