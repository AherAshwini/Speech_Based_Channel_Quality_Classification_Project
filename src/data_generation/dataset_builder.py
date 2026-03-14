from src.data_generation.data_loader import get_random_audio_files
from src.config.config import DATASET_PATH, IGNORE_FOLDERS, NUM_AUDIO_FILES, SNR_LEVELS, NUM_MFCC, FRAME_LENGTH, HOP_LENGTH
from src.data_generation.channel_simulator import load_audio, add_awgn_noise
from src.data_generation.feature_extractor import extract_features
from src.logger import logger
import numpy as np
import pandas as pd

selected_audio_files = get_random_audio_files(DATASET_PATH, IGNORE_FOLDERS, NUM_AUDIO_FILES)

speech_signal_features = []

for i in range(len(selected_audio_files)):
    signal, sr = load_audio(selected_audio_files[i])
    file_name = f"file_{i+1}"
    for SNR in SNR_LEVELS:
        snr = SNR
        noisy_signal = add_awgn_noise(signal, snr_db=snr)
        mfcc, delta_mfcc, zcr, centroid, flatness, ste = extract_features(noisy_signal, sr, NUM_MFCC, FRAME_LENGTH, HOP_LENGTH)
        features = np.hstack([file_name, snr, mfcc,delta_mfcc,zcr,centroid,flatness,ste])
        speech_signal_features.append(features)

logger.info(f"Speech features are computed from selected audio files.")

columns = (["file", "snr"] + [f"mfcc_{i+1}" for i in range(13)] +
           [f"delta_mfcc_{i+1}" for i in range(13)] +
           ["zcr","centroid","flatness","ste"])

df = pd.DataFrame(speech_signal_features, columns=columns)

logger.info("Created dataframe containing speech features.")

df.to_csv("speech_features.csv", index=False)

logger.info("Dataframe converted into csv file: 'speech_features.csv'")

