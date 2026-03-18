-- A)	Data cleaning on speech_features data

-- 1)	Count NULL values for each column
SELECT 
COUNT(*) - COUNT(snr) AS null_snr,
COUNT(*) - COUNT(mfcc_1) AS null_mfcc_1,
COUNT(*) - COUNT(mfcc_2) AS null_mfcc_2,
COUNT(*) - COUNT(mfcc_3) AS null_mfcc_3,
COUNT(*) - COUNT(mfcc_4) AS null_mfcc_4,
COUNT(*) - COUNT(mfcc_5) AS null_mfcc_5,
COUNT(*) - COUNT(mfcc_6) AS null_mfcc_6,
COUNT(*) - COUNT(mfcc_7) AS null_mfcc_7,
COUNT(*) - COUNT(mfcc_8) AS null_mfcc_8,
COUNT(*) - COUNT(mfcc_9) AS null_mfcc_9,
COUNT(*) - COUNT(mfcc_10) AS null_mfcc_10,
COUNT(*) - COUNT(mfcc_11) AS null_mfcc_11,
COUNT(*) - COUNT(mfcc_12) AS null_mfcc_12,
COUNT(*) - COUNT(mfcc_13) AS null_mfcc_13,
COUNT(*) - COUNT(delta_mfcc_1) AS null_delta_mfcc_1,
COUNT(*) - COUNT(delta_mfcc_2) AS null_delta_mfcc_2,
COUNT(*) - COUNT(delta_mfcc_3) AS null_delta_mfcc_3,
COUNT(*) - COUNT(delta_mfcc_4) AS null_delta_mfcc_4,
COUNT(*) - COUNT(delta_mfcc_5) AS null_delta_mfcc_5,
COUNT(*) - COUNT(delta_mfcc_6) AS null_delta_mfcc_6,
COUNT(*) - COUNT(delta_mfcc_7) AS null_delta_mfcc_7,
COUNT(*) - COUNT(delta_mfcc_8) AS null_delta_mfcc_8,
COUNT(*) - COUNT(delta_mfcc_9) AS null_delta_mfcc_9,
COUNT(*) - COUNT(delta_mfcc_10) AS null_delta_mfcc_10,
COUNT(*) - COUNT(delta_mfcc_11) AS null_delta_mfcc_11,
COUNT(*) - COUNT(delta_mfcc_12) AS null_delta_mfcc_12,
COUNT(*) - COUNT(delta_mfcc_13) AS null_delta_mfcc_13,
COUNT(*) - COUNT(zcr) AS null_zcr,
COUNT(*) - COUNT(centroid) AS null_centroid,
COUNT(*) - COUNT(flatness) AS null_flatness,
COUNT(*) - COUNT(ste) AS null_ste
FROM speech_features

-- 2 Check each file has 3 rows
SELECT file, COUNT(*)
FROM speech_features
GROUP BY file
HAVING COUNT(*) > 3

