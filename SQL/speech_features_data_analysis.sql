-- B)	Data Analysis on speech features data.

SELECT * FROM speech_features_clean

-- 1)	Distribution of Channel quality i.e. check how many samples exist for each class ex.
SELECT channel_quality, COUNT(*) 
FROM speech_features_clean
GROUP BY channel_quality

-- 2)	Feature mean per channel quality i.e. calculate average feature values per channel quality. Ex. average mfcc_1 for good
-- Average mfcc_1 for medium
-- Average mfcc_1 for poor
SELECT channel_quality, 
AVG(mfcc_1) AS avg_mfcc_1,
AVG(mfcc_2) AS avg_mfcc_2,
AVG(mfcc_3) AS avg_mfcc_3,
AVG(mfcc_4) AS avg_mfcc_4,
AVG(mfcc_5) AS avg_mfcc_5,
AVG(mfcc_6) AS avg_mfcc_6,
AVG(mfcc_7) AS avg_mfcc_7,
AVG(mfcc_8) AS avg_mfcc_8,
AVG(mfcc_9) AS avg_mfcc_9,
AVG(mfcc_10) AS avg_mfcc_10,
AVG(mfcc_11) AS avg_mfcc_11,
AVG(mfcc_12) AS avg_mfcc_12,
AVG(mfcc_13) AS avg_mfcc_13,
AVG(delta_mfcc_1) AS avg_delta_mfcc_1,
AVG(delta_mfcc_2) AS avg_delta_mfcc_2,
AVG(delta_mfcc_3) AS avg_delta_mfcc_3,
AVG(delta_mfcc_4) AS avg_delta_mfcc_4,
AVG(delta_mfcc_5) AS avg_delta_mfcc_5,
AVG(delta_mfcc_6) AS avg_delta_mfcc_6,
AVG(delta_mfcc_7) AS avg_delta_mfcc_7,
AVG(delta_mfcc_8) AS avg_delta_mfcc_8,
AVG(delta_mfcc_9) AS avg_delta_mfcc_9,
AVG(delta_mfcc_10) AS avg_delta_mfcc_10,
AVG(delta_mfcc_11) AS avg_delta_mfcc_11,
AVG(delta_mfcc_12) AS avg_delta_mfcc_12,
AVG(delta_mfcc_13) AS avg_delta_mfcc_13,
AVG(zcr) AS zcr,
AVG(centroid) AS avg_centroid,
AVG(flatness) AS avg_flatness,
AVG(ste) AS avg_ste
FROM speech_features_clean
GROUP BY channel_quality
ORDER BY channel_quality 

-- This tells whether features change as noise increases

-- 3)	Feature standard deviation i.e. compute standard deviation of features per channel quality. Purpose – measure feature variability. If variance increase at low SNR – noise affecting signal
SELECT snr, channel_quality,
STDDEV(mfcc_1) AS std_mfcc_1, STDDEV(mfcc_2) AS std_mfcc_2, 
STDDEV(mfcc_3) AS std_mfcc_3, STDDEV(mfcc_4) AS std_mfcc_4,
STDDEV(mfcc_5) AS std_mfcc_5, STDDEV(mfcc_6) AS std_mfcc_6,
STDDEV(mfcc_7) AS std_mfcc_7, STDDEV(mfcc_8) AS std_mfcc_8,
STDDEV(mfcc_9) AS std_mfcc_9, STDDEV(mfcc_10) AS std_mfcc10,
STDDEV(mfcc_11) AS std_mfcc_11, STDDEV(mfcc_12) AS std_mfcc_12,
STDDEV(mfcc_13) AS std_mfcc_13, STDDEV(delta_mfcc_1) AS std_delta_mfcc_1,
STDDEV(delta_mfcc_2) AS std_delta_mfcc_2, STDDEV(delta_mfcc_3) AS std_delta_mfcc_3,
STDDEV(delta_mfcc_4) AS std_delta_mfcc_4, STDDEV(delta_mfcc_5) AS std_delta_mfcc_5,
STDDEV(delta_mfcc_6) AS std_delta_mfcc_6, STDDEV(delta_mfcc_7) AS std_delta_mfcc_7,
STDDEV(delta_mfcc_8) AS std_delta_mfcc_8, STDDEV(delta_mfcc_9) AS std_delta_mfcc_9,
STDDEV(delta_mfcc_10) AS std_delta_mfcc_10, STDDEV(delta_mfcc_11) AS std_delta_mfcc_11,
STDDEV(delta_mfcc_12) AS std_delta_mfcc_12, STDDEV(delta_mfcc_13) AS std_delta_mfcc_13,
STDDEV(zcr) AS std_zcr, STDDEV(centroid) AS std_centroid, 
STDDEV(flatness) AS std_flatness, STDDEV(ste) AS std_ste
FROM speech_features_clean
GROUP BY snr, channel_quality
ORDER BY snr DESC


