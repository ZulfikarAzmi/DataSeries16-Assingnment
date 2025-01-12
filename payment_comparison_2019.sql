-- Query untuk menganalisis rata-rata tarif, tips, dan tol berdasarkan jenis pembayaran pada tahun 2019
SELECT 
  payment_type, 
  AVG(fare) AS average_fare,  -- Menghitung rata-rata tarif
  AVG(tips) AS average_tips,  -- Menghitung rata-rata tips
  AVG(tolls) AS average_tolls  -- Menghitung rata-rata tol
FROM 
  `bigquery-public-data.chicago_taxi_trips.taxi_trips`
WHERE 
  EXTRACT(YEAR FROM trip_start_timestamp) = 2019  -- Menyaring data untuk tahun 2019
GROUP BY 
  payment_type  -- Mengelompokkan data berdasarkan jenis pembayaran
ORDER BY 
  average_fare DESC;  -- Mengurutkan hasil berdasarkan rata-rata tarif terbanyak