-- 3)	Check feature ranges i.e. calculate min, max values of features. 
SELECT 
MIN(mfcc_1) AS min_mfcc_1,
MAX(mfcc_1) AS max_mfcc_1,
MIN(mfcc_2) AS min_mfcc_2,
MAX(mfcc_2) AS max_mfcc_2,
MIN(mfcc_3) AS min_mfcc_3,
MAX(mfcc_3) AS max_mfcc_3,
MIN(mfcc_4) AS min_mfcc_4,
MAX(mfcc_4) AS max_mfcc_4,
MIN(mfcc_5) AS min_mfcc_5,
MAX(mfcc_5) AS max_mfcc_5,
MIN(mfcc_6) AS min_mfcc_6,
MAX(mfcc_6) AS max_mfcc_6,
MIN(mfcc_7) AS min_mfcc_7,
MAX(mfcc_7) AS max_mfcc_7,
MIN(mfcc_8) AS min_mfcc_8,
MAX(mfcc_8) AS max_mfcc_8,
MIN(mfcc_9) AS min_mfcc_9,
MAX(mfcc_9) AS max_mfcc_9,
MIN(mfcc_10) AS min_mfcc_10,
MAX(mfcc_10) AS max_mfcc_10,
MIN(mfcc_11) AS min_mfcc_11,
MAX(mfcc_11) AS max_mfcc_11,
MIN(mfcc_12) AS min_mfcc_12,
MAX(mfcc_12) AS max_mfcc_12,
MIN(mfcc_13) AS min_mfcc_13,
MAX(mfcc_13) AS max_mfcc_13,
MIN(delta_mfcc_1) AS min_delta_mfcc_1,
MAX(delta_mfcc_1) AS max_delta_mfcc_1,
MIN(delta_mfcc_2) AS min_delta_mfcc_2,
MAX(delta_mfcc_2) AS max_delta_mfcc_2,
MIN(delta_mfcc_3) AS min_delta_mfcc_3,
MAX(delta_mfcc_3) AS max_delta_mfcc_3,
MIN(delta_mfcc_4) AS min_delta_mfcc_4,
MAX(delta_mfcc_4) AS max_delta_mfcc_4,
MIN(delta_mfcc_5) AS min_delta_mfcc_5,
MAX(delta_mfcc_5) AS max_delta_mfcc_5,
MIN(delta_mfcc_6) AS min_delta_mfcc_6,
MAX(delta_mfcc_6) AS max_delta_mfcc_6,
MIN(delta_mfcc_7) AS min_delta_mfcc_7,
MAX(delta_mfcc_7) AS max_delta_mfcc_7,
MIN(delta_mfcc_8) AS min_delta_mfcc_8,
MAX(delta_mfcc_8) AS max_delta_mfcc_8,
MIN(delta_mfcc_9) AS min_delta_mfcc_9,
MAX(delta_mfcc_9) AS max_delta_mfcc_9,
MIN(delta_mfcc_10) AS min_delta_mfcc_10,
MAX(delta_mfcc_10) AS max_delta_mfcc_10,
MIN(delta_mfcc_11) AS min_delta_mfcc_11,
MAX(delta_mfcc_11) AS max_delta_mfcc_11,
MIN(delta_mfcc_12) AS min_delta_mfcc_12,
MAX(delta_mfcc_12) AS max_delta_mfcc_12,
MIN(delta_mfcc_13) AS min_delta_mfcc_13,
MAX(delta_mfcc_13) AS max_delta_mfcc_13,
MIN(zcr) AS min_zcr,
MAX(zcr) AS max_zcr,
MIN(centroid) AS min_centroid,
MAX(centroid) AS max_centroid,
MIN(flatness) AS min_flatness,
MAX(flatness) AS max_flatness,
MIN(ste) AS min_ste,
MAX(ste) AS max_ste
FROM speech_features

-- 4)	Validate dataset size
SELECT 
COUNT(DISTINCT file) AS distinct_no_files,
COUNT(DISTINCT snr) AS distinct_snr,
COUNT(DISTINCT file) * COUNT(DISTINCT snr) AS data_size
FROM speech_features

-- 5)	Detect duplicates – Find duplicates based on all columns
SELECT COUNT(*) AS no_duplicates
FROM speech_features
GROUP BY file, snr
HAVING COUNT(*) > 1

-- 6) Average feature value per snr
SELECT snr, AVG(zcr) AS avg_zcr, 
AVG(flatness) AS avg_flatness, 
AVG(centroid) AS avg_centroid, 
AVG(ste) AS avg_ste
FROM speech_features
GROUP BY snr
ORDER BY snr DESC

--Observation : zcr, flatness, centroid, ste increases as noise increases.

-- 7)	Validate SNR categoris
SELECT COUNT(snr) AS invalid_snr_values
FROM speech_features
WHERE snr NOT IN (5, 10, 20) OR snr IS NULL

-- 8)	Validate feature variance i.e. check if any feature has same value across all rows. Ex. ste always = 0
SELECT 
COUNT(DISTINCT mfcc_1) AS unique_mfcc_1,
COUNT(DISTINCT mfcc_2) AS unique_mfcc_2,
COUNT(DISTINCT mfcc_3) AS unique_mfcc_3,
COUNT(DISTINCT mfcc_4) AS unique_mfcc_4,
COUNT(DISTINCT mfcc_5) AS unique_mfcc_5,
COUNT(DISTINCT mfcc_6) AS unique_mfcc_6,
COUNT(DISTINCT mfcc_7) AS unique_mfcc_7,
COUNT(DISTINCT mfcc_8) AS unique_mfcc_8,
COUNT(DISTINCT mfcc_9) AS unique_mfcc_9,
COUNT(DISTINCT mfcc_10) AS unique_mfcc_10,
COUNT(DISTINCT mfcc_11) AS unique_mfcc_11,
COUNT(DISTINCT mfcc_12) AS unique_mfcc_12,
COUNT(DISTINCT mfcc_13) AS unique_mfcc_13
FROM speech_features

