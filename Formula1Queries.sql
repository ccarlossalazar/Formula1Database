/* Query focuses on finding the larger upsets in F1 when it comes to starting grid position 
and finishing position (ie podium finish). Specifically focusing on racers who had a starting 
grid position greater than 10 and were still able to achieve a podium finish. */

WITH podium_finishes AS (
SELECT r.raceId, r.year, r.name AS race_name, d.forename, d.surname, res.grid, res.position,
CASE WHEN res.position = 1 THEN 'Winner'
WHEN res.position IN (2, 3) THEN 'Podium'
ELSE NULL
END AS result_category
FROM results res
 JOIN races r ON res.raceId = r.raceId
 JOIN drivers d ON res.driverId = d.driverId
 JOIN constructors c ON res.constructorId = c.constructorId
  WHERE res.position <= 3 
),

performance_analysis AS (
SELECT pf.raceId, pf.year, pf.race_name, pf.forename, pf.surname, pf.constructor_name, pf.grid, pf.position, pf.result_category, 
(pf.grid - pf.position) AS position_gain
FROM podium_finishes pf
 WHERE pf.grid > 10 
)

SELECT year, race_name, forename, surname,  constructor_name, grid AS starting_position, position AS finishing_position, 
result_category, position_gain
FROM performance_analysis
ORDER BY position_gain DESC, year ASC;

/*This query analyzes the performance of individual drivers and the contribution they 
had to their constructors' success. This overall allows us to see the impact a drivers
overall performance had on their teams */

SELECT 
    d.driverId,
    d.driverRef AS driver_name,
    c.constructorId,
    c.name AS constructor_name,
    SUM(r.points) AS total_driver_points,
    COUNT(CASE WHEN r.position = 1 THEN 1 END) AS total_driver_wins,
    COUNT(CASE WHEN r.position <= 3 THEN 1 END) AS total_driver_podiums,
    cs.points AS total_constructor_points,
    ROUND((SUM(r.points) * 1.0 / NULLIF(cs.points, 0)) * 100, 2) AS driver_contribution_percentage
FROM results r
JOIN drivers d ON r.driverId = d.driverId
JOIN constructors c ON r.constructorId = c.constructorId
JOIN constructor_standings cs ON c.constructorId = cs.constructorId
WHERE cs.points > 0 -- Include only constructors that earned points
GROUP BY d.driverId, d.driverRef, c.constructorId, c.name, cs.points
ORDER BY total_driver_points DESC, driver_contribution_percentage DESC;




