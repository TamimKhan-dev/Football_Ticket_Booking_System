-- Query 1
SELECT match_id, fixture, base_ticket_price FROM Matches 
WHERE tournament_category = 'Champions League' AND match_status = 'Available';


-- Query 2
SELECT user_id, full_name, email FROM Users
WHERE full_name ILIKE 'Tanvir%' OR full_name ILIKE '%Haque%';


-- Query 3
SELECT booking_id, user_id, match_id, COALESCE(payment_status, 'Action Required') as "systematic_status"
FROM Bookings 
WHERE payment_status IS NULL;


-- Query 4
SELECT booking_id, full_name, fixture, total_cost FROM Bookings b
INNER JOIN Matches m ON b.match_id = m.match_id
INNER JOIN Users u ON b.user_id = u.user_id;


-- Query 5
SELECT user_id, full_name, booking_id FROM Users
LEFT JOIN Bookings USING(user_id);