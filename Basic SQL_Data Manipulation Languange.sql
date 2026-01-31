/* Data Manipulation Language
Sub-perintah pada SQL yang berguna dalam manipulasi basis data, seperti:
- SELECT
- WHERE
- INSERT
- DELETE
- UPDATE
 */

SELECT*FROM data_penumpang; --Menampilkan seluruh data_penumpang

SELECT * FROM data_penumpang
		 WHERE arrival = 'Bali';  --Menampilkan data dengan arrival = Bali
		 
SELECT nama_belakang, nama_depan
		FROM data_penumpang;
		
--- Menambahkan data baru	
INSERT INTO data_penumpang 
(nama_depan, nama_belakang,umur,riwayat_penyakit,departure,arrival)
VALUES
('Euanggay','Leona',23,'Maag','Jakarta','Makassar');

SELECT*FROM data_penumpang;

--- DELETE digunakan untuk menghapus baris tertentu dalam tabel, tergantung pada kondisi yang ditentukan melalui WHERE.
DELETE FROM data_penumpang
WHERE
nama_depan = 'Euanggay';

--- UPDATE mengubah nilai yang sudah ada dalam tabel tanpa menghapus baris tersebut
UPDATE data_penumpang
SET nama_depan = 'Andi'
WHERE nama_depan = 'Banu';
