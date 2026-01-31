WITH Monthly_Cases AS (
    SELECT 
        Location,
        SUM(CASE WHEN DATE = '2021-04-01' THEN New_Cases ELSE 0 END) AS `Cases_April_2021`,
        SUM(CASE WHEN DATE = '2021-03-01' THEN New_Cases ELSE 0 END) AS `Cases_March_2021`,
        SUM(CASE WHEN DATE = '2021-04-01' THEN New_Deaths ELSE 0 END) AS `Deaths_April_2021`,
        SUM(CASE WHEN DATE = '2021-03-01' THEN New_Deaths ELSE 0 END) AS `Deaths_March_202`1
    FROM 
        `my-project-1566368200412.temporary_data_bank_record.covid-19`
    WHERE 
        EXTRACT(YEAR FROM DATE) = 2021
    GROUP BY 
        Location
)
SELECT 
    Location,
    `Cases_April_2021`,
    `Cases_March_2021`,
    `Deaths_April_2021`,
    `Deaths_March_2021`,
    (`Cases_April_2021` - `Cases_March_2021`) AS `Cases_Growth`,
    (`Deaths_April_2021` - `Deaths_March_2021)` AS `Deaths_Growth`
FROM 
    `Monthly_Cases`;
