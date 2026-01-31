/*
Constraints digunakan untuk menetapkan aturan terhadap data dalam tabel, 
seperti memastikan data tidak boleh kosong, harus unik, atau sebagai pengenal utama (primary key).
- NOT NULL
- UNIQUE
- PRIMARY KEY : secara otomatis menggabungkan dua aturan penting: 
tidak boleh kosong (seperti NOT NULL) dan tidak boleh ada duplikat (seperti UNIQUE).
- INDEX
*/

CREATE TABLE info_bus (
kode_bus char (6) NOTNULL,
nama_sopir char (10) NOTNULL,
terakhir_dilihat char (6) NOTNULL,
warna_bus char (6) NOTNULL,
aktivitas_bus char (6) NOTNULL
);

CREATE TABLE info_bus (
kode_bus char (6) UNIQUE,
nama_sopir char (10) NOTNULL,
terakhir_dilihat char (6) NOTNULL,
warna_bus char (6) NOTNULL,
aktivitas_bus char (6) NOTNULL,
PRIMARY KEY (kode_bus)
);

CREATE TABLE info_bus (
kode_bus char (6) UNIQUE PRIMARY KEY,
nama_sopir char (10) NOTNULL PRIMARY KEY,
terakhir_dilihat char (6) NOTNULL,
warna_bus char (6) NOTNULL,
aktivitas_bus char (6) NOTNULL,
PRIMARY KEY (kode_bus)
);

CREATE INDEX info_bus_terakhir_dilihat_idx
ON info_bus (terakhir_dilihat);


