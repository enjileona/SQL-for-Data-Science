-- SELECT & FROM

SELECT * FROM Shinkansen_stations; -- menampilkan semua data

SELECT Station_Name from Shinkansen_stations; -- hanya menampilkan Station_Name

-- WHERE
SELECT * FROM Shinkansen_stations
where Distance_from_Tokyo_st = 293.6;

SELECT * FROM Shinkansen_stations
WHERE Station_Name = 'Atami';

-- AND, OR, NOT
SELECT *
FROM Shinkansen_stations 
WHERE Year = '2003'
AND Prefecture = 'Tokyo'; -- AND

SELECT *
FROM Shinkansen_stations
WHERE Prefecture = 'Tokyo'
OR Prefecture = 'Aichi'; -- OR

SELECT *
FROM Shinkansen_stations
WHERE NOT Year = '1964';

-- LIKE
SELECT * 
FROM Shinkansen_stations
WHERE Prefecture like 't%'; -- awalan huruf t

SELECT * 
FROM Shinkansen_stations
WHERE Company like '%izu%'; -- huruf terdapat izu

-- ALIAS
SELECT Prefecture as Wilayah
from Shinkansen_stations;

SELECT 
Station_Name as nama_stasiun,
Year as Tahun, 
Distance_from_Tokyo_st as jarak_dari_tokyo
FROM Shinkansen_stations;

-- DELETE
DELETE FROM Shinkansen_stations
WHERE Station_Name='Station_Name';

-- ORDER BY
SELECT * FROM Shinkansen_stations
ORDER BY Station_Name ASC;

-- LIMIT
SELECT * FROM Shinkansen_stations
LIMIT 5;

-- OFFSET
SELECT * from Shinkansen_stations
LIMIT 5
OFFSET 1;
