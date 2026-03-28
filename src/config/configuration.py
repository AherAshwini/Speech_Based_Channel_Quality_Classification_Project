from pathlib import Path
import os
from dataclasses import dataclass

### Path of downloaded data.
DATASET_PATH = Path("C:\\Users\\ahera\\Downloads\\Speech_channel_quality_project_downloaded_data\\archive")

### Number of selected audio files.
NUM_AUDIO_FILES = 5000

### Folders need to be ignored from raw dataset folder.
IGNORE_FOLDERS = ['_background_noise_']

### Below SNR levels are considered for this project.
SNR_LEVELS = [20, 10, 5]

#### Number of MFCC Features.
NUM_MFCC = 13

### Frame Length
FRAME_LENGTH = 2048

### Hop length
HOP_LENGTH = 512

### Create train, test datset paths.
@dataclass
class DataIngestionConfig:
    train_data_with_outliers_path: str = os.path.join("artifacts","train_with_outliers.csv")
    test_data_with_outliers_path: str = os.path.join("artifacts","test_with_outliers.csv")
    raw_data_with_outliers_path: str = os.path.join("artifacts","data_with_outliers.csv")

    train_data_without_outliers_path: str = os.path.join("artifacts","train_without_outliers.csv")
    test_data_without_outliers_path: str = os.path.join("artifacts","test_without_outliers.csv")
    raw_data_without_outliers_path: str = os.path.join("artifacts","data_without_outliers.csv")

    table1_name: str = "speech_data_with_outliers"
    table2_name: str = "speech_data_without_outliers"