-- 4)	Compare feature drift across SNR. For some features like spectral flatness, zcr, you may observe that values increase as noise increases. 
SELECT snr, AVG(zcr) AS avg_zcr, 
AVG(flatness) AS avg_flatness, 
AVG(centroid) AS avg_centroid, 
AVG(ste) AS avg_ste
FROM speech_features_clean
GROUP BY snr
ORDER BY snr DESC

-- 5)	Identify most sensitive features i.e. check which feature change the most between good vs poor channel.
SELECT 
ABS(AVG(CASE WHEN channel_quality = 'good' THEN zcr END)-AVG(CASE WHEN channel_quality = 'poor' THEN zcr END)) AS zcr_sensitivity,
ABS(AVG(CASE WHEN channel_quality = 'good' THEN mfcc_1 END)-AVG(CASE WHEN channel_quality = 'poor' THEN mfcc_1 END)) AS mfcc_1_sensitivity,
ABS(AVG(CASE WHEN channel_quality = 'good' THEN mfcc_2 END)-AVG(CASE WHEN channel_quality = 'poor' THEN mfcc_2 END)) AS mfcc_2_sensitivity,
ABS(AVG(CASE WHEN channel_quality = 'good' THEN mfcc_3 END)-AVG(CASE WHEN channel_quality = 'poor' THEN mfcc_3 END)) AS mfcc_3_sensitivity,
ABS(AVG(CASE WHEN channel_quality = 'good' THEN mfcc_4 END)-AVG(CASE WHEN channel_quality = 'poor' THEN mfcc_4 END)) AS mfcc_4_sensitivity,
ABS(AVG(CASE WHEN channel_quality = 'good' THEN mfcc_5 END)-AVG(CASE WHEN channel_quality = 'poor' THEN mfcc_5 END)) AS mfcc_5_sensitivity,
ABS(AVG(CASE WHEN channel_quality = 'good' THEN mfcc_6 END)-AVG(CASE WHEN channel_quality = 'poor' THEN mfcc_6 END)) AS mfcc_6_sensitivity,
ABS(AVG(CASE WHEN channel_quality = 'good' THEN mfcc_7 END)-AVG(CASE WHEN channel_quality = 'poor' THEN mfcc_7 END)) AS mfcc_7_sensitivity,
ABS(AVG(CASE WHEN channel_quality = 'good' THEN mfcc_8 END)-AVG(CASE WHEN channel_quality = 'poor' THEN mfcc_8 END)) AS mfcc_8_sensitivity,
ABS(AVG(CASE WHEN channel_quality = 'good' THEN mfcc_9 END)-AVG(CASE WHEN channel_quality = 'poor' THEN mfcc_9 END)) AS mfcc_9_sensitivity,
ABS(AVG(CASE WHEN channel_quality = 'good' THEN mfcc_10 END)-AVG(CASE WHEN channel_quality = 'poor' THEN mfcc_10 END)) AS mfcc_10_sensitivity,
ABS(AVG(CASE WHEN channel_quality = 'good' THEN mfcc_11 END)-AVG(CASE WHEN channel_quality = 'poor' THEN mfcc_11 END)) AS mfcc_11_sensitivity,
ABS(AVG(CASE WHEN channel_quality = 'good' THEN mfcc_12 END)-AVG(CASE WHEN channel_quality = 'poor' THEN mfcc_12 END)) AS mfcc_12_sensitivity,
ABS(AVG(CASE WHEN channel_quality = 'good' THEN mfcc_13 END)-AVG(CASE WHEN channel_quality = 'poor' THEN mfcc_13 END)) AS mfcc_13_sensitivity,
ABS(AVG(CASE WHEN channel_quality = 'good' THEN delta_mfcc_1 END)-AVG(CASE WHEN channel_quality = 'poor' THEN delta_mfcc_1 END)) AS delta_mfcc_1_sensitivity,
ABS(AVG(CASE WHEN channel_quality = 'good' THEN delta_mfcc_2 END)-AVG(CASE WHEN channel_quality = 'poor' THEN delta_mfcc_2 END)) AS delta_mfcc_2_sensitivity,
ABS(AVG(CASE WHEN channel_quality = 'good' THEN delta_mfcc_3 END)-AVG(CASE WHEN channel_quality = 'poor' THEN delta_mfcc_3 END)) AS delta_mfcc_3_sensitivity,
ABS(AVG(CASE WHEN channel_quality = 'good' THEN delta_mfcc_4 END)-AVG(CASE WHEN channel_quality = 'poor' THEN delta_mfcc_4 END)) AS delta_mfcc_4_sensitivity,
ABS(AVG(CASE WHEN channel_quality = 'good' THEN delta_mfcc_5 END)-AVG(CASE WHEN channel_quality = 'poor' THEN delta_mfcc_5 END)) AS delta_mfcc_5_sensitivity,
ABS(AVG(CASE WHEN channel_quality = 'good' THEN delta_mfcc_6 END)-AVG(CASE WHEN channel_quality = 'poor' THEN delta_mfcc_6 END)) AS delta_mfcc_6_sensitivity,
ABS(AVG(CASE WHEN channel_quality = 'good' THEN delta_mfcc_7 END)-AVG(CASE WHEN channel_quality = 'poor' THEN delta_mfcc_7 END)) AS delta_mfcc_7_sensitivity,
ABS(AVG(CASE WHEN channel_quality = 'good' THEN delta_mfcc_8 END)-AVG(CASE WHEN channel_quality = 'poor' THEN delta_mfcc_8 END)) AS delta_mfcc_8_sensitivity,
ABS(AVG(CASE WHEN channel_quality = 'good' THEN delta_mfcc_9 END)-AVG(CASE WHEN channel_quality = 'poor' THEN delta_mfcc_9 END)) AS delta_mfcc_9_sensitivity,
ABS(AVG(CASE WHEN channel_quality = 'good' THEN delta_mfcc_10 END)-AVG(CASE WHEN channel_quality = 'poor' THEN delta_mfcc_10 END)) AS delta_mfcc_10_sensitivity,
ABS(AVG(CASE WHEN channel_quality = 'good' THEN delta_mfcc_11 END)-AVG(CASE WHEN channel_quality = 'poor' THEN delta_mfcc_11 END)) AS delta_mfcc_11_sensitivity,
ABS(AVG(CASE WHEN channel_quality = 'good' THEN delta_mfcc_12 END)-AVG(CASE WHEN channel_quality = 'poor' THEN delta_mfcc_12 END)) AS delta_mfcc_12_sensitivity,
ABS(AVG(CASE WHEN channel_quality = 'good' THEN delta_mfcc_13 END)-AVG(CASE WHEN channel_quality = 'poor' THEN delta_mfcc_13 END)) AS delta_mfcc_13_sensitivity,
ABS(AVG(CASE WHEN channel_quality = 'good' THEN centroid END)-AVG(CASE WHEN channel_quality = 'poor' THEN centroid END)) AS centroid_sensitivity,
ABS(AVG(CASE WHEN channel_quality = 'good' THEN flatness END)-AVG(CASE WHEN channel_quality = 'poor' THEN flatness END)) AS flatness_sensitivity,
ABS(AVG(CASE WHEN channel_quality = 'good' THEN ste END)-AVG(CASE WHEN channel_quality = 'poor' THEN ste END)) AS ste_sensitivity
FROM speech_features_clean