SELECT
COUNT(DISTINCT delta_mfcc_1) AS unique_delta_mfcc_1,
COUNT(DISTINCT delta_mfcc_2) AS unique_delta_mfcc_2,
COUNT(DISTINCT delta_mfcc_3) AS unique_delta_mfcc_3,
COUNT(DISTINCT delta_mfcc_4) AS unique_delta_mfcc_4,
COUNT(DISTINCT delta_mfcc_5) AS unique_delta_mfcc_5,
COUNT(DISTINCT delta_mfcc_6) AS unique_delta_mfcc_6,
COUNT(DISTINCT delta_mfcc_7) AS unique_delta_mfcc_7,
COUNT(DISTINCT delta_mfcc_8) AS unique_delta_mfcc_8,
COUNT(DISTINCT delta_mfcc_9) AS unique_delta_mfcc_9,
COUNT(DISTINCT delta_mfcc_10) AS unique_delta_mfcc_10,
COUNT(DISTINCT delta_mfcc_11) AS unique_delta_mfcc_11,
COUNT(DISTINCT delta_mfcc_12) AS unique_delta_mfcc_12,
COUNT(DISTINCT delta_mfcc_13) AS unique_delta_mfcc_13
FROM speech_features

SELECT
COUNT(DISTINCT zcr) AS unique_zcr,
COUNT( DISTINCT centroid) AS unique_centroid,
COUNT(DISTINCT flatness) AS unique_flatness,
COUNT(DISTINCT ste) AS unique_ste
FROM speech_features

-- 9)	Round/standardize values – Create a cleaned table where all numeric columns are rounded to 2 decimal values.
CREATE TABLE speech_features_rounded AS
SELECT file, snr,
ROUND(mfcc_1::numeric,2) AS mfcc_1,
ROUND(mfcc_2::numeric,2) AS mfcc_2,
ROUND(mfcc_3::numeric,2) AS mfcc_3,
ROUND(mfcc_4::numeric,2) AS mfcc_4,
ROUND(mfcc_5::numeric,2) AS mfcc_5,
ROUND(mfcc_6::numeric,2) AS mfcc_6,
ROUND(mfcc_7::numeric,2) AS mfcc_7,
ROUND(mfcc_8::numeric,2) AS mfcc_8,
ROUND(mfcc_9::numeric,2) AS mfcc_9,
ROUND(mfcc_10::numeric,2) AS mfcc_10,
ROUND(mfcc_11::numeric,2) AS mfcc_11,
ROUND(mfcc_12::numeric,2) AS mfcc_12,
ROUND(mfcc_13::numeric,2) AS mfcc_13,
ROUND(delta_mfcc_1::numeric,2) AS delta_mfcc_1,
ROUND(delta_mfcc_2::numeric,2) AS delta_mfcc_2,
ROUND(delta_mfcc_3::numeric,2) AS delta_mfcc_3,
ROUND(delta_mfcc_4::numeric,2) AS delta_mfcc_4,
ROUND(delta_mfcc_5::numeric,2) AS delta_mfcc_5,
ROUND(delta_mfcc_6::numeric,2) AS delta_mfcc_6,
ROUND(delta_mfcc_7::numeric,2) AS delta_mfcc_7,
ROUND(delta_mfcc_8::numeric,2) AS delta_mfcc_8,
ROUND(delta_mfcc_9::numeric,2) AS delta_mfcc_9,
ROUND(delta_mfcc_10::numeric,2) AS delta_mfcc_10,
ROUND(delta_mfcc_11::numeric,2) AS delta_mfcc_11,
ROUND(delta_mfcc_12::numeric,2) AS delta_mfcc_12,
ROUND(delta_mfcc_13::numeric,2) AS delta_mfcc_13,
ROUND(zcr::numeric,2) AS zcr,
ROUND(centroid::numeric,2) AS centroid,
ROUND(flatness::numeric,2) AS flatness,
ROUND(ste::numeric,2) AS ste
FROM speech_features

SELECT * FROM speech_features_rounded

-- 10)	Create channel_quality column
CREATE TABLE speech_features_clean AS
SELECT *,
CASE 
	WHEN snr = 20 THEN 'good'
	WHEN snr = 10 THEN 'medium'
	WHEN snr = 5 THEN 'poor'
END AS channel_quality
FROM speech_features

-- 11) Primary key validation: check (file, snr) is unique.
SELECT COUNT(*)
FROM speech_features_clean
GROUP BY file, snr
HAVING COUNT(*) > 1

-- 12) Add primary key constraint
ALTER TABLE speech_features_clean
ADD CONSTRAINT pk_file_snr PRIMARY KEY (file, snr)

SELECT * FROM speech_features_clean