-- Data Cleaning

select* from world_layoffs.layoffs;

-- 1. Menghilangkan duplikasi
-- 2. menyelaraskan format data
-- 3. Mengupdate kolom

-- 1. Menghilangkan duplikasi
#Membuat tabel baru
create table layoffs_staging 
like world_layoffs.layoffs;
 
select* 
from layoffs_staging;
 
#Memasukkan data dari tabel sebelumnya ke tabel baru  yaitu layoffs_staging
insert layoffs_staging
select *
from world_layoffs.layoffs;

#memberikan nomor untuk menandai setiap grup yang dibagi berdasarkan kolom
select*,
row_number() over(
partition by company, industry, total_laid_off, percentage_laid_off, 'date') as row_num
from layoffs_staging;

with duplicate_cte as
(
select*,
row_number() over(
partition by company, location,
industry, total_laid_off, percentage_laid_off, 'date', stage,
country, funds_raised_millions) as row_num
from layoffs_staging
)
select *
from duplicate_cte
where row_num > 1;

#Membuat tabel baru yaitu layoffs_staging2
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select* 
from layoffs_staging2
where row_num > 1;

#Memasukkan data dari tabel sebelumnya ke tabel yang baru
insert into layoffs_staging2
select*,
row_number() over(
partition by company, location,
industry, total_laid_off, percentage_laid_off, 'date', stage,
country, funds_raised_millions) as row_num
from layoffs_staging;

#Menghapus data duplikat yang ditandai dengan row number lebih dari 1
delete
from layoffs_staging2
where row_num > 1;

select* 
from layoffs_staging2;

-- 2. menyelaraskan format data

#menampilkan daftar perusahaan dan menghapus spasi tidak perlu
select distinct(trim(company))
from layoffs_staging2;

#mengupdate tabel
update layoffs_staging2
set company = trim(company);

select *
from layoffs_staging2
where industry like 'Crypto%';

update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';

#menghapus titik yang ada di akhir nama negara
select distinct country, trim(trailing '.' from country)
from layoffs_staging2
order by 1;

update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'United States%';

select distinct country, trim(trailing '.' from country)
from layoffs_staging2
order by 1;

#Mengganti format tanggal
select `date`
from layoffs_staging2;

update layoffs_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y');

alter table layoffs_staging2
modify column `date` date;

-- 3. Mengupdate kolom

select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

#Menghupdate kolom industry yang kosong dan mengisi dengan null
update layoffs_staging2
set industry = null
where industry = '';

select *
from layoffs_staging2
where industry is null
or industry = '';

select *
from layoffs_staging2
where company like 'Bally%';

# melengkapi data kosong pada kolom industry dari data baris lain pada perusahaan yang sama
select t1.industry, t2.industry
from layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company=t2.company
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;

update layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company=t2.company
set t1.industry=t2.industry
where t1.industry is null
and t2.industry is not null;

select *
from layoffs_staging2;
