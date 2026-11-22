-- создаем таблицу пользователей
CREATE TABLE users (
    user_id INT,
    "group" VARCHAR(10),
    age INT,
    city VARCHAR(50),
    device_type VARCHAR(20)
);

-- создаем таблицу платежей
CREATE TABLE payments (
    payment_id INT,
    user_id INT,
    "group" VARCHAR(10),
    step1_opened TIMESTAMP,
    step2_entered TIMESTAMP,
    step3_confirmed TIMESTAMP,
    step4_success TIMESTAMP
);

-- предварительный осмотр данных, выявление ошибок
SELECT * FROM payments LIMIT 5;
SELECT 
    COUNT(payment_id) AS total_payments, 
    COUNT(step1_opened) AS step1,        
    COUNT(step2_entered) AS step2,       
    COUNT(step3_confirmed) AS step3,     
    COUNT(step4_success) AS step4        
FROM payments;
SELECT user_id, "group", age, city 
FROM users 
WHERE age < 0 OR age > 100 OR "group" IS NULL;
SELECT * FROM payments WHERE user_id IS NULL;
 --получение конверсий по отфильтрованным данным
WITH clean_data AS (
    SELECT 
        p.payment_id,
        u."group", 
        p.step1_opened,
        p.step4_success
    FROM payments p
    JOIN users u ON p.user_id = u.user_id
    WHERE u.age > 0 AND u.age < 100 
      AND u."group" IN ('A', 'B')   
      AND p.user_id IS NOT NULL     
      AND p.step1_opened IS NOT NULL 
)

SELECT 
    "group",
    COUNT(payment_id) AS step1_total,
    COUNT(step4_success) AS step4_success_total,
    ROUND((COUNT(step4_success)::numeric / COUNT(payment_id)) * 100, 2) AS conversion_rate_percent
FROM clean_data
GROUP BY "group"
ORDER BY "group";

