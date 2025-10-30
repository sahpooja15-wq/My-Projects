-- Assignment 1

# 1)	List the battle details where the number of enemies fought was 1, or 2, or 10, or 12.
SELECT * FROM hero_battles WHERE num_enemies IN(1,2,10,12);

# 2)	What is the total no. of enemies and average number of enemies for each super hero? Also analyse which super hero have highest no of average enemies.
SELECT name, sum(num_enemies) as total_enemies, avg(num_enemies) as avg_enemies FROM hero_battles GROUP BY name order by avg_enemies DESC;

# 3)	Creates a Report for each battle that says, “This battle occurred at 14 o’clock. ” but replace 14 with the hour of that each particular battle.
SELECT name, outcome, station_number, CONCAT_ws(' ','This battle occured at',Hour(date),'o''clock') as Battle_report FROM hero_battles;

# 4)	Select all the hero races with an average weight of over 150 and an average height of over 100.
SELECT race, avg(weight) as avg_weight, avg(height) as avg_height FROM heroes_information GROUP BY race HAVING avg_weight > 150 AND avg_height > 100;


-- Assignment 2

# 5)	List all female heroes_information and stack that name on top of all the heroes who have accelerated healing from the super_hero_powers table. Return only the name columns.
SELECT name FROM heroes_information WHERE Gender = 'Female' UNION SELECT hero_names FROM super_hero_powers WHERE `Accelerated Healing` = "True";

# 6)	For each hero who fought in hero_battles along with battle details, list their information (from heroes_information).
SELECT * FROM hero_battles hb LEFT JOIN heroes_information hi ON hb.name = hi.name;   

# 7)	Provide a list of the heaviest super heroes, with the heaviest being ranked #1.
SELECT name, weight, RANK()OVER(ORDER BY weight desc) as heaviest_weight FROM heroes_information; 

# 8)	Give a frequency table with each letter of the alphabet and how many superheroes’ names start with that letter.
SELECT LEFT(name, 1) AS first_alpha, count(*) as frequency FROM heroes_information WHERE name REGEXP '^[A-Z]' GROUP BY first_alpha ORDER BY first_alpha;


-- Assignment 3

# 9)	Create a temporary table for the below result called bigs
CREATE TEMPORARY TABLE bigs (SELECT * FROM heroes_information WHERE RACE IN (SELECT race FROM heroes_information GROUP BY race having avg(weight) > 400));
-- a)	Display heroes_information whose Race has an average weight of over 400.
SELECT * FROM heroes_information WHERE RACE IN (SELECT race FROM heroes_information GROUP BY race having avg(weight) > 400);
-- b)	Select all columns and rows from that temporary table.
SELECT * FROM bigs;
 
# 10)	 Creates a view to selects data if the publisher is Marvel Comics and if their height is above the average height.
-- Bring that view up.
CREATE VIEW view_marvelcomic AS SELECT * FROM heroes_information WHERE Publisher = 'Marvel comics' AND Height > (SELECT avg(Height) FROM heroes_information);
SELECT * FROM view_marvelcomic;

# 11)	 Find any useful information on you own (Use joins, aggregation and other clauses as required).
-- List all the heroes name and gender where number of enemies they fought should be more than 10 as per the outcome 'won'.  
SELECT hi.name, outcome, count(num_enemies) as num, Gender
FROM hero_battles hb JOIN heroes_information hi ON hb.name = hi.name
WHERE outcome = 'Won'
GROUP BY hi.name, Gender
HAVING num > 10
ORDER BY num DESC;

-- Thanks --


