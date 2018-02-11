/*

Author: Alexander P. Levchuk, M.S.
Date: 2018-02-11
Purpose: Review the intermediate SQL Chapter.  I am particularly interested in 
         exploring recursive views and updates to views.  

*/

CREATE TABLE train (
    train_number NUMBER(10),
    car_id NUMBER(10), -- Explicitly stated so this will be a relation
    car_order NUMBER(10)
    CONSTRAINT car_order_id CHECK (car_order > 0)
);

INSERT INTO train VALUES (416,4562,1);
INSERT INTO train VALUES (416,2442,5);
INSERT INTO train VALUES (416,7688,3);
INSERT INTO train VALUES (416,1723,2);
INSERT INTO train VALUES (416,8425,4);

INSERT INTO train VALUES (414,2452,4);
INSERT INTO train VALUES (414,7822,3);
INSERT INTO train VALUES (414,2456,2);
INSERT INTO train VALUES (414,6768,1);
COMMIT;

-- Consider a train where we want to determine all of the cars before each one. 
-- Solve with cartesian product
SELECT 
    t1.train_id,
    t1.car_id,
    t1.car_order,
    t2.car_id as cars_preceeding
FROM train t1, train t2
WHERE 1 = 1
    AND t1.car_order > t2.car_order
    AND t1.train_id = t2.train_id
ORDER BY 
    t1.train_id ASC,
    t1.car_order ASC,
    t2.car_order ASC
;

-- Solve with recursion
WITH prior_cars(train_id, car_id, car_order, cars_preceeding) AS
(
    SELECT t.train_id, t.car_id, t.car_order, NULL as cars_preceeding FROM train t WHERE t.car_order = 1
    UNION ALL
    SELECT 
        t.train_id, 
        t.car_id, 
        t.car_order
        ,prior_cars.car_id as cars_preceeding
    FROM train t, prior_cars
    WHERE 1 = 1
        AND prior_cars.train_id = t.train_id 
        AND prior_cars.car_order < t.car_order
        
)
SELECT distinct train_id,car_id,car_order,cars_preceeding 
FROM prior_cars
WHERE 1=1
    AND cars_preceeding IS NOT NULL
ORDER BY 
    train_id ASC,
    car_order ASC
;