-- 6)	Outlier detection i.e. find rows where feature values are extremely high or low.
--Analysis based on global threshold
WITH my_cte AS(
	SELECT
		AVG(zcr) + 3*STDDEV(zcr) AS zcr_upper, AVG(zcr) - 3*STDDEV(zcr) AS zcr_lower,
		AVG(centroid) + 3*STDDEV(centroid) AS centroid_upper, AVG(centroid) - 3*STDDEV(centroid) AS centroid_lower,
		AVG(flatness) + 3*STDDEV(flatness) AS flatness_upper, AVG(flatness) - 3*STDDEV(flatness) AS flatness_lower,
		AVG(ste) + 3*STDDEV(ste) AS ste_upper, AVG(ste) - 3*STDDEV(ste) AS ste_lower	
	FROM speech_features_clean
)
SELECT * FROM speech_features_clean s
CROSS JOIN my_cte t
WHERE s.zcr > zcr_upper OR s.zcr < zcr_lower OR
	  s.centroid > centroid_upper OR s.centroid < centroid_lower OR
	  s.flatness > flatness_upper OR s.flatness < flatness_lower OR
	  s.ste > ste_upper OR s.ste < ste_lower 


--7) Group by snr and then calculate threshold per snr
WITH my_cte AS(
	SELECT snr,
		AVG(zcr) + 3*STDDEV(zcr) AS zcr_upper, AVG(zcr) - 3*STDDEV(zcr) AS zcr_lower,
		AVG(centroid) + 3*STDDEV(centroid) AS centroid_upper, AVG(centroid) - 3*STDDEV(centroid) AS centroid_lower,
		AVG(flatness) + 3*STDDEV(flatness) AS flatness_upper, AVG(flatness) - 3*STDDEV(flatness) AS flatness_lower,
		AVG(ste) + 3*STDDEV(ste) AS ste_upper, AVG(ste) - 3*STDDEV(ste) AS ste_lower	
	FROM speech_features_clean
	GROUP BY snr
)
SELECT * FROM speech_features_clean s
JOIN my_cte t
	ON s.snr = t.snr
