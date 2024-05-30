SELECT * FROM hotel_reservation_dataset
-- 1.What is the total number of reservations in in the dataset?
SELECT COUNT(*) AS "Number_Of_Reservations"
FROM hotel_reservation_dataset;
-- 2. Which meal plan is most popular
-- among guests 
SELECT type_of_meal_plan,
    COUNT(type_of_meal_plan) AS No_of_Orders
FROM hotel_reservation_dataset
GROUP BY
    type_of_meal_plan;

-- 3.What is the avarage price per room for reservation
-- involving children
SELECT ROUND (AVG(avg_price_per_room), 2) AS avg_price_per_room
FROM hotel_reservation_dataset WHERE no_of_children > 0

-- 4.how many reservations were made for the year 20xx ( replace xx  with desired year )
SELECT COUNT(*) AS reservations_for_2018
FROM hotel_reservation_dataset
WHERE YEAR(STR_TO_DATE(arrival_date, '%d-%m-%Y')) = 2018;

-- 5.What is the most commonly booked room type ?
SELECT
    room_type_reserved,
    COUNT(room_type_reserved) AS NumberOfReservations
FROM hotel_reservation_dataset
GROUP BY room_type_reserved
ORDER BY COUNT(room_type_reserved) DESC;

-- 6.How many reservations fall on a weekend  (no_of_weekend_nights > 0)?
SELECT COUNT(*) AS weekend_reservations
FROM hotel_reservation_dataset
WHERE no_of_weekend_nights > 0;

-- 7.What is the highest and lowest lead time for reservations?
SELECT MAX(lead_time) AS highest_lead_time, MIN(lead_time) AS lowest_lead_time
FROM hotel_reservation_dataset;

-- 8.What is the most common market segment type for reservations?
SELECT market_segment_type, COUNT(*) AS segment_count
FROM hotel_reservation_dataset
GROUP BY market_segment_type
ORDER BY segment_count DESC
LIMIT 1;

-- 9.How many reservations have a booking status of "Confirmed"?
SELECT
COUNT(*) AS confirmed_reservations
FROM hotel_reservation_dataset
WHERE booking_status = 'Confirmed';

# if we consider "Not Cancelled" as "Confirmed"
SELECT
COUNT(*) AS confirmed_reservations
FROM hotel_reservation_dataset
WHERE booking_status = 'Not_Canceled';

-- 10. What is the total number of adults and children across all reservations?
SELECT
    SUM(no_of_children) AS total_children,
    SUM(no_of_adults) AS total_adults
FROM hotel_reservation_dataset;

-- 11. What is the average number of weekend nughts for reservations
-- Involving children
SELECT
    ROUND(AVG(no_of_weekend_nights), 2) AS no_of_weekend_nights
FROM hotel_reservation_dataset

-- 12.How many reservations were made in each month of the year?
# with both month number & month name:
SELECT 
  subquery.MONTH_NUMBER,
  subquery.MONTH_NAME,
  COUNT(*) AS reservations_count
FROM (
  SELECT
    MONTH(STR_TO_DATE(arrival_date, '%d-%m-%Y')) AS MONTH_NUMBER, 
    MONTHNAME(STR_TO_DATE(arrival_date, '%d-%m-%Y')) AS MONTH_NAME
  FROM hotel_reservation_dataset
) AS subquery
GROUP BY subquery.MONTH_NUMBER, subquery.MONTH_NAME
ORDER BY subquery.MONTH_NUMBER;

-- 13. What is the average number of nights
-- (both weekend and weekday) spent by guests for each room type?
SELECT
room_type_reserved, ROUND (AVG(no_of_weekend_nights + no_of_week_nights),2)
AS avg_total_nights
FROM hotel_reservation_dataset
WHERE
booking_status = 'Not_Canceled'
GROUP BY room_type_reserved;

-- 14. For reservations involving children,
-- what is the most common room type, and what is the average price for that room type?
SELECT room_type_reserved,
       COUNT(*) AS 'NumberOfReservations',
       ROUND(AVG(avg_price_per_room), 2) AS 'avg_price'
FROM hotel_reservation_dataset
WHERE no_of_children > 0
GROUP BY room_type_reserved;

-- 15. Find the market segment type that generates the highest average price per room.
SELECT market_segment_type,
ROUND(AVG(avg_price_per_room)) AS "AVG_PRICE"
FROM hotel_reservation_dataset
GROUP BY market_segment_type
ORDER BY "AVG_PRICE" DESC;