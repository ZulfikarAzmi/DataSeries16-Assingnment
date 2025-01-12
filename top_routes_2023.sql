-- Query untuk menganalisis rute dengan jumlah perjalanan terbanyak pada tahun 2023
SELECT 
  pickup_community_area, 
  dropoff_community_area, 
  COUNT(DISTINCT taxi_id) AS num_trips  -- Menghitung jumlah perjalanan unik
FROM 
  `bigquery-public-data.chicago_taxi_trips.taxi_trips`
WHERE 
  EXTRACT(YEAR FROM trip_start_timestamp) = 2023  -- Menyaring data berdasarkan tahun 2023
  AND pickup_community_area IS NOT NULL  -- Menghindari nilai kosong pada pickup_community_area
  AND dropoff_community_area IS NOT NULL  -- Menghindari nilai kosong pada dropoff_community_area
  AND pickup_community_area <= dropoff_community_area  -- Menghindari redundansi dan perjalanan tidak logis
GROUP BY 
  pickup_community_area, 
  dropoff_community_area
ORDER BY 
  num_trips DESC  -- Mengurutkan hasil berdasarkan jumlah perjalanan terbanyak
LIMIT 5;  -- Menampilkan 5 rute teratas
