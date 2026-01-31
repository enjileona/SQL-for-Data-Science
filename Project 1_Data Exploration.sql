-- Data Exploration

-- 1. Membuka keseluruhan data
SELECT * 
FROM world_layoffs.layoffs_staging2;

-- Menggunakan Command WHERE
-- 2. PHK dengan jumlah terbesar
SELECT MAX(total_laid_off)
FROM world_layoffs.layoffs_staging2;

-- 3. Melihat persentase PHK terbesar dan terkecil
SELECT MAX(percentage_laid_off),  MIN(percentage_laid_off)
FROM world_layoffs.layoffs_staging2
WHERE  percentage_laid_off IS NOT NULL;
-- PHK Terbesar adalah 1, artinya terdapat perusahaan yang 100% karyawan di PHK

-- 4. Melihat data dengan persentasi PHK 1 atau 100%
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE  percentage_laid_off = 1;
-- Sebagian besar adalah perusahaan startup

-- 5. melihat perusahaan dengan pendapatan yang telah berhasil dikumpulkan
-- menggunkan order by  
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE  percentage_laid_off = 1
ORDER BY funds_raised_millions DESC; #mengurutkan dari terbesar

-- Command GROUP BY
-- 6. perusahaan yang melakukan PHK terbesar dalam satu waktu
SELECT company, total_laid_off
FROM world_layoffs.layoffs_staging
ORDER BY 2 DESC #Mengurutkan kolom kedua (total_laid_ofF)
LIMIT 5; #menampilkan 5 perusahaan teratas

-- 7. Menampilkan total PHK terbesar perusahaan
SELECT company, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY company
ORDER BY 2 DESC #Mengurutkan kolom kedua (total_laid_ofF)
LIMIT 10; #menampilkan 10 perusahaan teratas

-- 8. Menampilkan total PHK terbesar berdasarkan lokasi perusahaan
SELECT location, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY location
ORDER BY 2 DESC
LIMIT 10;

-- 9. Menampilkan total PHK terbesar berdasarkan Negara
SELECT country, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

-- 10. Menampilkan total PHK terbesar berdasarkan Tahun
SELECT YEAR(date), SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY YEAR(date)
ORDER BY 1 DESC;

-- 11. Menampilkan total PHK terbesar berdasarkan Kategori Industri
SELECT industry, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

-- 12. Menampilkan total PHK terbesar berdasarkan stage
SELECT stage, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

-- Command Gabungan
-- 13. Menampilkan PHK perusahan berdasarkan tahun, dan menandai dengan ranking (1 = Terbesar dalam tahun tersebut, dst)
WITH Company_Year AS 
(
  SELECT company, YEAR(date) AS years, SUM(total_laid_off) AS total_laid_off
  FROM world_layoffs.layoffs_staging2
  GROUP BY company, YEAR(date)
)
, Company_Year_Rank AS (
  SELECT company, years, total_laid_off, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
  FROM Company_Year
)
SELECT company, years, total_laid_off, ranking
FROM Company_Year_Rank
WHERE ranking <= 3
AND years IS NOT NULL
ORDER BY years ASC, total_laid_off DESC;

-- 14. Menampilkan total PHK tiap bulan
SELECT SUBSTRING(date,1,7) as dates, SUM(total_laid_off) AS total_laid_off
FROM world_layoffs.layoffs_staging2
GROUP BY dates
ORDER BY dates ASC; #Menampilkan dari tahun 2020