WHERE s.zcr > zcr_upper OR s.zcr < zcr_lower OR
	  s.centroid > centroid_upper OR s.centroid < centroid_lower OR
	  s.flatness > flatness_upper OR s.flatness < flatness_lower OR
	  s.ste > ste_upper OR s.ste < ste_lower

--8) Add 'is_outlier' column
WITH my_cte2 AS (
WITH my_cte AS(
	SELECT snr,
		AVG(zcr) + 3*STDDEV(zcr) AS zcr_upper, AVG(zcr) - 3*STDDEV(zcr) AS zcr_lower,
		AVG(centroid) + 3*STDDEV(centroid) AS centroid_upper, AVG(centroid) - 3*STDDEV(centroid) AS centroid_lower,
		AVG(flatness) + 3*STDDEV(flatness) AS flatness_upper, AVG(flatness) - 3*STDDEV(flatness) AS flatness_lower,
		AVG(ste) + 3*STDDEV(ste) AS ste_upper, AVG(ste) - 3*STDDEV(ste) AS ste_lower	
	FROM speech_features_clean
	GROUP BY snr
)
SELECT * FROM speech_features_clean s
JOIN my_cte t
	ON s.snr = t.snr
WHERE s.zcr > zcr_upper OR s.zcr < zcr_lower OR
	  s.centroid > centroid_upper OR s.centroid < centroid_lower OR
	  s.flatness > flatness_upper OR s.flatness < flatness_lower OR
	  s.ste > ste_upper OR s.ste < ste_lower
)
SELECT file, snr, 
CASE WHEN file IN (SELECT file FROM my_cte2) THEN TRUE ELSE FALSE END AS is_outlier
FROM speech_features_clean

--9) Analysis of outliers i.e. count of outliers per snr.
SELECT sub.snr, sub.channel_quality, COUNT(*)
FROM (
    WITH my_cte AS(
	SELECT snr,
		AVG(zcr) + 3*STDDEV(zcr) AS zcr_upper, AVG(zcr) - 3*STDDEV(zcr) AS zcr_lower,
		AVG(centroid) + 3*STDDEV(centroid) AS centroid_upper, AVG(centroid) - 3*STDDEV(centroid) AS centroid_lower,
		AVG(flatness) + 3*STDDEV(flatness) AS flatness_upper, AVG(flatness) - 3*STDDEV(flatness) AS flatness_lower,
		AVG(ste) + 3*STDDEV(ste) AS ste_upper, AVG(ste) - 3*STDDEV(ste) AS ste_lower	
	FROM speech_features_clean
	GROUP BY snr)
	SELECT s.* FROM speech_features_clean AS s
	JOIN my_cte AS t
	ON s.snr = t.snr
	WHERE s.zcr > t.zcr_upper OR s.zcr < t.zcr_lower OR
	s.centroid > t.centroid_upper OR s.centroid < t.centroid_lower OR
	s.flatness > t.flatness_upper OR s.flatness < t.flatness_lower OR
	s.ste > t.ste_upper OR s.ste < t.ste_lower
	)sub
GROUP BY sub.snr, sub.channel_quality
ORDER BY sub.snr DESC;


-- 10)	Feature correlation Exploration. This helps detect redundant features like mfcc1 highly correlated with mfcc_2
SELECT 
CORR(mfcc_1,mfcc_2) AS corr_mfcc12,
CORR(mfcc_1,mfcc_3) AS corr_mfcc13,
CORR(zcr,flatness) AS corr_zcr_flatness,
CORR(zcr,centroid) AS corr_zcr_centroid
FROM speech_features_clean

-- 11) Create final datset for ML model traiing and classification.
CREATE TABLE speech_features_final_dataset AS
SELECT snr, mfcc_1, mfcc_2, mfcc_3, mfcc_4, mfcc_5, mfcc_6, mfcc_7, mfcc_8, mfcc_9, mfcc_10, mfcc_11, mfcc_12, mfcc_13,
delta_mfcc_1, delta_mfcc_2, delta_mfcc_3, delta_mfcc_4, delta_mfcc_5, delta_mfcc_6, delta_mfcc_7, delta_mfcc_8,
delta_mfcc_9, delta_mfcc_10, delta_mfcc_11, delta_mfcc_12, delta_mfcc_13, zcr, centroid, flatness, ste, channel_quality
FROM speech_features_clean

SELECT * FROM speech_features_final_dataset


