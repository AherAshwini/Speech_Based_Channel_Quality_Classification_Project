-- Create Table including speech features.

CREATE TABLE speech_features(
file VARCHAR NULL,
snr int NULL,
mfcc_1 FLOAT8 NULL,
mfcc_2 FLOAT8 NULL,
mfcc_3 FLOAT8 NULL,
mfcc_4 FLOAT8 NULL,
mfcc_5 FLOAT8 NULL,
mfcc_6 FLOAT8 NULL,
mfcc_7 FLOAT8 NULL,
mfcc_8 FLOAT8 NULL,
mfcc_9 FLOAT8 NULL,
mfcc_10 FLOAT8 NULL,
mfcc_11 FLOAT8 NULL,
mfcc_12 FLOAT8 NULL,
mfcc_13 FLOAT8 NULL,
delta_mfcc_1 FLOAT8 NULL,
delta_mfcc_2 FLOAT8 NULL,
delta_mfcc_3 FLOAT8 NULL,
delta_mfcc_4 FLOAT8 NULL,
delta_mfcc_5 FLOAT8 NULL,
delta_mfcc_6 FLOAT8 NULL,
delta_mfcc_7 FLOAT8 NULL,
delta_mfcc_8 FLOAT8 NULL,
delta_mfcc_9 FLOAT8 NULL,
delta_mfcc_10 FLOAT8 NULL,
delta_mfcc_11 FLOAT8 NULL,
delta_mfcc_12 FLOAT8 NULL,
delta_mfcc_13 FLOAT8 NULL,
zcr FLOAT8 NULL,
centroid FLOAT8 NULL,
flatness FLOAT8 NULL,
ste FLOAT8 NULL
)

CREATE TABLE speech_features_backup AS
SELECT * FROM speech_features

SELECT * FROM speech_features_backup




