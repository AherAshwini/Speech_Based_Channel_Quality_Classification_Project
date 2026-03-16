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

-- SELECT * FROM speech_features

-- 2)	Validate dataset size
-- 3)	Primary key validation (file+snr)
-- 4)	Detect duplicates – Find duplicates based on all columns
-- 5)	Validate SNR categoris
-- 6)	Create channel_quality column
-- 7)	Round/standardize values – Create a cleaned table where all numeric columns are rounded to 2 decimal values.
-- 8)	Check feature ranges i.e. calculate min, max values of features
-- 9)	Validate feature variance i.e. check if any feature has same value across all rows. Ex. ste always = 0
