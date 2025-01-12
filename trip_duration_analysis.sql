-- Query untuk menganalisis durasi perjalanan (dalam detik) berdasarkan hari tertentu (Senin dan Sabtu)

SELECT 
  -- Menggunakan CASE untuk menampilkan nama hari berdasarkan nilai EXTRACT(DAYOFWEEK)
  CASE 
    WHEN EXTRACT(DAYOFWEEK FROM trip_start_timestamp) = 2 THEN 'Monday'  -- Jika hari adalah Senin (2)
    WHEN EXTRACT(DAYOFWEEK FROM trip_start_timestamp) = 7 THEN 'Saturday'  -- Jika hari adalah Sabtu (7)
  END AS day_of_week,  -- Menggunakan alias 'day_of_week' untuk menampilkan nama hari

  AVG(trip_seconds) AS avg_trip_seconds,  -- Menghitung rata-rata durasi perjalanan dalam detik

  -- Menggunakan APPROX_QUANTILES untuk menghitung kuantil (median) dari durasi perjalanan
  APPROX_QUANTILES(trip_seconds, 2)[OFFSET(1)] AS median_trip_seconds,  -- Menampilkan median durasi perjalanan

  STDDEV(trip_seconds) AS stddev_trip_seconds  -- Menghitung standar deviasi durasi perjalanan
FROM 
  `bigquery-public-data.chicago_taxi_trips.taxi_trips`  -- Sumber data dari tabel taxi_trips

WHERE 
  -- Menyaring data hanya untuk hari Senin (2) dan Sabtu (7) menggunakan EXTRACT(DAYOFWEEK)
  EXTRACT(DAYOFWEEK FROM trip_start_timestamp) IN (2, 7)

GROUP BY 
  day_of_week  -- Mengelompokkan hasil berdasarkan hari dalam seminggu (Senin dan Sabtu)

ORDER BY 
  -- Mengurutkan hasil berdasarkan hari: Senin pertama, Sabtu kedua
  CASE
    WHEN day_of_week = 'Monday' THEN 1  -- Menempatkan Senin di urutan pertama
    WHEN day_of_week = 'Saturday' THEN 2  -- Menempatkan Sabtu di urutan kedua
  END;
