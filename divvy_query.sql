--Divvy project combinding tables from 04/01/2019-03/31/2020




--I combined and create new table with the query with the SELECT INTO function.




SELECT *
INTO PortfolioProject..divvy_q2
FROM PortfolioProject..divvy_q2a
UNION ALL
SELECT *
FROM PortfolioProject..divvy_q2b;





--I dropped ride_length column from divvy_q3 table





ALTER TABLE PortfolioProject..divvy_q3 DROP COLUMN ride_length;

--I then combined the third quarter with the second quarter to create a new table with a UNION ALL Operator and the SELECT INTO function.




SELECT *
INTO PortfolioProject..divvy_q23
FROM PortfolioProject..divvy_q2
UNION ALL
SELECT *
FROM PortfolioProject..divvy_q3;




--I then combined the third quarter with the fourth quarter to create a new table with the SELECT INTO function.





SELECT *
INTO PortfolioProject..divvy_q34
FROM PortfolioProject..divvy_q23
UNION ALL
SELECT *
FROM PortfolioProject..divvy_q4
ORDER BY start_time;
SELECT *
FROM PortfolioProject..divvy_q34;



--Droped trip_id, gender and birthyear columns from divvy_q34



ALTER TABLE PortfolioProject..divvy_q34 DROP COLUMN trip_id, gender, birthyear;



--Droped ride_id, rideable_type, start_lat, start_lng, end_lat, end_lng columns from divvy_q34




ALTER TABLE PortfolioProject..divvy_q1 DROP COLUMN ride_id, rideable_type, start_lat, start_lng, end_lat, end_lng;

-- Drop columns bikeid, tripduration from divvy_q34 because they are not in table divvy_q1 table.

ALTER TABLE PortfolioProject..divvy_q34 DROP COLUMN bikeid, tripduration;

-- I will combine divvy_q1 and divvy_34 into one table with the SELECT INTO function.



SELECT *
INTO PortfolioProject..divvy_q134
FROM PortfolioProject..divvy_q34
UNION ALL
SELECT *
FROM PortfolioProject..divvy_q1;



-- To better organize the data, I arrange the start time of each trip in ascending order.




SELECT *
FROM PortfolioProject..divvy_q134
ORDER BY start_time;




--I LEFT JOIN The tables divvy_bike _dep and divvy_bike_to, then created table divvvy_1234 with the SELECT INTO function.





SELECT d.dep_station_id, 
       d.dep_station_name, 
       d.dep_latitude, 
       d.dep_longitude, 
       t.to_station_id, 
       t.to_station_name, 
       t.to_latitude, 
       t.to_longitude, 
       t.to_location
INTO PortfolioProject..divvy_1234
FROM PortfolioProject..divvy_bike_dep d
     LEFT JOIN PortfolioProject..divvy_bike_to t ON d.dep_station_id = t.dep_station_id;





--Added ride_length_column to table divvy_q134 and created table divvy_1234 with the SELECT INTO function.





SELECT *, 
       DATEDIFF(minute, divvy_q134.start_time, divvy_q134.end_time) AS ride_length_min
INTO PortfolioProject..divvy_q1234
FROM PortfolioProject..divvy_q134;





--Then LEFT JOINED the two tables divvy_q1234 and divvy_1234 and saved it as divvy_master with the SELECT INTO function.





SELECT p.start_time, 
       p.end_time, 
       p.dep_station_id, 
       p.dep_station_name, 
       p.to_station_id, 
       p.to_station_name, 
       p.usertype, 
       p.ride_length_min, 
       s.dep_latitude, 
       s.dep_longitude, 
       s.to_longitude, 
       s.to_latitude
INTO PortfolioProject..divvy_master
FROM PortfolioProject..divvy_q1234 p
     LEFT JOIN PortfolioProject..divvy_1234 s ON p.to_station_id = s.dep_station_id;





 -- I downloaded the final query to a csv file then uploaded to Tableau for visualization.  You can find here:
 -- https://public.tableau.com/app/profile/mark.peterson5019/viz/TheDivvyProject/DeparturesDestinationsComparison#1

